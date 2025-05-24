import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_create_request.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_response.dart';
import 'package:toeic/utils/result.dart';
import 'create_group_state.dart';

class CreateGroupViewModel extends StateNotifier<CreateGroupState> {
  final GroupStudyRepository _repository;

  CreateGroupViewModel({GroupStudyRepository? repository})
      : _repository = repository ?? GroupStudyRepository(),
        super(const CreateGroupState());

  Future<bool> createGroup({
    required String name,
    required String description,
    File? avatar,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = GroupStudyCreateRequest(
        name: name,
        description: description,
      );

      final response = await _repository.createGroup(request, avatar);

      state = state.copyWith(isLoading: false);

      if (response is Ok<GroupStudyResponse>) {
        return true;
      } else if (response is Error<GroupStudyResponse>) {
        state = state.copyWith(error: response.error.toString());
        return false;
      }
      // Trường hợp không thuộc Ok hoặc Error
      state = state.copyWith(error: 'Unexpected response type');
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
} 