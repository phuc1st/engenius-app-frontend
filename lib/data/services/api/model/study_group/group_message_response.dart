class GroupMessageResponse {
  final String id;
  final String content;
  final String senderId;
  final String senderName;
  final DateTime createdAt;
  final String groupId;

  GroupMessageResponse({
    required this.id,
    required this.content,
    required this.senderId,
    required this.senderName,
    required this.createdAt,
    required this.groupId,
  });

  factory GroupMessageResponse.fromJson(Map<String, dynamic> json) {
    return GroupMessageResponse(
      id: json['id'],
      content: json['content'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      createdAt: DateTime.parse(json['createdAt']),
      groupId: json['groupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'createdAt': createdAt.toIso8601String(),
      'groupId': groupId,
    };
  }
} 