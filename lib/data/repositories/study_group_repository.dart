import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/study_group_api_client.dart';
import 'package:toeic/data/services/api/model/study_group/study_group.dart';
import 'package:toeic/data/services/api/model/study_group/group_task.dart';
import 'package:toeic/data/services/api/model/study_group/group_task_progress.dart';
import 'package:toeic/data/services/api/model/study_group/leaderboard_entry.dart';
import 'package:toeic/utils/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyGroupRepository  extends BaseRepository {
  final StudyGroupApiClient apiClient;

  StudyGroupRepository(this.apiClient);

  Future<Result<StudyGroup>> getGroupDetail(int groupId) async {
    final res = await apiClient.getGroupDetail(groupId);
    return handleApiResponse(res);
  }

  Future<Result<List<GroupTask>>> getGroupTasks(int groupId) async {
    final res = await apiClient.getGroupTasks(groupId);
    return handleApiResponse(res);
  }

  Future<Result<GroupTaskProgress>> completeTask(int taskId,
      String userId) async {
    final res = await apiClient.completeTask(taskId, userId);
    return handleApiResponse(res);
  }

  Future<Result<GroupTask>> createGroupTask({
    required int groupId,
    required String title,
    required String description,
    required int experiencePoints,
    required DateTime dueDate,
    required String userId,
  }) async {
    final res = await apiClient.createGroupTask(
      groupId,
      title,
      description,
      experiencePoints,
      dueDate,
      userId,
    );
    return handleApiResponse(res);
  }

  Future<Result<List<GroupTaskProgress>>> getTaskProgress(int taskId) async {
    final res = await apiClient.getTaskProgress(taskId);
    return handleApiResponse(res);
  }

  Future<Result<List<LeaderboardEntry>>> getGroupLeaderboard(
      int groupId) async {
    final res = await apiClient.getGroupLeaderboard(groupId);
    return handleApiResponse(res);
  }

  Future<Result<List<StudyGroup>>> getUserGroups(String userId) async {
    final res = await apiClient.getUserGroups(userId);
    return handleApiResponse(res);
  }

  Future<Result<StudyGroup>> createGroup({
    required String name,
    required String description,
    required bool isPrivate,
    required int maxMembers,
    required String userId,
  }) async {
    final res = await apiClient.createGroup(
      name,
      description,
      isPrivate,
      maxMembers,
      userId,
    );
    return handleApiResponse(res);
  }

  Future<Result<StudyGroup>> joinGroup({
    required String code,
    required String userId,
  }) async {
    final res = await apiClient.joinGroup(code, userId);
    return handleApiResponse(res);
  }

  Future<Result<StudyGroup>> joinRandomGroup({
    required String userId,
  }) async {
    final res = await apiClient.joinRandomGroup(userId);
    return handleApiResponse(res);
  }
}

final studyGroupRepositoryProvider = Provider<StudyGroupRepository>((ref) {
  return StudyGroupRepository(ref.watch(studyGroupApiClientProvider));
}); 