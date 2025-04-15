import 'package:flutter/material.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/auth/login/widgets/login_screen.dart';
import 'package:toeic/ui/auth/sign_up/widgets/sign_up_screen.dart';
import 'package:toeic/ui/home/widgets/home.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card_screen.dart';
import 'package:toeic/ui/learn_vocabulary/topic_detail/widgets/topic_detail_screen.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  debugPrint('Route name: ${settings.name}');
  debugPrint('Arguments: ${settings.arguments}');
  debugPrint('Type of arguments: ${settings.arguments.runtimeType}');
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case Routes.login:
      return MaterialPageRoute(builder: (_) => LoginInScreen());
    case Routes.signup:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    case Routes.vocabulary:
      return MaterialPageRoute(builder: (_) => VocabularyScreen());
    case Routes.topicDetail:
      final topic = settings.arguments as TopicResponse;
      return MaterialPageRoute(builder: (_) => TopicDetailScreen(topic: topic));
    case Routes.flashCard:
      final topicId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => FlashcardScreen2(topicId: topicId));
    /*case chat:
      print("Nav to chat");
      final receivedId = settings.arguments as String;
      return MaterialPageRoute(
      builder: (_) => ChatScreen(receivedId: receivedId),
      );*/

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
