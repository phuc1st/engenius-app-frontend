import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/toeic_practice/question.dart';

class AnswerWidget extends StatelessWidget {
  /// Danh sách câu hỏi trong block hiện tại
  final List<Question> questions;

  /// Map số câu hỏi -> đáp án đã chọn
  final Map<int, String?> selectedAnswers;

  /// Callback khi user chọn đáp án, trả về số câu và đáp án
  final void Function(int questionNumber, String option) onOptionSelected;

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
          BoxShadow(
            spreadRadius: 2,
            color: Colors.black26,
            blurRadius: 1,
          ),
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
    final selected = selectedAnswers[q.number];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${q.number}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (q.text.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(q.text),
        ],
        const SizedBox(height: 8),
        // Các lựa chọn
        ...q.options.map(
              (opt) => OptionTile(
            option: opt,
            groupValue: selected,
            onOptionSelected: (val) {
              if (val != null) onOptionSelected(q.number, val);
            },
          ),
        ),
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  final String? groupValue;
  final ValueChanged<String?> onOptionSelected;

  const OptionTile({
    super.key,
    required this.option,
    required this.groupValue,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.zero,
      title: Text(option),
      value: option,
      groupValue: groupValue,
      onChanged: onOptionSelected,
      visualDensity: const VisualDensity(vertical: -4),
    );
  }
}
