import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IpStorageService {
  static const String _ipKey = 'server_ip';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveIp(String ip) async {
    await _storage.write(key: _ipKey, value: ip);
  }

  Future<String?> getIp() async {
    return await _storage.read(key: _ipKey);
  }

  Future<void> deleteIp() async {
    await _storage.delete(key: _ipKey);
  }
} 