import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/auth/auth_repository.dart';
import 'package:toeic/data/services/api/api_clients/auth_api_client.dart';
import 'package:toeic/data/services/api/model/login_response/login_response.dart';
import 'package:toeic/data/services/api/model/signup_response/signup_response.dart';
import 'package:toeic/ui/auth/login/view_models/login_view_model.dart';
import 'package:toeic/ui/auth/sign_up/view_models/sign_up_view_model.dart';

final authApiClientProvider = Provider<AuthApiClient>((ref) {
  return AuthApiClient();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.read(authApiClientProvider);
  return AuthRepository(authApiClient: apiClient);
});

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<LoginResponse>>((ref) {
  final loginRepository = ref.read(authRepositoryProvider);
  return LoginViewModel(loginRepository: loginRepository);
});

final signupViewModelProvider =
StateNotifierProvider<SignupViewModel, AsyncValue<SignupResponse?>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return SignupViewModel(authRepository: authRepository);
});