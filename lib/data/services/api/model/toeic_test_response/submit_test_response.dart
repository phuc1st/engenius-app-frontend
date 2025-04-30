class SubmitTestResponse {
  final int correctCount;
  final int totalQuestion;
  final double score;

  SubmitTestResponse({
    required this.correctCount,
    required this.totalQuestion,
    required this.score,
  });

  factory SubmitTestResponse.fromJson(Map<String, dynamic> json) {
    return SubmitTestResponse(
      correctCount: json['correctCount'],
      totalQuestion: json['totalQuestion'],
      score: json['score'],
    );
  }
}
