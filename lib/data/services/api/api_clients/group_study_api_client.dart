import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_create_request.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_response.dart';

class GroupStudyApiClient extends BaseApiClient {
  GroupStudyApiClient() : super();

  Future<ApiResponse<GroupStudyResponse>> createGroup(GroupStudyCreateRequest request, {File? avatar}) async {
    final formData = FormData.fromMap({
      'name': request.name,
      'description': request.description,
      if (avatar != null)
        'avatar': await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        ),
    });
    return makeRequest<GroupStudyResponse>(
      headers: {'Content-Type': 'multipart/form-data'},
      url: ApiConstants.groupStudy,
      method: 'POST',
      body: formData,
      fromJson: (json) => GroupStudyResponse.fromJson(json),
      useToken: true,
    );
  }

  Future<ApiResponse<List<GroupNodeResponse>>> getGroups({
    required int page,
    required int size,
    String? searchQuery,
  }) async {
    final queryParams = {
      'page': page,
      'size': size,
      if (searchQuery != null) 'searchQuery': searchQuery,
    };

    return makeRequest<List<GroupNodeResponse>>(
      url: ApiConstants.groupEndPoint,
      method: 'GET',
      queryParameters: queryParams,
      fromJson: (json) => (json as List)
          .map((item) => GroupNodeResponse.fromJson(item))
          .toList(),
      useToken: true,
    );
  }

  Future<ApiResponse<void>> joinGroup(String groupId) async {
    return makeRequest<void>(
      url: '${ApiConstants.groupEndPoint}/$groupId/join',
      method: 'POST',
      useToken: true,
      fromJson: (j){}
    );
  }
} 