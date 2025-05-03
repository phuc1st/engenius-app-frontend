class UserVocabularyTopicProgressResponse {
  final int? id;
  final int vocabularyTopicId;
  final String topicName;
  final int studied;
  final int memorized;
  final int unmemorized;
  final bool newTopic;
  final int accuracy;

  UserVocabularyTopicProgressResponse({
    required this.id,
    required this.vocabularyTopicId,
    required this.topicName,
    required this.studied,
    required this.memorized,
    required this.unmemorized,
    required this.newTopic,
    required this.accuracy,
  });

  factory UserVocabularyTopicProgressResponse.fromJson(Map<String, dynamic> json) {
    return UserVocabularyTopicProgressResponse(
      id: json['id'] as int?,
      vocabularyTopicId: json['vocabularyTopicId'] as int,
      topicName: json['topicName'] as String,
      studied: json['studied'] as int,
      memorized: json['memorized'] as int,
      unmemorized: json['unmemorized'] as int,
      newTopic:  json['newTopic'] as bool,
      accuracy: json['accuracy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vocabularyTopicId': vocabularyTopicId,
      'studied': studied,
      'memorized': memorized,
      'unmemorized': unmemorized,
    };
  }
}
