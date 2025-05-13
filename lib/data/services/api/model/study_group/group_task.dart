import 'package:toeic/data/services/api/model/user/user.dart';

class GroupTask {
  final int id;
  final String title;
  final String description;
  final int experiencePoints;
  final int groupId;
  final User createdBy;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupTask({
    required this.id,
    required this.title,
    required this.description,
    required this.experiencePoints,
    required this.groupId,
    required this.createdBy,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupTask.fromJson(Map<String, dynamic> json) {
    return GroupTask(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      experiencePoints: json['experiencePoints'],
      groupId: json['groupId'],
      createdBy: User.fromJson(json['createdBy']),
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'experiencePoints': experiencePoints,
      'groupId': groupId,
      'createdBy': createdBy.toJson(),
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 