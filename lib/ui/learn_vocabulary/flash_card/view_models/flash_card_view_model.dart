import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/learn_vocabulary/learn_vocabulary_repository.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/ui/learn_vocabulary/flash_card/view_models/flash_card_screen_state.dart';
import 'package:toeic/utils/result.dart';

class FlashCardViewModel extends StateNotifier<FlashCardScreenState> {
  final LearnVocabularyRepository _learnVocabularyRepository;
  late int progressId;
  FlashCardViewModel({
    required LearnVocabularyRepository learnVocabularyRepository,
  }) : _learnVocabularyRepository = learnVocabularyRepository,
       super(const FlashCardScreenState(flashCards: []));

  Future<void> getFlashCards(int progressId) async {
    this.progressId = progressId;
    state = state.copyWith(isLoading: true, error: null);
    final result = await _learnVocabularyRepository.getFlashCards(progressId);

    if (result is Ok<List<FlashCardResponse>>) {
      state = state.copyWith(
        flashCards: List.from(result.value),
        isLoading: false,
      );
    } else if (result is Error<List<FlashCardResponse>>) {
      state = state.copyWith(error: result.error.toString(), isLoading: false);
    }
  }

  void updateFlashcardMemorized({
    required int flashcardId,
    required bool memorized,
  }) {
    _learnVocabularyRepository.updateFlashcardMemorized(
      progressId,
      flashcardId,
      memorized,
    );
  }

  void swipeRight() {
    if (state.flashCards.isEmpty) return;
    var card = state.flashCards.first;
    //Vuốt sang phải là đã thuộc, nếu memorized=false-chưa thuộc thì lưu nó thành true
    if (!card.memorized) {
      updateFlashcardMemorized(flashcardId: card.id, memorized: true);
    }
    final alreadySwiped = state.alreadySwipedLeft.contains(card.id);
    final updated = List<FlashCardResponse>.from(state.flashCards)..removeAt(0);
    state = state.copyWith(
      flashCards: updated,
      rightCount: state.rightCount + 1,
      leftCount: alreadySwiped ? state.leftCount -1 : state.leftCount,
    );
  }

  void swipeLeft() {
    if (state.flashCards.isEmpty) return;

    var card = state.flashCards.first;
    //Vuốt sang trái là chưa thuộc, nếu memorized=true-đã thuộc thì lưu nó thành false
    if (card.memorized) {
      card.memorized = false;
      updateFlashcardMemorized(flashcardId: card.id, memorized: false);
    }

    final updatedFlashCards =
        List<FlashCardResponse>.from(state.flashCards)
          ..removeAt(0)
          ..add(card);

    final alreadySwiped = state.alreadySwipedLeft.contains(card.id);
    final newSwipedSet = Set<int>.from(state.alreadySwipedLeft)
      ..add(card.id);

    state = state.copyWith(
      flashCards: updatedFlashCards,
      leftCount: alreadySwiped ? state.leftCount : state.leftCount + 1,
      alreadySwipedLeft: newSwipedSet,
    );
  }

  void saveResults() {
    print("Kết quả:");
    for (var card in state.flashCards) {
      print("${card.word} - ${card.memorized}");
    }
  }
}
//TODO CHỈNH LẠI PROGRESSID VÀ XỬ LÝ KHI FLASHCARD NULL, VÀ NAVIGATE