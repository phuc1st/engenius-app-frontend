import 'package:flutter/material.dart';

@immutable
class SignupRequest {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String dob; // formatted as dd/MM/yyyy
  final String city;

  SignupRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'dob': dob,
    'city': city,
  };
}


@immutable
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

