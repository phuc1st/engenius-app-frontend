import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/toeic_practice_request/submit_test_request.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/submit_test_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/test_attempt_answer_response.dart';
import 'package:toeic/data/services/api/model/toeic_test_response/toeic_test.dart';
import 'package:toeic/utils/json_helpers.dart';

class ToeicPracticeApiClient extends BaseApiClient {
  ToeicPracticeApiClient({super.dio});

  Future<ApiResponse<ToeicTest>> getToeicTest(int toeicTestId) async {
    return makeRequest(
      url: '${ApiConstants.getToeicTest}/$toeicTestId',
      method: 'GET',
      fromJson: (json) => ToeicTest.fromJson(json),
    );
  }

  Future<ApiResponse<SubmitTestResponse>> submitTest(
    SubmitTestRequest request,
  ) async {
    return makeRequest(
      url: ApiConstants.submitTest,
      method: 'POST',
      body: request.toJson(),
      fromJson: (json) => SubmitTestResponse.fromJson(json),
    );
  }

  Future<ApiResponse<List<TestAttemptAnswerResponse>>> getTestAttempt(
    int testId,
  ) async {
    return makeRequest(
      url: 'http://localhost:8222/api/v1/learn/test-attempt/$testId',
      method: 'GET',
      fromJson: (json) => listFromJson(json, TestAttemptAnswerResponse.fromJson),
    );
  }

  Future<ApiResponse<SubmitTestResponse>> saveTest(
      SubmitTestRequest request,
      ) async {
    return makeRequest(
      url: ApiConstants.saveTest,
      method: 'POST',
      body: request.toJson(),
      fromJson: (json) => SubmitTestResponse.fromJson(json),
    );
  }
}

//TODO CHINH LAI
