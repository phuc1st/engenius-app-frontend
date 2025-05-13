import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/daily_task_api_client.dart';
import 'package:toeic/data/services/api/model/daily_task/daily_task.dart';
import 'package:toeic/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyTaskRepository extends BaseRepository {
  final DailyTaskApiClient _dailyTaskApiClient;

  DailyTaskRepository({required DailyTaskApiClient dailyTaskApiClient})
      : _dailyTaskApiClient = dailyTaskApiClient;

  Future<Result<List<DailyTask>>> getDailyTasks(String userId) async {
    final apiResponse = await _dailyTaskApiClient.getDailyTasks(userId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<DailyTask>> completeTask(int taskId, String userId) async {
    final apiResponse = await _dailyTaskApiClient.completeTask(taskId, userId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<DailyTask>> getTaskProgress(String userId) async {
    final apiResponse = await _dailyTaskApiClient.getTaskProgress(userId);
    return handleApiResponse(apiResponse);
  }
}

final dailyTaskRepositoryProvider = Provider<DailyTaskRepository>((ref) {
  final apiClient = ref.watch(dailyTaskApiClientProvider);
  return DailyTaskRepository(dailyTaskApiClient: apiClient);
}); 