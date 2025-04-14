import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/learn_vocabulary_api_client.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/utils/result.dart';

class LearnVocabularyRepository extends BaseRepository{
  final LearnVocabularyApiClient _learnVocabularyApiClient;

  LearnVocabularyRepository({
    required LearnVocabularyApiClient learnVocabularyApiClient,
  }) : _learnVocabularyApiClient = learnVocabularyApiClient;

  Future<Result<List<TopicResponse>>> getTopics() async {
    final apiResponse = await _learnVocabularyApiClient.getTopics();
    return handleApiResponse(apiResponse);
  }

  Future<Result<List<FlashCardResponse>>> getFlashCards(String topicId) async {
    final apiResponse = await _learnVocabularyApiClient.getFlashCards(topicId);
    return handleApiResponse(apiResponse);
  }


}
