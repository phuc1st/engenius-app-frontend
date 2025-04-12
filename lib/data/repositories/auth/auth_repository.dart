import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/services/api/api_clients/auth_api_client.dart';
import 'package:toeic/models/login.dart';
import 'package:toeic/utils/app_exception.dart';
import 'package:toeic/utils/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginRepository {
  final AuthApiClient _authApiClient;
  final FlutterSecureStorage _storage;

  LoginRepository({required AuthApiClient authApiClient, FlutterSecureStorage? storage})
      : _authApiClient = authApiClient,
        _storage = storage ?? const FlutterSecureStorage();

  Future<Result<LoginResponse>> login(LoginRequest request) async {
    try {
      final apiResponse = await _authApiClient.login(request);

      if (apiResponse.code == 1000 && apiResponse.result != null) {
        // Lưu token vào storage
        await _storage.write(key: 'access_token', value: apiResponse.result!.token);
        return Result.ok(apiResponse.result!);
      } else {
        return Result.error(AppException(apiResponse.message ?? "Unknown error"));
      }
    } catch (e) {
      return Result.error(AppException(e.toString()));
    }
  }
}
final authApiClientProvider = Provider<AuthApiClient>((ref) {
  return AuthApiClient();
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final apiClient = ref.read(authApiClientProvider);
  return LoginRepository(authApiClient: apiClient);
});