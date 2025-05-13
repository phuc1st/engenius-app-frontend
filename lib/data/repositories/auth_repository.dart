import 'package:dio/dio.dart';
import '../models/user.dart';
import '../../config/api_config.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return User.fromJson(response.data['data']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/auth/register',
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
        },
      );

      return User.fromJson(response.data['data']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post('${ApiConfig.baseUrl}/auth/logout');
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get('${ApiConfig.baseUrl}/auth/me');
      return User.fromJson(response.data['data']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> updateProfile({
    String? fullName,
    String? phone,
    String? level,
    String? avatarUrl,
  }) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.baseUrl}/auth/profile',
        data: {
          if (fullName != null) 'fullName': fullName,
          if (phone != null) 'phone': phone,
          if (level != null) 'level': level,
          if (avatarUrl != null) 'avatarUrl': avatarUrl,
        },
      );

      return User.fromJson(response.data['data']);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<String> uploadAvatar(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        '${ApiConfig.baseUrl}/auth/upload-avatar',
        data: formData,
      );

      return response.data['data']['url'];
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response?.data != null) {
        final message = error.response?.data['message'] as String?;
        return Exception(message ?? 'Có lỗi xảy ra');
      }
      return Exception('Không thể kết nối đến máy chủ');
    }
    return Exception('Có lỗi xảy ra');
  }
} 