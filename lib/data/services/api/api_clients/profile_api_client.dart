import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';

class ProfileApiClient extends BaseApiClient {
  ProfileApiClient() : super();

  Future<ApiResponse<UserProfileResponse>> getMyProfile() async {
    return makeRequest<UserProfileResponse>(
      url: ApiConstants.getMyProfile,
      method: 'GET',
      fromJson: (json) => UserProfileResponse.fromJson(json),
      useToken: true,
    );
  }
}
