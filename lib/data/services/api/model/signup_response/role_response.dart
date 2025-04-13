import 'permission_response.dart';

class RoleResponse {
  final String name;
  final String description;
  final List<PermissionResponse>? permissions;

  RoleResponse({required this.name, required this.description, required this.permissions});

  factory RoleResponse.fromJson(Map<String, dynamic> json) {
    return RoleResponse(
      name: json['name'],
      description: json['description'],
      permissions: json['permissions'] !=null ? (json['permissions'] as List<dynamic>)
          .map((e) => PermissionResponse.fromJson(e))
          .toList() : null,
    );
  }
}