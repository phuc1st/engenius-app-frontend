import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toeic/data/services/api/model/profile_response/user_profile__response.dart';

class UserProfileService {
  static final UserProfileService _instance = UserProfileService._internal();

  factory UserProfileService() {
    return _instance;
  }

  UserProfileService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _profileKey = 'user_profile';
  UserProfileResponse? _userProfile;

  Future<UserProfileResponse?> getUserProfile() async {
    if (_userProfile != null) return _userProfile;
    
    final profileJson = await _storage.read(key: _profileKey);
    if (profileJson != null) {
      _userProfile = UserProfileResponse.fromJson(json.decode(profileJson));
    }
    return _userProfile;
  }

  Future<void> setUserProfile(UserProfileResponse profile) async {
    _userProfile = profile;
    await _storage.write(
      key: _profileKey,
      value: json.encode(profile.toJson()),
    );
  }

  Future<void> clearUserProfile() async {
    _userProfile = null;
    await _storage.delete(key: _profileKey);
  }
} 