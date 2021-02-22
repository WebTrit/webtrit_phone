import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _kTokenKey = 'token';
  static const _kWebRegistrationInitialUrl = 'initial-url';

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

  static Future<String> readWebRegistrationInitialUrl() {
    return _storage.read(key: _kWebRegistrationInitialUrl);
  }

  static Future<void> writeWebRegistrationInitialUrl(String url) {
    return _storage.write(key: _kWebRegistrationInitialUrl, value: url);
  }

  static Future<void> deleteWebRegistrationInitialUrl() {
    return _storage.delete(key: _kWebRegistrationInitialUrl);
  }
}
