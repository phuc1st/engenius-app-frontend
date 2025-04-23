import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final String? selectedOption;
  final int questionNumber;
  const AnswerWidget({
    super.key,
    required this.onChanged,
    required this.selectedOption,
    required this.questionNumber
  });

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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Question $questionNumber",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          OptionTile(
            option: "A",
            groupValue: selectedOption,
            onChanged: (value) => onChanged(value),
          ),
          OptionTile(
            option: "B",
            groupValue: selectedOption,
            onChanged: (value) => onChanged(value),
          ),
          OptionTile(
            option: "C",
            groupValue: selectedOption,
            onChanged: (value) => onChanged(value),
          ),
          OptionTile(
            option: "D",
            groupValue: selectedOption,
            onChanged: (value) => onChanged(value),
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const OptionTile({
    super.key,
    required this.option,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      contentPadding: EdgeInsets.all(0),
      title: Text(option),
      value: option,
      groupValue: groupValue,
      onChanged: onChanged,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    );
  }
}
