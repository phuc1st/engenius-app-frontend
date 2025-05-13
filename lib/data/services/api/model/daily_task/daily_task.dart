class DailyTask {
  final int id;
  final String title;
  final String description;
  final int experiencePoints;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String taskType; // 'VOCABULARY', 'GRAMMAR', 'LISTENING', 'READING', 'SPEAKING'

  DailyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.experiencePoints,
    required this.isCompleted,
    required this.createdAt,
    this.completedAt,
    required this.taskType,
  });

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      experiencePoints: json['experiencePoints'] as int,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      taskType: json['taskType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'experiencePoints': experiencePoints,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'taskType': taskType,
    };
  }
} 