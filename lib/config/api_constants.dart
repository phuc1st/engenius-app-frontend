class ApiConstants {
  static const String baseUrl = 'http://192.168.1.10:8222/api/v1';

  static const String authToken = '$baseUrl/identity/auth/token';
  static const String registration = '$baseUrl/identity/users/registration';
  static const String getMyInfo = "http://localhost:8222/api/v1/identity/users/my-info";
  static String getTopics(String userId) =>
      '$baseUrl/learn/progress/vocabulary/user/$userId/full-progress';
  static const String createNewTopicProgress = '$baseUrl/learn/progress/vocabulary/start';
  static const String getFlashCards = '$baseUrl/learn/progress/vocabulary';
  static const updateFlashCardMemorized = '$baseUrl/learn/progress/vocabulary/update-user-flashcard';
  static const String getToeicTest = '$baseUrl/learn/toeic-tests';
  static const String submitTest = '$baseUrl/learn/test-attempt/submit';
  static const String getTestAttempt = '$baseUrl/learn/test-attempt';
  static const String saveTest = '$baseUrl/learn/test-attempt/save';

  // Daily Tasks
  static const String dailyTasks = '$baseUrl/learn/daily-tasks';
  static const String dailyTaskProgress = '$baseUrl/learn/daily-tasks/progress';

  // Study Group endpoints
  static const String studyGroups = '$baseUrl/learn/groups';
  static const String groupTasks = '$baseUrl/learn/groups/tasks';

  static const String groupStudy = '$baseUrl/learn/group-study';

  static const String groupEndPoint = '$baseUrl/profile/internal/group-node';

  //Chat
  static const String chatEndPoint = '$baseUrl/call';
  static const String chatSocket = 'ws://192.168.1.10:8222/api/v1/call';
}
