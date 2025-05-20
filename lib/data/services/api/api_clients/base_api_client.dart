import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/local/token_service.dart';

abstract class BaseApiClient {
  final Dio dio;

  BaseApiClient({Dio? dio, Map<String, dynamic>? defaultHeaders})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              validateStatus: (status) {
                if (status == 401) return false;
                return status != null && status < 600;
              },
              headers: defaultHeaders ?? {'Content-Type': 'application/json'},
            ),
          ) {
    this.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final useToken = options.extra['useToken'] ?? false;
          if (useToken) {
            final accessToken = await TokenManager().getAccessToken();
            if (accessToken != null && accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
          handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final useToken = error.requestOptions.extra['useToken'] ?? false;
          if (useToken && error.response?.statusCode == 401) {
            try {
              final newToken = await _refreshToken();
              if (newToken != null) {
                // Retry lại request ban đầu với token mới
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';
                final retryResponse = await this.dio.fetch(
                  error.requestOptions,
                );
                return handler.resolve(retryResponse);
              }
            } catch (e) {
              // Refresh token thất bại
            }
          }
          handler.next(error); // Nếu không xử lý được, trả lỗi về client
        },
      ),
    );
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await TokenManager().getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final refreshDio = Dio(BaseOptions(
      headers: {'Content-Type': 'application/json'},
    ));

    final response = await refreshDio.post(
      'http://localhost:8222/api/v1/identity/auth/refresh',
      data: {
        'token': refreshToken
      },
    );

    if (response.statusCode == 200) {
      final newToken = response.data['result']['token'];
      final storage = const FlutterSecureStorage();
      await storage.write(key: 'access_token', value: newToken);
      TokenManager().setTokens(accessToken: newToken); // Cập nhật cache
      return newToken;
    }
    return null;
  }

  Future<ApiResponse<T>> makeRequest<T>({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    required T Function(dynamic json) fromJson,
    Map<String, dynamic>? queryParameters,
    bool useToken = false,
  }) async {
    try {
      final response = await dio.request(
        url,
        data: body,
        options: Options(method: method, extra: {'useToken': useToken}),
        queryParameters: queryParameters,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ApiResponse<T>.fromJson(
          response.data as Map<String, dynamic>,
          fromJson,
        );
      } else {
        return ApiResponse<T>(
          code: response.statusCode ?? -1,
          result: null,
          message: response.data?['message'] ?? 'Server error',
        );
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        return ApiResponse<T>(
          code: dioError.response?.statusCode ?? -1,
          result: null,
          message: dioError.response?.data?['message'] ?? dioError.message,
        );
      }
      return ApiResponse<T>(code: -1, result: null, message: dioError.message);
    } on SocketException {
      // Bắt lỗi network (nếu không có kết nối internet chẳng hạn)
      return ApiResponse<T>(
        code: -1,
        message: 'Không có kết nối internet. Vui lòng kiểm tra mạng của bạn.',
      );
    } catch (e) {
      return ApiResponse<T>(
        code: -1,
        result: null,
        message: 'Unexpected error: $e',
      );
    }
  }
}
