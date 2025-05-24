import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_response.dart';
import 'package:toeic/utils/result.dart';
import 'group_list_state.dart';

class GroupListViewModel extends StateNotifier<GroupListState> {
  final GroupStudyRepository _repository;
  int _currentPage = 0;
  String? _searchQuery;

  GroupListViewModel({GroupStudyRepository? repository})
      : _repository = repository ?? GroupStudyRepository(),
        super(const GroupListState());

  Future<void> loadGroups({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      _currentPage = 0;
      state = state.copyWith(groups: [], hasMore: true);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getGroups(
        page: _currentPage,
        size: 10,
        searchQuery: _searchQuery,
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

  Future<void> searchGroups(String query) async {
    _searchQuery = query.isEmpty ? null : query;
    await loadGroups(refresh: true);
  }

  Future<bool> joinGroup(String groupId) async {
    state = state.copyWith(error: null);

    try {
      final response = await _repository.joinGroup(groupId);

      if (response is Ok) {
        // Refresh the list to update joined status
        await loadGroups(refresh: true);
        return true;
      } else if (response is Error) {
        state = state.copyWith(error: response.error.toString());
        return false;
      }
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
} 