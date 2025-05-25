import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/group_study_repository.dart';
import 'package:toeic/data/services/api/model/study_group/group_message_response.dart';
import 'package:toeic/utils/result.dart';
import 'group_chat_state.dart';

class GroupChatViewModel extends StateNotifier<GroupChatState> {
  final GroupStudyRepository _repository;
  int _currentPage = 0;

  GroupChatViewModel({GroupStudyRepository? repository})
      : _repository = repository ?? GroupStudyRepository(),
        super(const GroupChatState());

  Future<void> loadMessages({
    required String groupId,
    bool refresh = false,
    int size = 20,
  }) async {
    if (state.isLoading) return;
    print('Số lượng message 1: ${state.messages.length}');
    if (refresh) {
      _currentPage = 0;
      state = state.copyWith(messages: [], hasMore: true);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getGroupMessages(
        groupId: groupId,
        page: _currentPage,
        size: size,
      );
      if (response is Ok<List<GroupMessageResponse>>) {
        final newMessages = response.value;
        List<GroupMessageResponse> updatedMessages;
        if (refresh) {
          updatedMessages = newMessages;
        } else {
          updatedMessages = [...newMessages, ...state.messages];
        }
        state = state.copyWith(
          messages: updatedMessages,
          hasMore: newMessages.length == size,
          isLoading: false,
        );
        print('Số lượng message: ${state.messages.length}');
        _currentPage++;
      } else if (response is Error<List<GroupMessageResponse>>) {
        print("Lỗi err ${response.error}");
        state = state.copyWith(
          error: response.error.toString(),
          isLoading: false,
        );
      }
    } catch (e) {
      print("Lỗi err2");

      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void addRealtimeMessage(GroupMessageResponse message) {
    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  Future<void> sendMessage({
    required String groupId,
    required String content,
  }) async {
    try {
      final response = await _repository.sendMessage(
        groupId: groupId,
        content: content,
      );

      if (response is Ok<GroupMessageResponse>) {
        final newMessage = response.value;
        state = state.copyWith(
          messages: [newMessage, ...state.messages],
        );
      } else if (response is Error<GroupMessageResponse>) {
        state = state.copyWith(error: response.error.toString());
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
} 