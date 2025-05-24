import 'dart:io';
import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/group_study_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_create_request.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_response.dart';
import 'package:toeic/utils/result.dart';

class GroupStudyRepository extends BaseRepository{
  final GroupStudyApiClient _apiClient;

  GroupStudyRepository({GroupStudyApiClient? apiClient})
      : _apiClient = apiClient ?? GroupStudyApiClient();

  Future<Result<GroupStudyResponse>> createGroup(
    GroupStudyCreateRequest request,
    File? avatar,
  ) async {
    final apiResponse = await _apiClient.createGroup(request, avatar: avatar);
    return handleApiResponse(apiResponse);
  }

  Future<Result<List<GroupNodeResponse>>> getGroups({
    required int page,
    required int size,
    String? searchQuery,
  }) async {
    final apiResponse = await _apiClient.getGroups(
      page: page,
      size: size,
      searchQuery: searchQuery,
    );
    return handleApiResponse(apiResponse);
  }

  Future<Result<void>> joinGroup(String groupId) async {
    final apiResponse = await _apiClient.joinGroup(groupId);
    return handleApiResponse(apiResponse);
  }
} 