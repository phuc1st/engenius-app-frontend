import 'dart:convert';

class ToeicTest {
  final String id;           // Nếu có ID lưu trong DB
  final String name;         // Tên đề thi
  final DateTime createdAt;  // Ngày tạo
  final List<ToeicPart> parts;

  ToeicTest({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.parts,
  });

  factory ToeicTest.fromJson(Map<String, dynamic> json) {
    return ToeicTest(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      parts: (json['parts'] as List<dynamic>)
          .map((e) => ToeicPart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'parts': parts.map((p) => p.toJson()).toList(),
    };
  }
}

class ToeicPart {
  final int partNumber;
  final List<QuestionBlock> blocks;

  ToeicPart({
    required this.partNumber,
    required this.blocks,
  });

  factory ToeicPart.fromJson(Map<String, dynamic> json) {
    return ToeicPart(
      partNumber: json['partNumber'] as int,
      blocks: (json['blocks'] as List<dynamic>)
          .map((e) => QuestionBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partNumber': partNumber,
      'blocks': blocks.map((b) => b.toJson()).toList(),
    };
  }
}

class QuestionBlock {
  final String? audioUrl;
  final String? imageUrl;
  final String? passage; // đoạn văn (passage)
  final List<Question> questions;

  QuestionBlock({
    this.audioUrl,
    this.imageUrl,
    this.passage,
    required this.questions,
  });

  factory QuestionBlock.fromJson(Map<String, dynamic> json) {
    return QuestionBlock(
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

class Question {
  final int number;
  final String text;
  final List<String> options;

  Question({
    required this.number,
    required this.text,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      number: json['number'] as int,
      text: json['text'] as String,
      options: List<String>.from(json['options'] as List<dynamic>),
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
