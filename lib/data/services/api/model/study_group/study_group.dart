import 'package:toeic/data/services/api/model/user/user.dart';

class StudyGroup {
  final int id;
  final String name;
  final String code;
  final String description;
  final User createdBy;
  final List<User> members;
  final bool isPrivate;
  final int maxMembers;
  final DateTime createdAt;
  final DateTime updatedAt;

  StudyGroup({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.createdBy,
    required this.members,
    required this.isPrivate,
    required this.maxMembers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyGroup.fromJson(Map<String, dynamic> json) {
    return StudyGroup(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      createdBy: User.fromJson(json['createdBy']),
      members: (json['members'] as List).map((e) => User.fromJson(e)).toList(),
      isPrivate: json['isPrivate'],
      maxMembers: json['maxMembers'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'createdBy': createdBy.toJson(),
      'members': members.map((e) => e.toJson()).toList(),
      'isPrivate': isPrivate,
      'maxMembers': maxMembers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 