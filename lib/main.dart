import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/services/push_notification_service.dart';
import 'package:toeic/routing/route.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/ai_conversation/widgets/ai_chat_screen.dart';
import 'package:toeic/ui/auth/login/widgets/login_screen.dart';
import 'package:toeic/ui/auth/sign_up/widgets/sign_up_screen.dart';
import 'package:toeic/ui/call/view_models/call_view_model.dart';
import 'package:toeic/ui/call/widgets/call_video_screen.dart';
import 'package:toeic/ui/daily_tasks/widgets/daily_tasks_screen.dart';
import 'package:toeic/ui/grammar/grammar_detail/widgets/grammar_detail_screen.dart';
import 'package:toeic/ui/grammar/list_grammar/widgets/grammar_screen.dart';
import 'package:toeic/ui/home/widgets/home.dart';
import 'package:toeic/ui/home/widgets/welcome.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/widgets/flash_card_screen.dart';
import 'package:toeic/ui/learn_vocabulary/vocabulary/widgets/vocabulary_screen.dart';
import 'package:toeic/ui/profile/widgets/edit_profile_screen.dart';
import 'package:toeic/ui/profile/widgets/profile_screen.dart';
import 'package:toeic/ui/group_study/widgets/create_group_screen.dart';
import 'package:toeic/ui/group_study/widgets/group_chat_screen.dart';
import 'package:toeic/ui/group_study/widgets/group_detail_screen.dart';
import 'package:toeic/ui/group_study/widgets/group_list_screen.dart';
import 'package:toeic/ui/group_study/widgets/joined_group_list_screen.dart';
import 'package:toeic/ui/group_study/widgets/study_session_screen.dart';
import 'package:toeic/ui/study_groups2/widgets/study_groups_screen.dart';
import 'package:toeic/ui/toeic_practice/list_test/widgets/list_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/toeic_test_screen.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_result/widgets/toeic_result_screen.dart';
import 'package:toeic/utils/app_colors.dart';
import 'package:toeic/utils/temp.dart';
import 'package:toeic/utils/test.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (nếu cần)
  await dotenv.load(fileName: "assets/.env");

  // Khởi tạo Firebase
 /* await Firebase.initializeApp();

  // Khởi tạo notification
  final pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();*/
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final navigatorKey = ref.read(navigatorKeyProvider);
    return MaterialApp(
      // navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.primary,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.primary),
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
      initialRoute: Routes.ipConfig,
      onGenerateRoute: generateRoute
      // home: ProfileScreen()
    );
  }
}