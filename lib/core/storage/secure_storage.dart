import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();
  static const String _accessKey = 'access_token';
  static const String _refreshkey = 'refresh_token';
  static Future<void> writeKeys({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshkey, value: refreshToken);
  }

  static Future<String?> readAccessToken() async {
    return await _storage.read(key: _accessKey);
  }

  static Future<String?> readRefreshToken() async {
    return await _storage.read(key: _refreshkey);
  }

  static Future<void> deleteKeys() async {
    await _storage.deleteAll();
  }
}
