import 'package:flutter/material.dart';

class FlashcardProgress extends StatelessWidget {
  final int rightCount;
  final int total;

  const FlashcardProgress({
    super.key,
    required this.rightCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : rightCount / total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("$rightCount/$total", style: const TextStyle(color: Colors.blue)),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
