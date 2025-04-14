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
  Future<Result<List<FlashCardResponse>>> getFlashCards() {
    // TODO: implement getFlashCards
    throw UnimplementedError();
  }

  @override
  Result<T> handleApiResponse<T>(ApiResponse<T> response) {
    // TODO: implement handleApiResponse
    throw UnimplementedError();
  }
}
