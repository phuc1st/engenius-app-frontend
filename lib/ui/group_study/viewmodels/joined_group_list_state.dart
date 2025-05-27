import 'package:toeic/data/services/api/model/study_group/group_node_response.dart';

class JoinedGroupListState {
  final bool isLoading;
  final String? error;
  final List<GroupNodeResponse> groups;
  final bool hasMore;

  const JoinedGroupListState({
    this.isLoading = false,
    this.error,
    this.groups = const [],
    this.hasMore = true,
  });

  JoinedGroupListState copyWith({
    bool? isLoading,
    String? error,
    List<GroupNodeResponse>? groups,
    bool? hasMore,
  }) {
    return JoinedGroupListState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      groups: groups ?? this.groups,
      hasMore: hasMore ?? this.hasMore,
    );
  }
} 