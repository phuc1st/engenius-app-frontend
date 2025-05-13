class User {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final String? avatarUrl;
  final String? level;
  final int experiencePoints;
  final List<String> studyGroups;
  final List<String> completedTests;
  final List<String> badges;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    this.avatarUrl,
    this.level,
    this.experiencePoints = 0,
    this.studyGroups = const [],
    this.completedTests = const [],
    this.badges = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      level: json['level'] as String?,
      experiencePoints: json['experiencePoints'] as int? ?? 0,
      studyGroups: (json['studyGroups'] as List<dynamic>?)?.cast<String>() ?? [],
      completedTests: (json['completedTests'] as List<dynamic>?)?.cast<String>() ?? [],
      badges: (json['badges'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'level': level,
      'experiencePoints': experiencePoints,
      'studyGroups': studyGroups,
      'completedTests': completedTests,
      'badges': badges,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? avatarUrl,
    String? level,
    int? experiencePoints,
    List<String>? studyGroups,
    List<String>? completedTests,
    List<String>? badges,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      level: level ?? this.level,
      experiencePoints: experiencePoints ?? this.experiencePoints,
      studyGroups: studyGroups ?? this.studyGroups,
      completedTests: completedTests ?? this.completedTests,
      badges: badges ?? this.badges,
    );
  }
} 