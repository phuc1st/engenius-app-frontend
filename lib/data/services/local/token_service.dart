import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _accessToken;
  String? _refreshToken;

  Future<String?> getAccessToken() async {
    _accessToken ??= await _storage.read(key: 'access_token');
    return _accessToken;
  }

  Future<String?> getRefreshToken() async {
    _refreshToken ??= await _storage.read(key: 'refresh_token');
    return _refreshToken;
  }

  Future<void> setTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    if (accessToken != null) {
      _accessToken = accessToken;
      await _storage.write(key: 'access_token', value: accessToken);
    }

    if (refreshToken != null) {
      _refreshToken = refreshToken;
      await _storage.write(key: 'refresh_token', value: refreshToken);
    }
  }


  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
