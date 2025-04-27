import 'package:toeic/data/services/api/model/toeic_practice/toeic_part.dart';

class ToeicTest {
  final int id;           // Nếu có ID lưu trong DB
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
      id: json['id'] as int,
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



