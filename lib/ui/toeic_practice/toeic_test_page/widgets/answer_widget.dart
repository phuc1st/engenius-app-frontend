import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/question.dart';

class AnswerWidget extends StatelessWidget {
  /// Danh sách câu hỏi trong block hiện tại
  final List<Question> questions;

  /// Map số câu hỏi -> đáp án đã chọn
  final Map<int, int?> selectedAnswers;

  /// Callback khi user chọn đáp án, trả về số câu và đáp án
  final void Function(int questionId, int questionNumber, int option)
  onOptionSelected;

  const AnswerWidget({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(spreadRadius: 2, color: Colors.black26, blurRadius: 1),
        ],
      ),
      child: Column(
        children: [
          // Lặp qua từng question và render phần options
          for (var i = 0; i < questions.length; i++) ...[
            _buildQuestionSection(questions[i]),
            if (i != questions.length - 1) ...[
              const SizedBox(height: 16),
              const Divider(),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionSection(Question q) {
    final selected = selectedAnswers[q.id];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${q.number}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (q.text.isNotEmpty) ...[const SizedBox(height: 4), Text(q.text)],
        const SizedBox(height: 8),
        // Các lựa chọn
        /* ...q.options.map(
          (opt) => OptionTile(
            title: opt,
            value: 1,
            groupValue: selected,
            onOptionSelected: (val) {
              if (val != null) onOptionSelected(q.number, val);
            },
          ),
        ),*/
        for (int i = 0; i < q.options.length; i++) ...[
          OptionTile(
            title: q.options[i],
            value: i,
            groupValue: selected,
            onOptionSelected: (val) {
              if (val != null) onOptionSelected(q.id, q.number, val);
            },
          ),
        ],
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  final String title;
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onOptionSelected;

  const OptionTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onOptionSelected,
      visualDensity: const VisualDensity(vertical: -4),
    );
  }
}
