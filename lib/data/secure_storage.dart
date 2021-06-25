import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _kTokenKey = 'token';
  static const _kWebRegistrationInitialUrl = 'initial-url';

  static const _storage = FlutterSecureStorage();

  static final SecureStorage _instance = SecureStorage._();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._();

  Future<String?> readToken() {
    return _storage.read(key: _kTokenKey);
  }

  Future<void> writeToken(String token) {
    return _storage.write(key: _kTokenKey, value: token);
  }

  Future<void> deleteToken() {
    return _storage.delete(key: _kTokenKey);
  }

  Future<String?> readWebRegistrationInitialUrl() {
    return _storage.read(key: _kWebRegistrationInitialUrl);
  }

  Future<void> writeWebRegistrationInitialUrl(String url) {
    return _storage.write(key: _kWebRegistrationInitialUrl, value: url);
  }

  Future<void> deleteWebRegistrationInitialUrl() {
    return _storage.delete(key: _kWebRegistrationInitialUrl);
  }
}
