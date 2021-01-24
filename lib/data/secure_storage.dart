import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _kTokenKey = 'token';

  static const _storage = FlutterSecureStorage();

  static Future<String> readToken() {
    return _storage.read(key: _kTokenKey);
  }

  static Future<void> writeToken(String token) {
    return _storage.write(key: _kTokenKey, value: token);
  }

  static Future<void> deleteToken() {
    return _storage.delete(key: _kTokenKey);
  }
}
