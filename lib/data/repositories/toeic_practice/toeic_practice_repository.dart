import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/toeic_practice_api_client.dart';
import 'package:toeic/data/services/api/model/learn_vocabulary_response/flash_card_response.dart';
import 'package:toeic/data/services/api/model/toeic_practice/toeic_test.dart';
import 'package:toeic/utils/result.dart';

class ToeicPracticeRepository extends BaseRepository {
  final ToeicPracticeApiClient toeicTestApiClient;

  ToeicPracticeRepository({required this.toeicTestApiClient});

  Future<Result<ToeicTest>> getToeicTest(int toeicTestId) async {
    final apiResponse = await toeicTestApiClient.getToeicTest(toeicTestId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<List<FlashCardResponse>>> getFlashCards(String topicId) async {
    final apiResponse = await toeicTestApiClient.getFlashCards(topicId);
    return handleApiResponse(apiResponse);
  }
}

//TODO CHINH LAI
