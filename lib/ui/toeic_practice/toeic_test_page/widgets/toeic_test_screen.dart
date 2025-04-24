import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/provider/toeic_practice_provider.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/answer_widget.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/bottom_action_bar.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_overview_bottom_sheet.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_widget.dart';

class ToeicTestScreen extends ConsumerStatefulWidget {
  String testId;

  ToeicTestScreen({super.key, required this.testId});

  @override
  ConsumerState<ToeicTestScreen> createState() => _ToeicTestScreenState();
}

class _ToeicTestScreenState extends ConsumerState<ToeicTestScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  // Hàm mở BottomSheet
  void _showOverviewBottomSheet(int totalQuestions, Set<int> answered, Map<int,int> questionToBlock) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return QuestionOverviewBottomSheet(
          totalQuestions: totalQuestions,
          answeredQuestions: answered,
          onQuestionTap: (q) {
            final blockIndex = questionToBlock[q];
            if(blockIndex != null){
              _pageController.jumpToPage(blockIndex);
            }
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
    final state = ref.watch(toeicTestScreenViewModelProvider(widget.testId));
    final vm = ref.read(
      toeicTestScreenViewModelProvider(widget.testId).notifier,
    );

    if (state.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Toeic Test')),
        body: Center(child: Text('Error: ${state.errorMessage}')),
      );
    }

    final blocks = state.toeicTest.parts.expand((p) => p.blocks).toList();
    final totalPage = blocks.length;
    final answeredSet = state.answers.keys.toSet();
    final totalQuestion = blocks.fold(0, (sum, block) => sum + block.questions.length);

    final questionToBlock = <int, int>{};
    for (var i = 0; i < blocks.length; i++) {
      for (var q in blocks[i].questions) {
        questionToBlock[q.number] = i;
      }
    }

    return Scaffold(
      // AppBar với tiêu đề "TEST 1"
      appBar: AppBar(
        title: const Text("TEST 1"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomActionBar(
        onBack: () {
          if (vm.state.currentIndex > 0) {
            vm.goToPreviousBlock();
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
        onOverviewSubmit:
            () => _showOverviewBottomSheet(totalQuestion, answeredSet, questionToBlock),
        onNext: () {
          if (vm.state.currentIndex < totalPage - 1) {
            vm.goToNextBlock();
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
      ),

      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: totalPage,
        onPageChanged: (index) {
          vm.state = vm.state.copyWith(currentIndex: index);
        },
        itemBuilder: (context, index) {
          final block = blocks[index];
          final questions = block.questions;
          String questionNumber = "";
          if (questions.length > 1) {
            for (var question in questions) {
              questionNumber += "${question.number} ";
            }
          } else {
            questionNumber = questions.first.number.toString();
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar và đồng hồ đếm ngược
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question $questionNumber",
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
                          totalQuestion.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.blueAccent,
                      ),
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
                    audioUrl: block.audioUrl,
                    imageUrl: block.imageUrl,
                    passage: block.passage,
                  ),
                  const SizedBox(height: 24),
                  AnswerWidget(
                    questions: questions,
                    onOptionSelected: (q, val) => vm.submitAnswer(q, val),
                    selectedAnswers: state.answers.map(
                      (q, ans) => MapEntry(q, ans),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
