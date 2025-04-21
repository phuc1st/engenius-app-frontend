import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isSentByMe;
  final String message;
  final void Function(String message) aiSpeak;
  final void Function(String message) userAudioPlay;

  const MessageBubble({
    super.key,
    required this.isSentByMe,
    required this.message,
    required this.aiSpeak,
    required this.userAudioPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            isSentByMe ? userAudioPlay(message) : aiSpeak(message);
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
