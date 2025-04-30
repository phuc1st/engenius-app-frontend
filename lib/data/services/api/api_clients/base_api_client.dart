import 'dart:io';

import 'package:dio/dio.dart';
import 'package:toeic/data/services/api/model/api_response.dart';

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
          );

  Future<ApiResponse<T>> makeRequest<T>({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await dio.request(
        url,
        data: body,
        options: Options(method: method),
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
    }
    on SocketException {
      // Bắt lỗi network (nếu không có kết nối internet chẳng hạn)
      return ApiResponse<T>(
        code: -1,
        message: 'Không có kết nối internet. Vui lòng kiểm tra mạng của bạn.',
      );
    }catch (e) {
      return ApiResponse<T>(
        code: -1,
        result: null,
        message: 'Unexpected error: $e',
      );
    }
  }
}
