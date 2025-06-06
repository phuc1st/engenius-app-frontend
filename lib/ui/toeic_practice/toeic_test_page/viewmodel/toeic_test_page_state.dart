

import 'package:toeic/data/services/api/model/toeic_test_response/toeic_test.dart';

class ToeicTestPageState {
  final ToeicTest toeicTest;
  final Map<int, int> answers;
  final Set<int> answeredIndex;
  final int currentIndex;
  final bool isLoading;
  final String? errorMessage;

  ToeicTestPageState({
    required this.toeicTest,
    Map<int, int>? answers,
    Set<int>? answeredIndex,
    this.currentIndex = 0,
    this.isLoading = false,
    this.errorMessage,
  })  : answers = answers ?? const {},
        answeredIndex = answeredIndex ?? <int>{};

  /// Constructor để khởi tạo state ban đầu khi chưa load test
  factory ToeicTestPageState.initial() {
    return ToeicTestPageState(
      toeicTest: ToeicTest(
        id: 0,
        name: '',
        createdAt: DateTime.now(),
        parts: [],
      ),
      answers: {},
      answeredIndex: <int>{},
      currentIndex: 0,
      isLoading: true,
      errorMessage: null,
    );
  }

  ToeicTestPageState copyWith({
    ToeicTest? toeicTest,
    Map<int, int>? answers,
    Set<int>? answeredIndex,
    int? currentIndex,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ToeicTestPageState(
      toeicTest: toeicTest ?? this.toeicTest,
      answers: answers ?? this.answers,
      answeredIndex: answeredIndex ?? this.answeredIndex,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
