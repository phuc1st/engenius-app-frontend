import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserProfileResponse? userProfileResponse;

  const ProfileState({
    this.isLoading = true,
    this.error,
    this.userProfileResponse,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserProfileResponse? userProfileResponse,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userProfileResponse: userProfileResponse ?? this.userProfileResponse,
    );
  }
}
