import 'package:flutter/material.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/audio_player.dart';

class QuestionWidget extends StatelessWidget {
  final String? audioUrl;
  final String? imageUrl;

  const QuestionWidget({super.key, this.audioUrl, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
            spreadRadius: 2,
            color: Colors.black26,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bản ghi âm",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          AudioPlayerWidget(audioUrl: audioUrl!),
          const SizedBox(height: 16),
          // Hình ảnh (placeholder)
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(20), // Bo góc tại đây
            child: Image.asset(imageUrl!, fit: BoxFit.contain, height: 150),
          ),
        ],
      ),
    );
  }
}
