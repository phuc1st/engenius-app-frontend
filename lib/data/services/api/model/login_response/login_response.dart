class LoginResponse {
  final String token;
  final String refreshToken;
  final DateTime expiryTime;

  const LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.expiryTime
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'token': String token,
      'refreshToken' : String refreshToken,
      'expiryTime': String expiryTime,
      } =>
          LoginResponse(
            token: token,
            refreshToken: refreshToken,
            expiryTime: DateTime.parse(expiryTime).toLocal(),
          ),
      _ => throw const FormatException("Invalid login_response.dart response format")
    };
  }
}