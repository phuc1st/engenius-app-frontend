class GroupStudyCreateRequest {
  final String name;
  final String description;

  GroupStudyCreateRequest({
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
} 