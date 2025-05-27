import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/model/study_group/group_message_response.dart';
import 'package:toeic/provider/study_group_provider.dart';
import 'package:toeic/ui/group_study/viewmodels/group_chat_state.dart';
import 'package:toeic/utils/app_colors.dart';
import 'package:toeic/utils/app_text_styles.dart';
import 'package:toeic/utils/gradient_app_bar.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class GroupChatScreen extends ConsumerStatefulWidget {
  final String groupId;
  final String groupName;
  final String userId;
  final String senderName;

  const GroupChatScreen({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.userId,
    required this.senderName,
  });

  @override
  ConsumerState<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends ConsumerState<GroupChatScreen> {
  late WebSocketChannel channel;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(groupChatViewModelProvider.notifier)
          .loadMessages(groupId: widget.groupId, refresh: true);
    });
    channel = WebSocketChannel.connect(
      Uri.parse(
        '${ApiConstants.chatSocket}/ws?userId=${widget.userId}&groupId=${widget.groupId}',
      ),
    );
    channel.stream.listen((data) {
      final msg = json.decode(data);
      print("mssg $msg");
      print("data: $data");
      if (msg['type'] == 'chat') {
        final message = GroupMessageResponse(
          id: "",
          content: msg["content"],
          senderId: msg["from"],
          senderName: msg["senderName"],
          createdAt: DateTime.parse(msg["createdAt"]),
          groupId: msg["groupId"],
        );
        // final message = GroupMessageResponse.fromJson(msg);
        ref
            .read(groupChatViewModelProvider.notifier)
            .addRealtimeMessage(message);
        _scrollToBottom();
      }
    });
    _scrollController.addListener(() {
      final state = ref.read(groupChatViewModelProvider);
      // Load-more khi kéo lên đầu
      if (_scrollController.position.pixels <= 0 &&
          !state.isLoading &&
          state.hasMore) {
        ref
            .read(groupChatViewModelProvider.notifier)
            .loadMessages(groupId: widget.groupId, refresh: false);
      }
      // Hiện nút scroll-to-bottom nếu cách cuối danh sách > 300px
      if (_scrollController.hasClients) {
        final distanceToBottom =
            _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (distanceToBottom > 300 && !_showScrollToBottomButton) {
          setState(() => _showScrollToBottomButton = true);
        } else if (distanceToBottom <= 300 && _showScrollToBottomButton) {
          setState(() => _showScrollToBottomButton = false);
        }
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    final content = _messageController.text.trim();
    final msg = {
      "type": "chat",
      "groupId": widget.groupId,
      "from": widget.userId,
      "senderName": widget.senderName,
      "content": content,
    };
    channel.sink.add(json.encode(msg));
    _messageController.clear();
  }

  void _scrollToBottom({bool animated = true}) async {
    if (_scrollController.hasClients) {
      if (animated) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration:
              animated ? const Duration(milliseconds: 1000) : Duration.zero,
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      if (mounted) {
        setState(() => _showScrollToBottomButton = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupChatViewModelProvider);
    final messages = state.messages;
    ref.listen<GroupChatState>(groupChatViewModelProvider, (previous, next) {
      // Khi tin nhắn mới được load lần đầu
      if ((previous?.messages.isEmpty ?? true) && next.messages.isNotEmpty) {
        _scrollToBottom(animated: false);
      }
    });
    print('Messages: ${state.messages}');

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          widget.groupName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.primaryGradient,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child:
                      state.isLoading && messages.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isMe = message.senderId == widget.userId;
                              return Align(
                                alignment:
                                    isMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isMe ? AppColors.primary : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!isMe)
                                        Text(
                                          message.senderName,
                                          style: AppTextStyles.labelSmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      Text(
                                        message.content,
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                              color:
                                                  isMe
                                                      ? Colors.white
                                                      : AppColors.textPrimary,
                                            ),
                                      ),
                                      if (message.createdAt != null)
                                        Text(
                                          DateFormat(
                                            'HH:mm',
                                          ).format(message.createdAt.toLocal()),
                                          style: AppTextStyles.labelSmall
                                              .copyWith(
                                                color:
                                                    isMe
                                                        ? Colors.white70
                                                        : AppColors
                                                            .textSecondary,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
                _buildMessageInput(),
              ],
            ),
          ),
          if (_showScrollToBottomButton)
            Positioned(
              right: 16,
              bottom: 80,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: AppColors.primary,
                onPressed: () {
                  _scrollToBottom(animated: true);
                },
                child: const Icon(Icons.arrow_downward, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Nhập tin nhắn...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              maxLines: 5,
              minLines: 1,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
