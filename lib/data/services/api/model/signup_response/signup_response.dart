import 'role_response.dart';

class SignupResponse {
  final String id;
  final String username;
  final String email;
  final bool emailVerified;
  final List<RoleResponse> roles;

  SignupResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.emailVerified,
    required this.roles,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleResponse.fromJson(e))
          .toList(),
    );
  }
}