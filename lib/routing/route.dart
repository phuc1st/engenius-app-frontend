import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/submit_test_response.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/ai_conversation/widgets/ai_chat_screen.dart';
import 'package:toeic/ui/auth/login/widgets/login_screen.dart';
import 'package:toeic/ui/auth/sign_up/widgets/sign_up_screen.dart';
import 'package:toeic/ui/grammar/grammar_detail/widgets/grammar_detail_screen.dart';
import 'package:toeic/ui/grammar/list_grammar/widgets/grammar_screen.dart';
import 'package:toeic/ui/home/widgets/home.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card_screen.dart';
import 'package:toeic/ui/learn_vocabulary/topic_detail/widgets/topic_detail_screen.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_screen.dart';
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
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case Routes.signup:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    case Routes.vocabulary:
      return MaterialPageRoute(builder: (_) => VocabularyScreen());
    case Routes.topicDetail:
      final topic = settings.arguments as UserVocabularyTopicProgressResponse;
      return MaterialPageRoute(builder: (_) => TopicDetailScreen(topic: topic));
    case Routes.flashCard:
      final progressId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => FlashcardScreen2(progressId: progressId),
      );
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
    case Routes.toeicPractice:
      return MaterialPageRoute(builder: (_) => FullTestScreen());
    case Routes.toeicTest:
      // final testId = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => ToeicTestScreen(testId: 1));
    case Routes.toeicTestResult:
      final testResult = settings.arguments as SubmitTestResponse;
      print(testResult.correctCount);
      return MaterialPageRoute(
        builder: (_) => ToeicTestResultScreen(result: testResult),
      );
    case Routes.aiConversation:
      return MaterialPageRoute(builder: (_)=> AIChatScreen());
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
