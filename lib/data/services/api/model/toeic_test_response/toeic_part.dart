import 'package:toeic/data/services/api/model/toeic_test_response/question_block.dart';

class ToeicPart {
  int id;
  final int partNumber;
  final List<QuestionBlock> blocks;

  ToeicPart({
    required this.id,
    required this.partNumber,
    required this.blocks,
  });

  factory ToeicPart.fromJson(Map<String, dynamic> json) {
    return ToeicPart(
      id: json['id'] as int,
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
