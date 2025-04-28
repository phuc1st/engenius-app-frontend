import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/toeic_practice/toeic_practice_repository.dart';
import 'package:toeic/data/services/api/model/toeic_practice/question_block.dart';
import 'package:toeic/data/services/api/model/toeic_practice/toeic_test.dart';
import 'package:toeic/ui/toeic_practice/toeic_test_page/viewmodel/toeic_test_page_state.dart';
import 'package:toeic/utils/result.dart';

class ToeicTestPageViewModel extends StateNotifier<ToeicTestPageState> {
  final ToeicPracticeRepository toeicPracticeRepository;
  final int testId;

  ToeicTestPageViewModel({
    required this.toeicPracticeRepository,
    required this.testId,
  }) : super(ToeicTestPageState.initial()) {
    _fetchTest();
  }

  Future<void> _fetchTest() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final result = await toeicPracticeRepository.getToeicTest(testId);
    if (result is Ok<ToeicTest>) {
      state = state.copyWith(toeicTest: result.value, isLoading: false);
    } else if (result is Error<ToeicTest>) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.error.message,
      );
    }
  }

  /// Ghi nhận đáp án của câu hỏi [questionNumber].
  void submitAnswer(int questionId, int questionNumber, int answerIndex) {
    final newAnswers = Map<int, int>.from(state.answers)
      ..[questionId] = answerIndex;
    final newAnsweredIndex = Set<int>.from(state.answeredIndex)
      ..add(questionNumber);
    state = state.copyWith(
      answers: newAnswers,
      answeredNumber: newAnsweredIndex,
    );
  }
  void submitTest(){
    state.answers.forEach((id, index)=> print("$id: $index\n"));
    state.answeredIndex.forEach((index)=>print(index));
  }
  /// Chuyển sang QuestionBlock tiếp theo (nếu có).
  void goToNextBlock() {
    final nextIndex = state.currentIndex + 1;
    if (nextIndex < state.toeicTest.parts.expand((p) => p.blocks).length) {
      state = state.copyWith(currentIndex: nextIndex);
    }
  }

  /// Chuyển về QuestionBlock trước đó (nếu có).
  void goToPreviousBlock() {
    final prevIndex = state.currentIndex - 1;
    if (prevIndex >= 0) {
      state = state.copyWith(currentIndex: prevIndex);
    }
  }

  /// Lấy block hiện tại để UI có thể hiển thị.
  QuestionBlock? get currentBlock {
    final blocks = state.toeicTest.parts.expand((p) => p.blocks).toList();
    if (blocks.isEmpty) return null;
    return blocks[state.currentIndex];
  }
}
