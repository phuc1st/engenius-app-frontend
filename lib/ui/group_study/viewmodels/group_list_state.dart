import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';
import 'package:toeic/data/services/api/model/study_group/group_study_response.dart';

class GroupListState {
  final bool isLoading;
  final String? error;
  final List<GroupNodeResponse> groups;
  final bool hasMore;
  final bool isSearching;

  const GroupListState({
    this.isLoading = false,
    this.error,
    this.groups = const [],
    this.hasMore = true,
    this.isSearching = false,
  });

  GroupListState copyWith({
    bool? isLoading,
    String? error,
    List<GroupNodeResponse>? groups,
    bool? hasMore,
    bool? isSearching,
  }) {
    return GroupListState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      groups: groups ?? this.groups,
      hasMore: hasMore ?? this.hasMore,
      isSearching: isSearching ?? this.isSearching,
    );
  }
} 