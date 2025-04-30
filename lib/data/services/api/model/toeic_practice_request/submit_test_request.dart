class SubmitTestRequest {
  final int testId;
  final String userId;
  final List<Answer> answers;

  SubmitTestRequest({
    required this.testId,
    required this.userId,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "testId": testId,
      "userId": userId,
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
