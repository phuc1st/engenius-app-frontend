import 'package:toeic/config/api_constants.dart';
import 'package:toeic/data/services/api/api_clients/base_api_client.dart';
import 'package:toeic/data/services/api/model/api_response.dart';
import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';

class DeviceTokenApiClient extends BaseApiClient {
  DeviceTokenApiClient() : super();

  Future<ApiResponse<void>> setDeviceToken(String deviceToken) async {
    return makeRequest<void>(
      url: ApiConstants.setDeviceToken,
      method: 'POST',
      queryParameters: {'deviceToken' : deviceToken},
      fromJson: (json) => {},
    );
  }
}
