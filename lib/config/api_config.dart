class ApiConfig {
  static const String baseUrl = 'http://localhost:8080/api';
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';
  static const String uploadAvatar = '/auth/upload-avatar';
  
  // Profile endpoints
  static const String updateProfile = '/profile/update';
  static const String getProfile = '/profile';
  
  // Study group endpoints
  static const String createGroup = '/groups';
  static const String joinGroup = '/groups/join';
  static const String leaveGroup = '/groups/leave';
  static const String getGroups = '/groups';
  
  // Task endpoints
  static const String createTask = '/tasks';
  static const String completeTask = '/tasks/complete';
  static const String getTasks = '/tasks';
  
  // Test endpoints
  static const String getTests = '/tests';
  static const String submitTest = '/tests/submit';
  static const String getTestResults = '/tests/results';
} 