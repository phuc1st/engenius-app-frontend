

import 'package:toeic/data/services/api/model/toeic_test_response/question.dart';

class QuestionBlock {
  final int id;
  final String? audioUrl;
  final String? imageUrl;
  final String? passage; // đoạn văn (passage)
  final List<Question> questions;

  QuestionBlock({
    required this.id,
    this.audioUrl,
    this.imageUrl,
    this.passage,
    required this.questions,
  });

  factory QuestionBlock.fromJson(Map<String, dynamic> json) {
    return QuestionBlock(
      id: json['id'] as int,
      audioUrl: json['audioUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      passage: json['passage'] as String?,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'passage': passage,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
