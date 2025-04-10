import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String? cachedToken;

Future<String?> getToken() async {
  if (cachedToken == null) {
    final storage = FlutterSecureStorage();
    cachedToken = await storage.read(key: 'access_token');
  }
  return cachedToken;
}