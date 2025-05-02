import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/provider/toeic_practice_provider.dart';
import 'package:toeic/routing/routes.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/answer_widget.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/bottom_action_bar.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_overview_bottom_sheet.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/widgets/question_widget.dart';

class ToeicTestScreen extends ConsumerStatefulWidget {
  int testId;

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

  Future<void> submitTestHandler() async {
    print("Voaf");
    await ref
        .read(toeicTestScreenViewModelProvider(widget.testId).notifier)
        .submitTest(
          onSuccess: (result) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.toeicTestResult,
              arguments: result,
              (route) => false,
            );
          },
          onError: (message) {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text('Lỗi'),
                    content: Text(message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          },
        );
  }

  // Hàm mở BottomSheet
  void _showOverviewBottomSheet(
    int totalQuestions,
    Set<int> answered,
    Map<int, int> questionToBlock,
  ) {
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
            if (blockIndex != null) {
              _pageController.jumpToPage(blockIndex);
            }
          },
          onSubmit: submitTestHandler,
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: Icon(
              Icons.check_circle_outline_sharp,
              size: 30,
              color: Colors.greenAccent.shade400,
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Tiến độ của bạn đã được lưu tự động",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(
                          toeicTestScreenViewModelProvider(
                            widget.testId,
                          ).notifier,
                        )
                        .saveTest();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.home,
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color(0xFF5A7FFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Xác nhận và tạm dừng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
    );
    return shouldLeave ?? false;
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
    final answeredSet = state.answeredIndex;
    final totalQuestion = blocks.fold(
      0,
      (sum, block) => sum + block.questions.length,
    );

    final questionToBlock = <int, int>{};
    for (var i = 0; i < blocks.length; i++) {
      for (var q in blocks[i].questions) {
        questionToBlock[q.number] = i;
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onWillPop();
      },
      child: Scaffold(
        // AppBar với tiêu đề "TEST 1"
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () => _onWillPop(),
                icon: Icon(Icons.cancel_outlined, size: 30),
              ),
              Text("TEsT 1".toUpperCase()),
            ],
          ),
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
              () => _showOverviewBottomSheet(
                totalQuestion,
                answeredSet,
                questionToBlock,
              ),
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
                            value:
                                totalQuestion == 0
                                    ? 1
                                    : answeredSet.length / totalQuestion,
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
                      onOptionSelected:
                          (questionId, questionNumber, val) =>
                              vm.submitAnswer(questionId, questionNumber, val),
                      selectedAnswers: state.answers,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
