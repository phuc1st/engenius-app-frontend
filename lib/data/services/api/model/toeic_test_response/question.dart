class Question {
  final int id;
  final int number;
  final String? text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.id,
    required this.number,
    this.text,
    required this.options,
    required this.correctIndex
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json['id'] as int,
        number: json['number'] as int,
        text: json['text'] as String?,
        options: List<String>.from(json['options'] as List<dynamic>),
        correctIndex: json['correctIndex'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'options': options,
    };
  }
}
