import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/submit_test_response.dart';
import 'package:toeic/routing/route_arguments/group_chat_arguments.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/ai_conversation/widgets/ai_chat_screen.dart';
import 'package:toeic/ui/auth/login/widgets/login_screen.dart';
import 'package:toeic/ui/auth/sign_up/widgets/sign_up_screen.dart';
import 'package:toeic/ui/daily_tasks/widgets/daily_tasks_screen.dart';
import 'package:toeic/ui/grammar/grammar_detail/widgets/grammar_detail_screen.dart';
import 'package:toeic/ui/grammar/list_grammar/widgets/grammar_screen.dart';
import 'package:toeic/ui/group_study/widgets/create_group_screen.dart';
import 'package:toeic/ui/group_study/widgets/group_chat_screen.dart';
import 'package:toeic/ui/group_study/widgets/group_list_screen.dart';
import 'package:toeic/ui/group_study/widgets/joined_group_list_screen.dart';
import 'package:toeic/ui/home/widgets/home.dart';
import 'package:toeic/ui/ipconfig/ip_config_screen.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card_screen.dart';
import 'package:toeic/ui/learn_vocabulary/topic_detail/widgets/topic_detail_screen.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_screen.dart';
import 'package:toeic/ui/profile/widgets/profile_screen.dart';
import 'package:toeic/ui/toeic_practice/list_test/widgets/list_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/toeic_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_result/widgets/toeic_result_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint('Route name: ${settings.name}');
  debugPrint('Arguments: ${settings.arguments}');
  debugPrint('Type of arguments: ${settings.arguments.runtimeType}');
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => HomeScreen());

    //AUTH
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case Routes.signup:
      return MaterialPageRoute(builder: (_) => SignUpScreen());

    //LEARN VOCABULARY
    case Routes.vocabulary:
      return MaterialPageRoute(builder: (_) => VocabularyScreen());
    case Routes.topicDetail:
      final topic = settings.arguments as UserVocabularyTopicProgressResponse;
      if (topic == null) {
        return _errorRoute('Missing topic detail argument');
      }
      return MaterialPageRoute(builder: (_) => TopicDetailScreen(topic: topic));
    case Routes.flashCard:
      final progressId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => FlashcardScreen(progressId: progressId),
      );

    //GRAMMAR
    case Routes.grammar:
      return MaterialPageRoute(builder: (_) => GrammarListScreen());
    case Routes.grammarDetail:
      final grammarId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => GrammarDetailScreen(grammarId: grammarId),
      );
    /*case chat:
      print("Nav to chat");
      final receivedId = settings.arguments as String;
      return MaterialPageRoute(
      builder: (_) => ChatScreen(receivedId: receivedId),
      );*/

    //TOEIC PRACTICE
    case Routes.listToeicPractice:
      return MaterialPageRoute(builder: (_) => FullTestScreen());
    case Routes.toeicTest:
      int testId = settings.arguments as int;
      testId = 1;
      return MaterialPageRoute(builder: (_) => ToeicTestScreen(testId: testId));
    case Routes.toeicTestResult:
      final testResult = settings.arguments as SubmitTestResponse;
      print(testResult.correctCount);
      return MaterialPageRoute(
        builder: (_) => ToeicTestResultScreen(result: testResult),
      );

    //AI CONVERSATION
    case Routes.aiConversation:
      return MaterialPageRoute(builder: (_) => AIChatScreen());

    //GROUP STUDY
    case Routes.groupStudy:
      return MaterialPageRoute(builder: (_) => GroupListScreen());
    case Routes.createGroupStudy:
      return MaterialPageRoute(builder: (_) => CreateGroupScreen());
    case Routes.joinedGroup:
      return MaterialPageRoute(builder: (_) => JoinedGroupListScreen());
    case Routes.groupChat:
      final args = settings.arguments as GroupChatArguments;
      if (args == null) {
        return _errorRoute('Missing topic detail argument');
      }
      return MaterialPageRoute(
        builder:
            (_) => GroupChatScreen(group: args),
      );

    //DAILY TASK
    case Routes.dailyTask:
      return MaterialPageRoute(builder: (_) => DailyTasksScreen());

    //IP CONFIG
    case Routes.ipConfig:
      return MaterialPageRoute(builder: (_)=>IpConfigScreen());

    //PROFILE
    case Routes.profile:
      return MaterialPageRoute(builder: (_)=>ProfileScreen());

    //DEFAULT
    default:
      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
      );
  }
}
Route<dynamic> _errorRoute(String message) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(child: Text(message)),
    ),
  );
}
