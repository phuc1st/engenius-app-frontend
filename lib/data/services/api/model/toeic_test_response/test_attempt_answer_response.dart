class TestAttemptAnswerResponse {
  int id;
  int questionId;
  int number;
  int selectedIndex;
  bool correct;

  TestAttemptAnswerResponse({
    required this.id,
    required this.questionId,
    required this.number,
    required this.selectedIndex,
    required this.correct
  });

  factory TestAttemptAnswerResponse.fromJson(Map<String, dynamic> json) {
    return TestAttemptAnswerResponse(
        id: json['id'],
        questionId: json['questionId'],
        number: json['number'],
        selectedIndex: json['selectedIndex'],
        correct: json['correct']);
  }
}