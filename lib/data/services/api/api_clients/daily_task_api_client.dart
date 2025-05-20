import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/daily_task/daily_task.dart';
import 'package:toeic/utils/json_helpers.dart';

class DailyTaskApiClient extends BaseApiClient {
  DailyTaskApiClient({super.dio});

  Future<ApiResponse<List<DailyTask>>> getDailyTasks(String userId) async {
    return makeRequest(
      url: '${ApiConstants.dailyTasks}/$userId',
      method: 'GET',
      fromJson: (json) => listFromJson(json, DailyTask.fromJson),
    );
  }

  Future<ApiResponse<DailyTask>> completeTask(int taskId, String userId) async {
    return makeRequest(
      url: '${ApiConstants.dailyTasks}/$taskId/complete/$userId',
      method: 'POST',
      fromJson: (json) => DailyTask.fromJson(json),
    );
  }

  Future<ApiResponse<DailyTask>> getTaskProgress(String userId) async {
    return makeRequest(
      url: '${ApiConstants.dailyTaskProgress}/$userId',
      method: 'GET',
      fromJson: (json) => DailyTask.fromJson(json),
    );
  }
}

final dailyTaskApiClientProvider = Provider<DailyTaskApiClient>((ref) {
  return DailyTaskApiClient();
}); 