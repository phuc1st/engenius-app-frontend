import 'package:flutter/material.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/answer_widget.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/bottom_action_bar.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_overview_bottom_sheet.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_widget.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Screen',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestScreen(),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? _selectedOption;

  // Hàm mở BottomSheet
  void _showOverviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return QuestionOverviewBottomSheet(
          totalQuestions: 100,
          answeredQuestions: {2, 5, 9, 15, 22},
          onQuestionTap: (q) {
            print('Đi tới câu $q');
            Navigator.pop(context);
          },
          onSubmit: () {
            print('Nộp bài kiểm tra');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar với tiêu đề "TEST 1"
      appBar: AppBar(
        title: const Text("TEST 1"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomActionBar(
        onBack: () => print("Back"),
        onOverviewSubmit: _showOverviewBottomSheet,
        onNext: () => print("Next"),
      ),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar và đồng hồ đếm ngược
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question 1",
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "100",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.watch_later_outlined, color: Colors.blueAccent),
                  SizedBox(width: 4),
                  Text(
                    "01:58:03",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              QuestionWidget(
                audioUrl:
                    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                imageUrl: "assets/images/cat.png",
              ),
              const SizedBox(height: 24),
              AnswerWidget(
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
                selectedOption: _selectedOption,
                questionNumber: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO code them cac man hinh tuy theo part, xay dung viewmodel
