class LoginResponse {
  final String token;
  final DateTime expiryTime;

  const LoginResponse({
    required this.token,
    required this.expiryTime
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'token': String token,
      'expiryTime': String expiryTime,
      } =>
          LoginResponse(
            token: token,
            expiryTime: DateTime.parse(expiryTime).toLocal(),
          ),
      _ => throw const FormatException("Invalid login_response.dart response format")
    };
  }
}