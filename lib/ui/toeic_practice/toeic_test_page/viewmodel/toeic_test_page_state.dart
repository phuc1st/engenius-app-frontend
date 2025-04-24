import 'package:toeic/data/services/api/model/toeic_practice//toeic_test.dart';

class ToeicTestPageState {
  final ToeicTest toeicTest;

  final Map<int, String> answers;

  final int currentIndex;

  final bool isLoading;

  final String? errorMessage;

  ToeicTestPageState({
    required this.toeicTest,
    Map<int, String>? answers,
    this.currentIndex = 0,
    this.isLoading = false,
    this.errorMessage,
  }) : answers = answers ?? const {};

  /// Constructor để khởi tạo state ban đầu khi chưa load test
  factory ToeicTestPageState.initial() {
    return ToeicTestPageState(
      toeicTest: ToeicTest(
        id: '',
        name: '',
        createdAt: DateTime.now(),
        parts: [],
      ),
      answers: {},
      currentIndex: 0,
      isLoading: true,
      errorMessage: null,
    );
  }

  ToeicTestPageState copyWith({
    ToeicTest? toeicTest,
    Map<int, String>? answers,
    int? currentIndex,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ToeicTestPageState(
      toeicTest: toeicTest ?? this.toeicTest,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
