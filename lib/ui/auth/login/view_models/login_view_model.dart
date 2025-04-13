import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/auth/auth_repository.dart';
import 'package:toeic/data/services/api/model/login_request/login_request.dart';
import 'package:toeic/data/services/api/model/login_response/login_response.dart';
import 'package:toeic/utils/result.dart';

class LoginViewModel extends StateNotifier<AsyncValue<LoginResponse>> {
  final AuthRepository _loginRepository;

  LoginViewModel({required AuthRepository loginRepository})
      : _loginRepository = loginRepository,
        super(AsyncValue.data(
        LoginResponse(token: '', expiryTime: DateTime.fromMillisecondsSinceEpoch(0)),
      ));

  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading();
    final result = await _loginRepository.login(request);

    if (result is Ok<LoginResponse>) {
      state = AsyncValue.data(result.value);
    } else if (result is Error<LoginResponse>) {
      state = AsyncValue.error(
        result.error.toString(),
        StackTrace.current,
      );
    }
  }
}
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<LoginResponse>>((ref) {
  final loginRepository = ref.read(authRepositoryProvider);
  return LoginViewModel(loginRepository: loginRepository);
});

