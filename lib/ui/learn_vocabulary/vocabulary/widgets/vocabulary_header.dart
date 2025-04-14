import 'package:flutter/material.dart';

class VocabularyHeader extends StatelessWidget {
  const VocabularyHeader({super.key, required this.numTest, required this.accuracy});

  final int numTest;
  final int accuracy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFB9B5F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.menu_book_rounded, size: 32),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  'TOEIC VOCABULARY (BY TOPIC)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF756EF3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '$numTest TESTS - $accuracy% CHÍNH XÁC',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
