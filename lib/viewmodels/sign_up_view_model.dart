import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:toeic/models/api_response.dart';
import 'package:toeic/models/sign_up_model.dart';

final signupViewModelProvider = StateNotifierProvider<SignupViewModel, AsyncValue<SignupResponse?>>(
      (ref) => SignupViewModel(),
);

class SignupViewModel extends StateNotifier<AsyncValue<SignupResponse?>> {
  SignupViewModel() : super(const AsyncValue.data(null));

  final Dio _dio = Dio(BaseOptions(
    validateStatus: (status) {
      return status != null && status < 500; // Chỉ quăng lỗi với mã >= 500
    },
  ));

  Future<void> signup(SignupRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await _dio.post(
        'http://localhost:8222/api/v1/identity/users/registration',
        data: request.toJson(),
      );
      final apiResponse = ApiResponse<SignupResponse>.fromJson(
        response.data as Map<String, dynamic>,
            (json) => SignupResponse.fromJson(json as Map<String, dynamic>),
      );
      if (response.statusCode == 200) {
        state = AsyncValue.data(apiResponse.result!); // Trạng thái thành công
      } else {
        state = AsyncValue.error(
          apiResponse.message.toString(),
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
