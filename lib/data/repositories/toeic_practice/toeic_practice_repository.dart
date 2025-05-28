import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/toeic_practice_api_client.dart';
import 'package:toeic/data/services/api/model/toeic_practice_request/submit_test_request.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/submit_test_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/test_attempt_answer_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/toeic_test.dart';
import 'package:toeic/utils/result.dart';

class ToeicPracticeRepository extends BaseRepository {
  final ToeicPracticeApiClient toeicTestApiClient;

  ToeicPracticeRepository({required this.toeicTestApiClient});

  Future<Result<ToeicTest>> getToeicTest(int toeicTestId) async {
    final apiResponse = await toeicTestApiClient.getToeicTest(toeicTestId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<SubmitTestResponse>> submitTest(SubmitTestRequest request) async {
    final apiResponse = await toeicTestApiClient.submitTest(request);
    return handleApiResponse(apiResponse);
  }

  Future<Result<List<TestAttemptAnswerResponse>>> getTestAttempts(int testId) async {
    final apiResponse = await toeicTestApiClient.getTestAttempt(testId);
    return handleApiResponse(apiResponse);
  }

  Future<Result<SubmitTestResponse>> saveTest(SubmitTestRequest request) async {
    final apiResponse = await toeicTestApiClient.saveTest(request);
    return handleApiResponse(apiResponse);
  }
}

//TODO CHINH LAI
