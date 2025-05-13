import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/private_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_task.dart';
import 'package:toeic/data/services/api/model/study_group/group_task_progress.dart';
import 'package:toeic/data/services/api/model/study_group/leaderboard_entry.dart';
import 'package:toeic/data/services/api/model/study_group/study_group.dart';
import 'package:toeic/utils/json_helpers.dart';

class StudyGroupApiClient extends PrivateBaseApiClient {
  StudyGroupApiClient({super.dio});

  Future<ApiResponse<StudyGroup>> createGroup(
    String name,
    String description,
    bool isPrivate,
    int maxMembers,
    String userId,
  ) async {
    return makeRequest(
      url: ApiConstants.studyGroups,
      method: 'POST',
      queryParameters: {
        'name': name,
        'description': description,
        'isPrivate': isPrivate,
        'maxMembers': maxMembers,
        'userId': userId,
      },
      fromJson: (json) => StudyGroup.fromJson(json),
    );
  }

  Future<ApiResponse<StudyGroup>> joinGroup(String code, String userId) async {
    return makeRequest(
      url: '${ApiConstants.studyGroups}/join',
      method: 'POST',
      queryParameters: {
        'code': code,
        'userId': userId,
      },
      fromJson: (json) => StudyGroup.fromJson(json),
    );
  }

  Future<ApiResponse<StudyGroup>> joinRandomGroup(String userId) async {
    return makeRequest(
      url: '${ApiConstants.studyGroups}/join-random',
      method: 'POST',
      queryParameters: {
        'userId': userId,
      },
      fromJson: (json) => StudyGroup.fromJson(json),
    );
  }

  Future<ApiResponse<List<StudyGroup>>> getUserGroups(String userId) async {
    return makeRequest(
      url: '${ApiConstants.studyGroups}/user/$userId',
      method: 'GET',
      fromJson: (json) => listFromJson(json, StudyGroup.fromJson),
    );
  }

  Future<ApiResponse<GroupTask>> createGroupTask(
    int groupId,
    String title,
    String description,
    int experiencePoints,
    DateTime dueDate,
    String userId,
  ) async {
    return makeRequest(
      url: ApiConstants.groupTasks,
      method: 'POST',
      queryParameters: {
        'groupId': groupId,
        'title': title,
        'description': description,
        'experiencePoints': experiencePoints,
        'dueDate': dueDate.toIso8601String(),
        'userId': userId,
      },
      fromJson: (json) => GroupTask.fromJson(json),
    );
  }

  Future<ApiResponse<GroupTaskProgress>> completeTask(int taskId, String userId) async {
    return makeRequest(
      url: '${ApiConstants.groupTasks}/$taskId/complete',
      method: 'POST',
      queryParameters: {
        'userId': userId,
      },
      fromJson: (json) => GroupTaskProgress.fromJson(json),
    );
  }

  Future<ApiResponse<List<GroupTask>>> getGroupTasks(int groupId) async {
    return makeRequest(
      url: '${ApiConstants.groupTasks}/group/$groupId',
      method: 'GET',
      fromJson: (json) => listFromJson(json, GroupTask.fromJson),
    );
  }

  Future<ApiResponse<List<GroupTaskProgress>>> getTaskProgress(int taskId) async {
    return makeRequest(
      url: '${ApiConstants.groupTasks}/$taskId/progress',
      method: 'GET',
      fromJson: (json) => listFromJson(json, GroupTaskProgress.fromJson),
    );
  }

  Future<ApiResponse<List<LeaderboardEntry>>> getGroupLeaderboard(int groupId) async {
    return makeRequest(
      url: '${ApiConstants.groupTasks}/group/$groupId/leaderboard',
      method: 'GET',
      fromJson: (json) => listFromJson(json, LeaderboardEntry.fromJson),
    );
  }

  Future<ApiResponse<StudyGroup>> getGroupDetail(int groupId) async {
    return makeRequest(
      url: '${ApiConstants.studyGroups}/$groupId',
      method: 'GET',
      fromJson: (json) => StudyGroup.fromJson(json),
    );
  }
}

final studyGroupApiClientProvider = Provider<StudyGroupApiClient>((ref) {
  return StudyGroupApiClient();
}); 