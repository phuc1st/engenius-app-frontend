class ApiConstants {
  static const String baseUrl = 'http://localhost:8222/api/v1';

  static const String authToken = '$baseUrl/identity/auth/token';
  static const String registration = '$baseUrl/identity/users/registration';
  static const String getTopics = '$baseUrl/';
  static const String getFlashCards = '$baseUrl/';
  static const String getToeicTest = '$baseUrl/learn/toeic-tests';
}
