class GroupStudyResponse {
  final int id;
  final String name;
  final String description;
  final String avatar;
  final String createdBy;

  GroupStudyResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
    required this.createdBy,
  });

  factory GroupStudyResponse.fromJson(Map<String, dynamic> json) {
    return GroupStudyResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      avatar: json['avatar'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'avatar': avatar,
      'createdBy': createdBy,
    };
  }
} 