import 'package:toeic/data/services/api/api_clients/auth_api_client.dart';
import 'package:toeic/data/services/api/model/login_request/login_request.dart';
import 'package:toeic/data/services/api/model/login_response/login_response.dart';
import 'package:toeic/data/services/api/model/signup_request/signup_request.dart';
import 'package:toeic/data/services/api/model/signup_response/signup_response.dart';
import 'package:toeic/data/services/local/token_service.dart';
import 'package:toeic/utils/app_exception.dart';
import 'package:toeic/utils/result.dart';

class AuthRepository {
  final AuthApiClient _authApiClient;

  AuthRepository({required AuthApiClient authApiClient})
      : _authApiClient = authApiClient;

  Future<Result<LoginResponse>> login(LoginRequest request) async {
    try {
      final apiResponse = await _authApiClient.login(request);

      if (apiResponse.code == 1000 && apiResponse.result != null) {
        // Lưu token vào storage
        await TokenManager().setTokens(accessToken: apiResponse.result?.token);
        return Result.ok(apiResponse.result!);
      } else {
        return Result.error(AppException(apiResponse.message ?? "Unknown error"));
      }
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }

  Future<Result<SignupResponse>> signup(SignupRequest request) async{
    final apiResponse = await _authApiClient.signup(request);

    if(apiResponse.code == 1000 && apiResponse.result != null) {
      return Result.ok(apiResponse.result!);
    } else {
      return Result.error(AppException(apiResponse.message!));
    }
  }
}