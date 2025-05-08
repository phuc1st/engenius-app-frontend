import 'package:toeic/data/services/api/model/daily_task/daily_task.dart';

class DailyTasksState {
  final List<DailyTask> tasks;
  final bool isLoading;
  final String? errorMessage;
  final int completedTasks;
  final int totalTasks;
  final int experiencePoints;

  DailyTasksState({
    required this.tasks,
    this.isLoading = false,
    this.errorMessage,
    this.completedTasks = 0,
    this.totalTasks = 0,
    this.experiencePoints = 0,
  });

  factory DailyTasksState.initial() {
    return DailyTasksState(
      tasks: [],
      isLoading: true,
    );
  }

  DailyTasksState copyWith({
    List<DailyTask>? tasks,
    bool? isLoading,
    String? errorMessage,
    int? completedTasks,
    int? totalTasks,
    int? experiencePoints,
  }) {
    return DailyTasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      completedTasks: completedTasks ?? this.completedTasks,
      totalTasks: totalTasks ?? this.totalTasks,
      experiencePoints: experiencePoints ?? this.experiencePoints,
    );
  }
} 