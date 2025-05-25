import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/utils/result.dart';
import 'joined_group_list_state.dart';

class JoinedGroupListViewModel extends StateNotifier<JoinedGroupListState> {
  final GroupStudyRepository _repository;
  int _currentPage = 0;

  JoinedGroupListViewModel({GroupStudyRepository? repository})
      : _repository = repository ?? GroupStudyRepository(),
        super(const JoinedGroupListState());

  Future<void> loadGroups({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      _currentPage = 0;
      state = state.copyWith(groups: [], hasMore: true);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getJoinedGroups(
        page: _currentPage,
        size: 10,
      );

      if (response is Ok<List<GroupNodeResponse>>) {
        final newGroups = response.value;
        state = state.copyWith(
          groups: [...state.groups, ...newGroups],
          hasMore: newGroups.length == 10,
          isLoading: false,
        );
        _currentPage++;
      } else if (response is Error<List<GroupNodeResponse>>) {
        state = state.copyWith(
          error: response.error.toString(),
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
} 