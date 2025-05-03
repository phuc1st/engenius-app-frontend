import 'package:dio/dio.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/user_vocabulary_topic_progress_response.dart';
import 'package:toeic/utils/json_helpers.dart';

class LearnVocabularyApiClient extends BaseApiClient {
  LearnVocabularyApiClient({Dio? dio}) : super(dio: dio);

  Future<ApiResponse<List<UserVocabularyTopicProgressResponse>>> getTopics(
    String userId,
  ) async {
    return makeRequest(
      url: ApiConstants.getTopics(userId),
      method: 'GET',
      fromJson:
          (json) =>
              listFromJson(json, UserVocabularyTopicProgressResponse.fromJson),
    );
  }

  Future<ApiResponse<List<FlashCardResponse>>> getFlashCards(
    int progressId,
  ) async {
    return makeRequest(
      url: '${ApiConstants.getFlashCards}/$progressId',
      method: 'GET',
      fromJson: (json) => listFromJson(json, FlashCardResponse.fromJson),
    );
  }

  Future<ApiResponse<UserVocabularyTopicProgressResponse>>
  createNewTopicProgress(String userId, int topicId) async {
    return makeRequest(
      url: ApiConstants.createNewTopicProgress,
      method: 'POST',
      body: {"userId": userId, "topicId": topicId},
      fromJson: (json) => UserVocabularyTopicProgressResponse.fromJson(json),
    );
  }

  void updateFlashcardMemorized(
    int progressId,
    int flashCardId,
    bool memorized,
  ) {
    makeRequest(
      url: ApiConstants.updateFlashCardMemorized,
      method: 'PUT',
      fromJson: (json){},
      body: {
        "progressId" : progressId,
        "flashCardId": flashCardId,
        "memorized": memorized
      }
    );
  }
}
