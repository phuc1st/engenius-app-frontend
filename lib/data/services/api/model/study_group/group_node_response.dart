class GroupNodeResponse {
  final String id;
  final String name;
  final String createdBy;
  final String avatarUrl;
  final int memberCount;
  final bool joined;

  GroupNodeResponse({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.avatarUrl,
    required this.memberCount,
    required this.joined,
  });

  factory GroupNodeResponse.fromJson(Map<String, dynamic> json) {
    return GroupNodeResponse(
      id: json['id'],
      name: json['name'],
      createdBy: json['createdBy'],
      avatarUrl: json['avatarUrl'],
      memberCount: json['memberCount'],
      joined: json['joined'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'avatarUrl': avatarUrl,
      'memberCount': memberCount,
      'joined': joined,
    };
  }
}