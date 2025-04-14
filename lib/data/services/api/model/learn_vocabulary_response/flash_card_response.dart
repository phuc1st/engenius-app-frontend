class FlashCardResponse {
  final String id;
  final String image;
  final String word;
  final String phonetic;
  final String audio;
  final String answer;
  bool memorized;

  FlashCardResponse({
    required this.id,
    required this.image,
    required this.word,
    required this.phonetic,
    required this.audio,
    required this.answer,
    required this.memorized,
  });

  factory FlashCardResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'image': String image,
        'word': String word,
        'phonetic': String phonetic,
        'audio': String audio,
        'answer': String answer,
        'memorized': bool memorized,
      } =>
        FlashCardResponse(
          id: id,
          image: image,
          word: word,
          phonetic: phonetic,
          audio: audio,
          answer: answer,
          memorized: memorized,
        ),
      _ =>
        throw const FormatException(
          "Invalid flash_card_response.dart response format",
        ),
    };
  }
}
