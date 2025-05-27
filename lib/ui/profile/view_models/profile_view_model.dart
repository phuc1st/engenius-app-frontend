import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/data/repositories/profile/profile_repository.dart';
import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';
import 'package:toeic/ui/profile/view_models/profile_state.dart';
import 'package:toeic/utils/result.dart';

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel();
});

class ProfileViewModel extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileViewModel({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepository(),
        super(const ProfileState());

  Future<void> getMyProfile() async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await _repository.getMyProfile();

      if (response is Ok<UserProfileResponse>) {
        state = state.copyWith(
          isLoading: false,
          userProfileResponse: response.value
        );
      } else if (response is Error<UserProfileResponse>) {
        state = state.copyWith(
          isLoading: false,
          error: response.error.toString()
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString()
      );
    }
  }
} 