import 'package:toeic/data/repositories/learn_vocabulary/learn_vocabulary_repository.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/utils/result.dart';

class MockLearnVocabularyRepository implements LearnVocabularyRepository {
  @override
  Future<Result<List<TopicResponse>>> getTopics() async {
    await Future.delayed(const Duration(milliseconds: 500)); // giả lập delay

    return Result.ok([
      TopicResponse(
        id: '1',
        topicName: 'Animals',
        isNew: true,
        accuracy: 80,
        memorized: 20,
        unmemorized: 5,
        notStudied: 10,
      ),
      TopicResponse(
        id: '2',
        topicName: 'Fruits',
        isNew: false,
        accuracy: 65,
        memorized: 15,
        unmemorized: 10,
        notStudied: 10,
      ),
      TopicResponse(
        id: '3',
        topicName: 'Colors',
        isNew: false,
        accuracy: 90,
        memorized: 25,
        unmemorized: 3,
        notStudied: 2,
      ),
    ]);
  }

  @override
  Future<Result<List<FlashCardResponse>>> getFlashCards(String topicId) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // mô phỏng độ trễ API

    // Giả lập một số flashcard
    final mockFlashCards = [
      FlashCardResponse(
        id: '1',
        image: 'images/cat.png',
        word: 'Apple',
        phonetic: '/ˈæp.əl/',
        audio:
            'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
        answer: 'A fruit that is usually red, green, or yellow.', memorized: false,
      ),
      FlashCardResponse(
        id: '2',
        image: 'images/cat.png',
        word: 'Dog',
        phonetic: '/dɒɡ/',
        audio:
            'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
        answer: 'A domesticated animal that barks.',memorized: false
      ),
      FlashCardResponse(
        id: '3',
        image: 'images/cat.png',
        word: 'Book',
        phonetic: '/bʊk/',
        audio:
            'https://commondatastorage.googleapis.com/codeskulptor-assets/Epoq-Lepidoptera.ogg',
        answer: 'A set of pages with writing or pictures.',memorized: false
      ),
    ];
    return Result.ok(mockFlashCards);
  }

  @override
  Result<T> handleApiResponse<T>(ApiResponse<T> response) {
    // TODO: implement handleApiResponse
    throw UnimplementedError();
  }
}
