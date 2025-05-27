import 'package:toeic/data/repositories/base_repository.dart';
import 'package:toeic/data/services/api/api_clients/profile_api_client.dart';
import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';
import 'package:toeic/utils/result.dart';

class ProfileRepository extends BaseRepository{
  final ProfileApiClient _apiClient;

  ProfileRepository({ProfileApiClient? apiClient})
      : _apiClient = apiClient ?? ProfileApiClient();

  Future<Result<UserProfileResponse>> getMyProfile() async {
    final apiResponse = await _apiClient.getMyProfile();
    return handleApiResponse(apiResponse);
  }

} 