import 'package:flutter/material.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/audio_player.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/bottom_action_bar.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_overview_bottom_sheet.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

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
  const TestScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar và đồng hồ đếm ngược
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question 1", style: TextStyle(color: Colors.green.shade700),),
                  const SizedBox(width: 6,),
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
                      color: Colors.grey
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
              // Phần ghi âm
              const Text(
                "Bản ghi âm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              AudioPlayerWidget(
                audioUrl:
                    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
              ),
              const SizedBox(height: 16),
              // Hình ảnh (placeholder)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://antimatter.vn/wp-content/uploads/2022/12/anh-meme-hai-lam-avatar.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Câu hỏi trắc nghiệm "Question 1"
              const Text(
                "Question 1",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              OptionTile(
                option: "A",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "B",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "C",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              OptionTile(
                option: "D",
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Nút "Tổng quan & Nộp bài"
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget cho lựa chọn trắc nghiệm với RadioListTile được bao bọc trong Card
class OptionTile extends StatelessWidget {
  final String option;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const OptionTile({
    Key? key,
    required this.option,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: RadioListTile<String>(
        title: Text(option),
        value: option,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

//TODO xử lí làm sao để cho bottomSheet hoạt động hiệu quả hơn, code them cac man hinh tuy theo part, xay dung viewmodel
