import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/ui/AIConversation/view_models/ai_chat_screen_state.dart';
import 'package:toeic/ui/AIConversation/view_models/ai_chat_view_model.dart';
import 'package:toeic/ui/AIConversation/widgets/input_field.dart';
import 'package:toeic/ui/AIConversation/widgets/typing_bubble.dart';
import 'package:toeic/ui/AIConversation/widgets/voice_message_bubble.dart';
class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final voiceMessageList = ref.watch(
      chatProvider.select((s) => s.voiceMessageList),
    );
    final isWaitingAIReply = ref.watch(
      chatProvider.select((s) => s.isWaitingAIReply),
    );
    final permissionToAISpeak = ref.watch(
      chatProvider.select((s) => s.permissionToAISpeak),
    );

    ref.listen<AIChatScreenState>(chatProvider, (previous, next) {
      if (previous?.voiceMessageList != next.voiceMessageList) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        title: const Text(
          'Trúc cute',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed:
                ref.read(chatProvider.notifier).togglePermissionToAISpeak,
            icon: Icon(
              permissionToAISpeak
                  ? Icons.volume_up_sharp
                  : Icons.volume_off_sharp,
            ),
            color: Color(0xFF256DFF),
          ),
          SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Icon(
              permissionToAISpeak
                  ? Icons.volume_up_sharp
                  : Icons.volume_off_sharp,
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: voiceMessageList.length + (isWaitingAIReply ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < voiceMessageList.length) {
                  final chat = voiceMessageList[index];
                  return MessageBubble(
                    isSentByMe: chat.isMe,
                    message: chat.message,
                  );
                } else {
                  return const TypingBubble(); // Thêm TypingBubble cuối
                }
              },
            ),
          ),
          InputField(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }

  void _sendMessage() {
    final msg = _controller.text.trim();
    if (msg.isNotEmpty) {
      ref.read(chatProvider.notifier).sendMessage(msg);
      _controller.clear();
    }
  }
}
// TODO thêm cái permissionAiSpeak, write function speak, if permission is true ai will speak otherwise mute.
//  thêm cái auto send message or không