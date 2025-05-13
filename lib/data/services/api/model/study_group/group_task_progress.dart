import 'package:toeic/data/services/api/model/user/user.dart';

class GroupTaskProgress {
  final int id;
  final int taskId;
  final User user;
  final bool completed;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupTaskProgress({
    required this.id,
    required this.taskId,
    required this.user,
    required this.completed,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupTaskProgress.fromJson(Map<String, dynamic> json) {
    return GroupTaskProgress(
      id: json['id'],
      taskId: json['taskId'],
      user: User.fromJson(json['user']),
      completed: json['completed'],
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'user': user.toJson(),
      'completed': completed,
      'completedAt': completedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 