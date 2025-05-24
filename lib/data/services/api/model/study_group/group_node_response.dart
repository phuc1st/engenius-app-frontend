class GroupNodeResponse {
  final String id;
  final String name;
  final String createdBy;
  final int memberCount;
  final bool joined;

  GroupNodeResponse({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.memberCount,
    required this.joined,
  });

  factory GroupNodeResponse.fromJson(Map<String, dynamic> json) {
    return GroupNodeResponse(
      id: json['id'],
      name: json['name'],
      createdBy: json['createdBy'],
      memberCount: json['memberCount'],
      joined: json['joined'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'memberCount': memberCount,
      'joined': joined,
    };
  }
}