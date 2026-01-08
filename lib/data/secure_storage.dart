import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  // Core URL
  String? readCoreUrl();

  Future<void> writeCoreUrl(String coreUrl);

  Future<void> deleteCoreUrl();

  // Tenant ID
  String? readTenantId();

  Future<void> writeTenantId(String tenantId);

  Future<void> deleteTenantId();

  // Token
  String? readToken();

  Future<void> writeToken(String token);

  Future<void> deleteToken();

  // User ID
  String? readUserId();

  Future<void> writeUserId(String userId);

  Future<void> deleteUserId();

  // FCM Token
  String? readFCMPushToken();

  Future<void> writeFCMPushToken(String token);

  // External Page Token (Composite methods)
  String? readExternalPageAccessToken();

  String? readExternalPageRefreshToken();

  String? readExternalPageTokenExpires();

  String? readExternalPageAccessTokenSessionAssociated();

  Future<void> writeExternalPageTokenData(String accessToken, String refreshToken, String expires, String associate);

  Future<void> deleteExternalPageTokenData();

  // System Info
  String? readSystemInfo();

  Future<void> writeSystemInfo(String systemInfo);

  Future<void> deleteSystemInfo();
}

/// The `SecureStorageImpl` class uses a local cache (`_cache`) to store values
/// read from `FlutterSecureStorage`, reducing the number of expensive read/write
/// operations and improving performance.
///
/// Issue:
/// In multi-isolate scenarios, each isolate creates its own instance of `SecureStorage`
/// with an independent local cache. If one isolate updates the data, other isolates
/// will not be aware of the changes because the cache is local and not synchronized
/// across isolates.
///
/// Recommendation:
/// If it is necessary to access up-to-date data in a secondary isolate,
/// consider creating a new instance of `SecureStorage` each time or reading
/// directly from `FlutterSecureStorage`, avoiding reliance on the local cache.
class SecureStorageImpl implements SecureStorage {
  static const _kCoreUrlKey = 'core-url';
  static const _kTenantIdKey = 'tenant-id';
  static const _kTokenKey = 'token';
  static const _kUserIdKey = 'user-id';
  static const _kSystemInfoKey = 'system-info';
  static const _kExternalPageAccessTokenSessionAssociated = 'external-page-access-token-session-associated';
  static const _kExternalPageAccessTokenKey = 'external-page-access-token';
  static const _kExternalPageRefreshTokenKey = 'external-page-refresh-token';
  static const _kExternalPageTokenExpiresKey = 'external-page-token-expires';

  // Last FCM token that was pushed to the server
  static const _kFCMPushToken = 'fcm-push-token';

  static Future<SecureStorage> init() async {
    const storage = FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
    final cache = await storage.readAll();

    // Migration from old version of the app where the user ID wasnt provided to the app
    // to avoid data inconsistency in the cache, we should clear it if the user ID is not present
    if (!cache.containsKey(_kUserIdKey)) {
      cache.clear();
    }

    return SecureStorageImpl._(storage, cache);
  }

  SecureStorageImpl._(this._storage, [this._cache = const {}]);

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

  @override
  String? readCoreUrl() {
    return _read(_kCoreUrlKey);
  }

  @override
  Future<void> writeCoreUrl(String coreUrl) {
    return _write(_kCoreUrlKey, coreUrl);
  }

  @override
  Future<void> deleteCoreUrl() {
    return _delete(_kCoreUrlKey);
  }

  String? _readTenantId() {
    return _read(_kTenantIdKey);
  }

  // TODO: this can be replaces by _readTenantId once all users have migrated to the new version of the app
  // Backwards compatible functionality that if necessary return empty Tenant ID for not null Core URL
  @override
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

  @override
  Future<void> writeTenantId(String tenantId) {
    return _write(_kTenantIdKey, tenantId);
  }

  @override
  Future<void> deleteTenantId() {
    return _delete(_kTenantIdKey);
  }

  @override
  String? readToken() {
    return _read(_kTokenKey);
  }

  @override
  Future<void> writeToken(String token) {
    return _write(_kTokenKey, token);
  }

  @override
  Future<void> deleteToken() {
    return _delete(_kTokenKey);
  }

  @override
  String? readUserId() {
    return _read(_kUserIdKey);
  }

  @override
  Future<void> writeUserId(String userId) {
    return _write(_kUserIdKey, userId);
  }

  @override
  Future<void> deleteUserId() {
    return _delete(_kUserIdKey);
  }

  @override
  String? readFCMPushToken() {
    return _read(_kFCMPushToken);
  }

  @override
  Future<void> writeFCMPushToken(String token) {
    return _write(_kFCMPushToken, token);
  }

  // EXTERNAL PAGE TOKEN

  @override
  String? readExternalPageAccessToken() {
    return _read(_kExternalPageAccessTokenKey);
  }

  @override
  String? readExternalPageRefreshToken() {
    return _read(_kExternalPageRefreshTokenKey);
  }

  @override
  String? readExternalPageTokenExpires() {
    return _read(_kExternalPageTokenExpiresKey);
  }

  @override
  String? readExternalPageAccessTokenSessionAssociated() {
    return _read(_kExternalPageAccessTokenSessionAssociated);
  }

  @override
  Future<void> writeExternalPageTokenData(
    String accessToken,
    String refreshToken,
    String expires,
    String associate,
  ) async {
    await _write(_kExternalPageAccessTokenKey, accessToken);
    await _write(_kExternalPageRefreshTokenKey, refreshToken);
    await _write(_kExternalPageTokenExpiresKey, expires);
    return _write(_kExternalPageAccessTokenSessionAssociated, associate);
  }

  @override
  Future<void> deleteExternalPageTokenData() async {
    await _delete(_kExternalPageAccessTokenKey);
    await _delete(_kExternalPageRefreshTokenKey);
    await _delete(_kExternalPageTokenExpiresKey);
    await _delete(_kExternalPageAccessTokenSessionAssociated);
  }

  // SYSTEM INFO

  @override
  String? readSystemInfo() {
    return _read(_kSystemInfoKey);
  }

  @override
  Future<void> writeSystemInfo(String systemInfo) {
    return _write(_kSystemInfoKey, systemInfo);
  }

  @override
  Future<void> deleteSystemInfo() {
    return _delete(_kSystemInfoKey);
  }
}
