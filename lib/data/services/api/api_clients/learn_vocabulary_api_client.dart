import 'package:dio/dio.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/topic_response.dart';
import 'package:toeic/utils/json_helpers.dart';

class LearnVocabularyApiClient extends BaseApiClient {
  LearnVocabularyApiClient({Dio? dio}) : super(dio: dio);

  Future<ApiResponse<List<TopicResponse>>> getTopics() async {
    return makeRequest(
      url: ApiConstants.getTopics,
      method: 'GET',
      fromJson: (json) => listFromJson(json, TopicResponse.fromJson),
    );
  }

  Future<ApiResponse<List<FlashCardResponse>>> getFlashCards() async {
    return makeRequest(
      url: ApiConstants.getFlashCards,
      method: 'GET',
      fromJson: (json) => listFromJson(json, FlashCardResponse.fromJson),
    );
  }
}
