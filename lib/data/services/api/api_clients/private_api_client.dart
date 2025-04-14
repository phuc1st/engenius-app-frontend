import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toeic/data/services/local/token_service.dart';
import 'base_api_client.dart';

abstract class PrivateBaseApiClient extends BaseApiClient {

  PrivateBaseApiClient({
    Dio? dio,
    Map<String, dynamic>? defaultHeaders,
  }) : super(dio: dio, defaultHeaders: defaultHeaders) {
    dio?.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await TokenManager().getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final newToken = await _refreshToken();
            if (newToken != null) {
              // Retry lại request ban đầu với token mới
              error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            }
          } catch (e) {
            // Refresh token thất bại
          }
        }
        handler.next(error); // Nếu không xử lý được, trả lỗi về client
      },
    ));
  }


  Future<String?> _refreshToken() async {
    final refreshToken = await TokenManager().getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final response = await dio.post(
      'http://server/api/v1/identity/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode == 200) {
      final newToken = response.data['accessToken'];
      final storage = const FlutterSecureStorage();
      await storage.write(key: 'access_token', value: newToken);
     TokenManager().setTokens(accessToken: newToken); // Cập nhật cache
      return newToken;
    }
    return null;
  }
}
