import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IpConfigService {
  static const _storage = FlutterSecureStorage();
  static const _ipKey = 'server_ip';

  static Future<String?> getIp() async {
    return await _storage.read(key: _ipKey);
  }

  static Future<void> setIp(String ip) async {
    await _storage.write(key: _ipKey, value: ip);
  }

  static Future<void> clearIp() async {
    await _storage.delete(key: _ipKey);
  }
} 