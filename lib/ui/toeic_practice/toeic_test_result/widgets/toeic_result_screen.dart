import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/submit_test_response.dart';
import 'package:toeic/routing/routes.dart';

class ToeicTestResultScreen extends StatelessWidget {
  final SubmitTestResponse result;

  const ToeicTestResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final int incorrectAnswers = result.totalQuestion - result.correctCount;
    final int score = (result.score * 9.90).round(); // TOEIC scale max 990

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Kết Quả Bài Thi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                'Hoàn thành bài thi!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              _buildResultRow('Tổng số câu:', result.totalQuestion),
              _buildResultRow('Trả lời đúng:', result.correctCount),
              _buildResultRow('Trả lời sai:', incorrectAnswers),
              _buildResultRow('Điểm số:', score, valueColor: Colors.blue),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed:
                        () =>
                            Navigator.pushNamed(context, Routes.listToeicPractice),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Làm lại bài'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, Routes.home),
                    icon: const Icon(Icons.home),
                    label: const Text('Trang chính'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(
    String label,
    int value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(
            '$value',
            style: TextStyle(
              fontSize: 18,
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
