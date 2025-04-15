import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';

class FlashCardScreenState {
  final List<FlashCardResponse> flashCards;
  final int leftCount;
  final int rightCount;
  final Set<String> alreadySwipedLeft;
  final bool isLoading;
  final String? error;

  const FlashCardScreenState({
    required this.flashCards,
    this.leftCount = 0,
    this.rightCount = 0,
    this.alreadySwipedLeft = const {},
    this.isLoading = false,
    this.error,
  });

  FlashCardScreenState copyWith({
    List<FlashCardResponse>? flashCards,
    int? leftCount,
    int? rightCount,
    Set<String>? alreadySwipedLeft,
    bool? isLoading,
    String? error,
  }) {
    return FlashCardScreenState(
      flashCards: flashCards ?? this.flashCards,
      leftCount: leftCount ?? this.leftCount,
      rightCount: rightCount ?? this.rightCount,
      alreadySwipedLeft: alreadySwipedLeft ?? this.alreadySwipedLeft,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
