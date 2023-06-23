import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _kCoreUrlKey = 'core-url';
  static const _kTokenKey = 'token';
  static const _kTenantId = 'tenant-id';
  static const _kWebRegistrationInitialUrlKey = 'initial-url';

  static late SecureStorage _instance;

  static Future<void> init() async {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    final cache = await storage.readAll();

    _instance = SecureStorage._(storage, cache);
  }

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._(this._storage, [this._cache = const {}]);

  final FlutterSecureStorage _storage;
  final Map<String, dynamic> _cache;

  String? _read(String key) {
    return _cache[key];
  }

  Future<void> _write(String key, String value) async {
    await _storage.write(key: key, value: value);
    _cache[key] = value;
  }

  Future<void> _delete(String key) async {
    await _storage.delete(key: key);
    _cache.remove(key);
  }

  String? readCoreUrl() {
    return _read(_kCoreUrlKey);
  }

  Future<void> writeCoreUrl(String coreUrl) {
    return _write(_kCoreUrlKey, coreUrl);
  }

  Future<void> writeTenantId(String tenantId) {
    return _write(_kTenantId, tenantId);
  }

  String? readTenantId() {
    return _read(_kTenantId);
  }

  Future<void> deleteTenantId() {
    return _delete(_kTenantId);
  }

  Future<void> deleteCoreUrl() {
    return _delete(_kCoreUrlKey);
  }

  String? readToken() {
    return _read(_kTokenKey);
  }

  Future<void> writeToken(String token) {
    return _write(_kTokenKey, token);
  }

  Future<void> deleteToken() {
    return _delete(_kTokenKey);
  }

  String? readWebRegistrationInitialUrl() {
    return _read(_kWebRegistrationInitialUrlKey);
  }

  Future<void> writeWebRegistrationInitialUrl(String url) {
    return _write(_kWebRegistrationInitialUrlKey, url);
  }

  Future<void> deleteWebRegistrationInitialUrl() {
    return _delete(_kWebRegistrationInitialUrlKey);
  }
}
