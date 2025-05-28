import 'package:toeic/data/services/local/ip_storage_service.dart';

class ApiConstants {
  static String ip = "192.168.1.137";
  static String get baseUrl => 'http://$ip:8222/api/v1';

  static Future<void> updateIp(String newIp) async {
    ip = newIp;
    final ipStorageService = IpStorageService();
    await ipStorageService.saveIp(newIp);
  }

  static Future<void> loadSavedIp() async {
    final ipStorageService = IpStorageService();
    final savedIp = await ipStorageService.getIp();
    if (savedIp != null) {
      ip = savedIp;
    }
  }

  static String get authToken => '$baseUrl/identity/auth/token';
  static String get registration => '$baseUrl/identity/users/registration';
  static String get getMyInfo => "http://$ip:8222/api/v1/identity/users/my-info";
  /*static String getTopics(String userId) =>
      '$baseUrl/learn/progress/vocabulary/user/$userId/full-progress';*/
  static String get getTopics => '$baseUrl/learn/progress/vocabulary/user/full-progress';
  static String get createNewTopicProgress => '$baseUrl/learn/progress/vocabulary/start';
  static String get getFlashCards => '$baseUrl/learn/progress/vocabulary';
  static String get updateFlashCardMemorized => '$baseUrl/learn/progress/vocabulary/update-user-flashcard';
  static String get getToeicTest => '$baseUrl/learn/toeic-tests';
  static String get submitTest => '$baseUrl/learn/test-attempt/submit';
  static String get getTestAttempt => '$baseUrl/learn/test-attempt';
  static String get saveTest => '$baseUrl/learn/test-attempt/save';

  // Daily Tasks
  static String get dailyTasks => '$baseUrl/learn/daily-tasks';
  static String get dailyTaskProgress => '$baseUrl/learn/daily-tasks/progress';

  // Study Group endpoints
  static String get studyGroups => '$baseUrl/learn/groups';
  static String get groupTasks => '$baseUrl/learn/groups/tasks';

  static String get groupStudy => '$baseUrl/learn/group-study';

  static String get groupEndPoint => '$baseUrl/profile/internal/group-node';

  //Chat
  static String get chatEndPoint => '$baseUrl/call';
  static String get chatSocket => 'ws://$ip:8222/api/v1/call';

  //Profile endpoints
  static String get _profile => '$baseUrl/profile';
  static String get getMyProfile => '$_profile/users/my-profile';

  //Device token
  static String get setDeviceToken => 'http://$ip:8082/notification/device-token';
}
