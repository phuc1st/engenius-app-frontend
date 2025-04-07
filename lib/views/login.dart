import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

// Các thông tin cấu hình Keycloak của bạn:
const String clientId = 'auth-service-engenius';
const String redirectUrl = 'http://localhost:8081';
const String issuer = 'http://localhost:8080'; // Thay đổi theo URL của Keycloak server
const List<String> scopes = ['openid', 'profile', 'email'];

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _accessToken;

  Future<void> _login() async {
    try {
      // Khởi chạy quy trình đăng nhập
      final AuthorizationTokenResponse? result =
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          scopes: scopes,
        ),
      );

      if (result != null) {
        setState(() {
          _accessToken = result.accessToken;
        });
        // Lưu trữ token an toàn dùng flutter_secure_storage
        await secureStorage.write(key: 'access_token', value: result.accessToken);
        await secureStorage.write(key: 'refresh_token', value: result.refreshToken);
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keycloak Flutter Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _login,
              child: Text('Đăng nhập với Keycloak'),
            ),
            if (_accessToken != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Access Token:\n$_accessToken', textAlign: TextAlign.center),
              ),
          ],
        ),
      ),
    );
  }
}

