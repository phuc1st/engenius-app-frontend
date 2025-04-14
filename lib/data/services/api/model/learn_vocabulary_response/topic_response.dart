class TopicResponse {
  final String id;
  final String topicName;
  final bool isNew;
  final int accuracy;
  final int memorized;
  final int unmemorized;
  final int notStudied;

  TopicResponse({
    required this.id,
    required this.topicName,
    required this.isNew,
    required this.accuracy,
    required this.memorized,
    required this.unmemorized,
    required this.notStudied,
  });

  factory TopicResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'topicName': String topicName,
        'isNew': bool isNew,
        'accuracy': int accuracy,
        'memorized': int memorized,
        'unmemorized': int unmemorized,
        'notStudied': int notStudied,
      } =>
        TopicResponse(
          id: id,
          topicName: topicName,
          isNew: isNew,
          accuracy: accuracy,
          memorized: memorized,
          unmemorized: unmemorized,
          notStudied: notStudied,
        ),
      _ =>
        throw const FormatException(
          "Invalid topic_response.dart response format",
        ),
    };
  }
}
