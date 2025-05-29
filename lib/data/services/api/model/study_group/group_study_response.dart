class GroupStudyResponse {
  final int? id;
  final String? name;
  final String? description;
  final String? avatarUrl;
  final String? createdBy;

  GroupStudyResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarUrl,
    required this.createdBy,
  });

  factory GroupStudyResponse.fromJson(Map<String, dynamic> json) {
    return GroupStudyResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      avatarUrl: json['avatarUrl'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'avatarUrl': avatarUrl,
      'createdBy': createdBy,
    };
  }
} 