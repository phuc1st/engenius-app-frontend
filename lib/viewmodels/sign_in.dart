import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:toeic/models/api_response.dart';
import 'package:toeic/models/sign_in.dart';

final loginViewModelProvider =
StateNotifierProvider<LoginViewModel, AsyncValue<LoginResponse>>(
      (ref) => LoginViewModel(),
);

class LoginViewModel extends StateNotifier<AsyncValue<LoginResponse>> {
  LoginViewModel()
      : super(
    AsyncValue.data(
      LoginResponse(
        token: "",
        expiryTime: DateTime.fromMillisecondsSinceEpoch(0),
      ),
    ),
  );

  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status != null && status < 500; // Chỉ quăng lỗi với mã >= 500
    },
  ));

  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading(); // Khi bắt đầu đăng nhập, đặt trạng thái là loading

    try {
      final response = await _dio.post(
        'http://localhost:8222/api/v1/identity/auth/token',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse<LoginResponse>.fromJson(
          response.data as Map<String, dynamic>,
              (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
        );
        state = AsyncValue.data(apiResponse.result!); // Trạng thái thành công
      } else {
        state = AsyncValue.error(
          response.statusMessage.toString(),
          StackTrace.current,
        );
      }
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st); // Xử lý lỗi trong khối catch
    }
  }
}

