import 'package:flutter/material.dart';

class FlashcardCounter extends StatelessWidget {
  final int left;
  final int right;

  const FlashcardCounter({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 22,
          child: Text("$left",
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 22,
          child: Text("$right",
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }
}
