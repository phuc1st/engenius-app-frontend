
import 'package:dio/dio.dart';
import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/login_request/login_request.dart';
import 'package:toeic/data/services/api/model/login_response/login_response.dart';
import 'package:toeic/data/services/api/model/signup_request/signup_request.dart';
import 'package:toeic/data/services/api/model/signup_response/signup_response.dart';

class AuthApiClient extends BaseApiClient {
  AuthApiClient({Dio? dio}) : super(dio: dio);

  Future<ApiResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    return makeRequest(
      url: ApiConstants.authToken,
      method: 'POST',
      body: loginRequest.toJson(),
      fromJson: (json) => (LoginResponse.fromJson(json)),
    );
  }

  Future<ApiResponse<SignupResponse>> signup(SignupRequest request) async {
    return makeRequest(
        url: ApiConstants.registration,
        method: 'POST',
        body: request.toJson(),
        fromJson: (json) => SignupResponse.fromJson(json));
  }
}
