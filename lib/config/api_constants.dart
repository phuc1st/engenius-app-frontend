class ApiConstants {
  static const String baseUrl = 'http://localhost:8222/api/v1';

  static const String authToken = '$baseUrl/identity/auth/token';
  static const String registration = '$baseUrl/identity/users/registration';
  static String getTopics(String userId) =>
      '$baseUrl/learn/progress/vocabulary/user/$userId/full-progress';
  static const String createNewTopicProgress = '$baseUrl/learn/progress/vocabulary/start';
  static const String getFlashCards = '$baseUrl/learn/progress/vocabulary';
  static const updateFlashCardMemorized = '$baseUrl/learn/progress/vocabulary/update-user-flashcard';
  static const String getToeicTest = '$baseUrl/learn/toeic-tests';
  static const String submitTest = '$baseUrl/learn/test-attempt/submit';
  static const String getTestAttempt = '$baseUrl/learn/test-attempt';
  static const String saveTest = '$baseUrl/learn/test-attempt/save';
}
