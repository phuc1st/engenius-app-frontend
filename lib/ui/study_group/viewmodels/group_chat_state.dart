import 'package:toeic/data/services/api/model/study_group/group_message_response.dart';

class GroupChatState {
  final bool isLoading;
  final String? error;
  final List<GroupMessageResponse> messages;
  final bool hasMore;

  const GroupChatState({
    this.isLoading = false,
    this.error,
    this.messages = const [],
    this.hasMore = true,
  });

  GroupChatState copyWith({
    bool? isLoading,
    String? error,
    List<GroupMessageResponse>? messages,
    bool? hasMore,
  }) {
    return GroupChatState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      messages: messages ?? this.messages,
      hasMore: hasMore ?? this.hasMore,
    );
  }
} 