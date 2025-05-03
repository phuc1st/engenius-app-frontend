import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/routing/route.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/ai_conversation/widgets/ai_chat_screen.dart';
import 'package:toeic/ui/auth/sign_up/widgets/sign_up_screen.dart';
import 'package:toeic/ui/grammar/grammar_detail/widgets/grammar_detail_screen.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card_screen.dart';
import 'package:toeic/ui/toeic_practice/list_test/widgets/list_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/toeic_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_result/widgets/toeic_result_screen.dart';
import 'package:toeic/utils/temp.dart';
import 'package:toeic/utils/test.dart';

void main() async{
  await dotenv.load(fileName: "assets/.env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.vocabulary,
      onGenerateRoute: generateRoute
      // home: ToeicTestScreen(testId: 1)
    );
  }
}