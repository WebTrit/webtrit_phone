import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _kCoreUrlKey = 'core-url';
  static const _kTenantIdKey = 'tenant-id';
  static const _kTokenKey = 'token';
  static const _kUserIdKey = 'user-id';

  // Last FCM token that was pushed to the server
  static const _kFCMPushToken = 'fcm-push-token';

  static late SecureStorage _instance;

  static Future<void> init() async {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    final cache = await storage.readAll();

    // Migration from old version of the app where the user ID wasnt provided to the app
    // to avoid data inconsistency in the cache, we should clear it if the user ID is not present
    if (!cache.containsKey(_kUserIdKey)) {
      cache.clear();
    }

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

  Future<void> deleteCoreUrl() {
    return _delete(_kCoreUrlKey);
  }

  String? _readTenantId() {
    return _read(_kTenantIdKey);
  }

  // TODO: this can be replaces by _readTenantId once all users have migrated to the new version of the app
  // Backwards compatible functionality that if necessary return empty Tenant ID for not null Core URL
  String? readTenantId() {
    final tenantId = _readTenantId();
    if (tenantId != null) {
      return tenantId;
    } else {
      if (readCoreUrl() != null) {
        return '';
      } else {
        return null;
      }
    }
  }

  Future<void> writeTenantId(String tenantId) {
    return _write(_kTenantIdKey, tenantId);
  }

  Future<void> deleteTenantId() {
    return _delete(_kTenantIdKey);
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

  String? readUserId() {
    return _read(_kUserIdKey);
  }

  Future<void> writeUserId(String userId) {
    return _write(_kUserIdKey, userId);
  }

  Future<void> deleteUserId() {
    return _delete(_kUserIdKey);
  }

  String? readFCMPushToken() {
    return _read(_kFCMPushToken);
  }

  Future<void> writeFCMPushToken(String token) {
    return _write(_kFCMPushToken, token);
  }
}
