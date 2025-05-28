import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/daily_task/daily_task_repository.dart';
import 'package:toeic/data/services/api/model/daily_task/daily_task.dart';
import 'package:toeic/ui/daily_tasks/view_models/daily_tasks_state.dart';
import 'package:toeic/utils/result.dart';

class DailyTasksViewModel extends StateNotifier<DailyTasksState> {
  final DailyTaskRepository _repository;

  DailyTasksViewModel({
    required DailyTaskRepository repository,
  }) : _repository = repository,
       super(DailyTasksState.initial());

  Future<void> loadDailyTasks() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _repository.getDailyTasks();
    if (result is Ok<List<DailyTask>>) {
      final tasks = result.value;
      final completedTasks = tasks.where((task) => task.isCompleted).length;
      final totalTasks = tasks.length;
      final experiencePoints = tasks
          .where((task) => task.isCompleted)
          .fold(0, (sum, task) => sum + task.experiencePoints);

      state = state.copyWith(
        tasks: tasks,
        isLoading: false,
        completedTasks: completedTasks,
        totalTasks: totalTasks,
        experiencePoints: experiencePoints,
      );
    } else if (result is Error<List<DailyTask>>) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.error.toString(),
      );
    }
  }

  Future<void> completeTask(int taskId) async {
    final result = await _repository.completeTask(taskId);
    if (result is Ok<DailyTask>) {
      final completedTask = result.value;
      final updatedTasks = state.tasks.map((task) {
        if (task.id == taskId) {
          return completedTask;
        }
        return task;
      }).toList();

      final completedTasks = updatedTasks.where((task) => task.isCompleted).length;
      final experiencePoints = updatedTasks
          .where((task) => task.isCompleted)
          .fold(0, (sum, task) => sum + task.experiencePoints);

      state = state.copyWith(
        tasks: updatedTasks,
        completedTasks: completedTasks,
        experiencePoints: experiencePoints,
      );
    } else if (result is Error<DailyTask>) {
      state = state.copyWith(errorMessage: result.error.toString());
    }
  }
}

final dailyTasksProvider = StateNotifierProvider<DailyTasksViewModel, DailyTasksState>((ref) {
  final repository = ref.watch(dailyTaskRepositoryProvider);
  return DailyTasksViewModel(repository: repository);
}); 