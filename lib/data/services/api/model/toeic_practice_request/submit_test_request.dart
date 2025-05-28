class SubmitTestRequest {
  final int testId;
  final List<Answer> answers;

  SubmitTestRequest({
    required this.testId,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "testId": testId,
      "answers": answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class Answer {
  final int questionId;
  final int selectedIndex;

  Answer({
    required this.questionId,
    required this.selectedIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "selectedIndex": selectedIndex,
    };
  }
}
