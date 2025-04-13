class PermissionResponse {
  final String name;
  final String description;

  PermissionResponse({required this.name, required this.description});

  factory PermissionResponse.fromJson(Map<String, dynamic> json) {
    return PermissionResponse(
      name: json['name'],
      description: json['description'],
    );
  }
}
