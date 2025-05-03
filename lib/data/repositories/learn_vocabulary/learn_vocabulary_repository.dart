import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/learn_vocabulary_api_client.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/utils/result.dart';

class LearnVocabularyRepository extends BaseRepository {
  final LearnVocabularyApiClient _learnVocabularyApiClient;

  LearnVocabularyRepository({
    required LearnVocabularyApiClient learnVocabularyApiClient,
  }) : _learnVocabularyApiClient = learnVocabularyApiClient;

  Future<Result<List<UserVocabularyTopicProgressResponse>>> getTopics(
    String userId,
  ) async {
    final apiResponse = await _learnVocabularyApiClient.getTopics(userId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<List<FlashCardResponse>>> getFlashCards(int progressId) async {
    final apiResponse = await _learnVocabularyApiClient.getFlashCards(
      progressId,
    );
    return handleApiResponse(apiResponse);
  }

  Future<Result<UserVocabularyTopicProgressResponse>> createNewTopicProgress(
    String userId,
    int topicId,
  ) async {
    final apiResponse = await _learnVocabularyApiClient.createNewTopicProgress(
      userId,
      topicId,
    );
    return handleApiResponse(apiResponse);
  }

  void updateFlashcardMemorized(
    int progressId,
    int flashCardId,
    bool memorized,
  ) {
    _learnVocabularyApiClient.updateFlashcardMemorized(
      progressId,
      flashCardId,
      memorized,
    );
  }
}
