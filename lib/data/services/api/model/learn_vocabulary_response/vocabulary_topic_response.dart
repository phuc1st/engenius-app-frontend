class VocabularyTopicResponse {
  final int id;
  final String topicName;
  final bool newTopic;

  VocabularyTopicResponse({
    required this.id,
    required this.topicName,
    required this.newTopic,
  });

  factory VocabularyTopicResponse.fromJson(Map<String, dynamic> json) {
    return VocabularyTopicResponse(
      id: json['id'] as int,
      topicName: json['topicName'] as String,
      newTopic: json['newTopic'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicName': topicName,
      'newTopic': newTopic,
    };
  }
}
