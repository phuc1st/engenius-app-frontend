import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/auth/auth_repository.dart';
import 'package:toeic/data/services/api/model/signup_request/signup_request.dart';
import 'package:toeic/data/services/api/model/signup_response/signup_response.dart';
import 'package:toeic/provider/auth_providers.dart';
import 'package:toeic/utils/result.dart';

class SignupViewModel extends StateNotifier<AsyncValue<SignupResponse?>> {
  final AuthRepository _authRepository;

  SignupViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AsyncValue.data(null));

  Future<void> signup(SignupRequest request) async {
    state = const AsyncValue.loading();

    final result = await _authRepository.signup(request);

    if (result is Ok<SignupResponse>) {
      state = AsyncValue.data(result.value);
    } else if (result is Error<SignupResponse>) {
      state = AsyncValue.error(result.error.toString(), StackTrace.current);
    }
  }
}
