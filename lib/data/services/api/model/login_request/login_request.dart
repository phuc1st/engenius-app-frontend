class LoginRequest {
  final String username;
  final String password;
  final bool rememberUser;

  const LoginRequest({
    required this.username,
    required this.password,
    required this.rememberUser
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'rememberUser': rememberUser
  };
}