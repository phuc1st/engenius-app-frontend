class LeaderboardEntry {
  final int userId;
  final String userName;
  final int completedTasks;
  final int totalPoints;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.completedTasks,
    required this.totalPoints,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['userId'],
      userName: json['userName'],
      completedTasks: json['completedTasks'],
      totalPoints: json['totalPoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'completedTasks': completedTasks,
      'totalPoints': totalPoints,
    };
  }
} 