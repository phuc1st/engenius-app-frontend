import 'dart:async';
import 'package:flutter/material.dart';

class TestTimerText extends StatefulWidget {
  final Duration initialTime;
  final VoidCallback onCountdownFinished; // 👈 Thêm callback ở đây

  const TestTimerText({
    super.key,
    required this.initialTime,
    required this.onCountdownFinished,
  });

  @override
  State<TestTimerText> createState() => _TestTimerTextState();
}

class _TestTimerTextState extends State<TestTimerText> {
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.initialTime;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      } else {
        t.cancel(); // Dừng khi hết giờ
        widget.onCountdownFinished();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes =
    (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds =
    (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatDuration(remainingTime),
      textAlign: TextAlign.end,
      style: const TextStyle(fontSize: 16),
    );
  }
}
