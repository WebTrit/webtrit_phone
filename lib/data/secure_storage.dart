import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app_preferences.dart';

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

  /// Loads the credentials required by the foreground session and router.
  Future<void> prefetchSession();

  /// Loads the credentials required by background signaling isolates.
  Future<void> prefetchSignaling();

  // FCM Token
  String? readFCMPushToken();

  Future<void> writeFCMPushToken(String token);

  Future<void> deleteFCMPushToken();

  // External Page Token (on-demand asynchronous reads)
  Future<String?> readExternalPageAccessToken();

  Future<String?> readExternalPageRefreshToken();

  Future<String?> readExternalPageTokenExpires();

  Future<String?> readExternalPageAccessTokenSessionAssociated();

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
  static const _kNonSecretStorageMigrationDone = 'secure-storage-non-secret-migration-done';
  static const _kLegacySessionMigrationDone = 'secure-storage-legacy-session-migration-done';

  static Future<SecureStorage> init() async {
    const storage = FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
    return SecureStorageImpl._(storage);
  }

  /// Migrates values written by versions that stored non-secret caches in the
  /// keychain. This is deliberately separate from [init], so initializing the
  /// secure storage no longer decrypts unrelated records on the startup path.
  static Future<void> migrateNonSecretStorage(AppPreferences appPreferences) async {
    if (appPreferences.getBool(_kNonSecretStorageMigrationDone) == true) return;

    const storage = FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

    if (appPreferences.getSystemInfo() == null) {
      final systemInfo = await storage.read(key: _kSystemInfoKey);
      if (systemInfo != null) {
        await appPreferences.setSystemInfo(systemInfo);
        await storage.delete(key: _kSystemInfoKey);
      }
    }

    if (appPreferences.getFcmPushToken() == null) {
      final fcmToken = await storage.read(key: _kFCMPushToken);
      if (fcmToken != null) {
        await appPreferences.setFcmPushToken(fcmToken);
        await storage.delete(key: _kFCMPushToken);
      }
    }

    await appPreferences.setBool(_kNonSecretStorageMigrationDone, true);
  }

  /// Permanently removes credentials from installations that predate the
  /// user-id key. Older versions only hid these values in their in-memory
  /// cache, so the same check ran on every startup.
  static Future<void> migrateLegacySession(AppPreferences appPreferences) async {
    if (appPreferences.getBool(_kLegacySessionMigrationDone) == true) return;

    const storage = FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
    final keys = <String>[
      _kCoreUrlKey,
      _kTenantIdKey,
      _kTokenKey,
      _kUserIdKey,
      _kExternalPageAccessTokenKey,
      _kExternalPageRefreshTokenKey,
      _kExternalPageTokenExpiresKey,
      _kExternalPageAccessTokenSessionAssociated,
    ];
    final values = await Future.wait(keys.map((key) => storage.read(key: key)));
    if (values[3] == null && values.any((value) => value != null)) {
      await Future.wait(keys.map((key) => storage.delete(key: key)));
    }

    await appPreferences.setBool(_kLegacySessionMigrationDone, true);
  }

  SecureStorageImpl._(this._storage);

  final FlutterSecureStorage _storage;
  final Map<String, String> _cache = {};
  final Set<String> _loadedKeys = {};
  final Map<String, int> _versions = {};

  String? _read(String key) {
    assert(_loadedKeys.contains(key), 'SecureStorage key "$key" was read before it was prefetched');
    return _cache[key];
  }

  Future<void> _prefetch(Iterable<String> keys) async {
    final keyList = keys.toList(growable: false);
    final versions = {for (final key in keyList) key: _versions[key] ?? 0};
    final values = await Future.wait(keyList.map((key) => _storage.read(key: key)));
    // Preserve the legacy migration behavior: records from installations that
    // predate the user-id key are treated as an empty session. The explicit
    // on-disk migration is handled separately in the next storage step.
    final userIdIndex = keyList.indexOf(_kUserIdKey);
    if (userIdIndex != -1 && values[userIdIndex] == null) {
      for (var i = 0; i < userIdIndex; i++) {
        values[i] = null;
      }
    }
    var index = 0;
    for (final key in keyList) {
      if ((_versions[key] ?? 0) == versions[key]) {
        final value = values[index];
        if (value == null) {
          _cache.remove(key);
        } else {
          _cache[key] = value;
        }
        _loadedKeys.add(key);
      }
      index++;
    }
  }

  @override
  Future<void> prefetchSession() => _prefetch(const [_kCoreUrlKey, _kTenantIdKey, _kTokenKey, _kUserIdKey]);

  @override
  Future<void> prefetchSignaling() => _prefetch(const [_kCoreUrlKey, _kTenantIdKey, _kTokenKey]);

  Future<void> _write(String key, String value) async {
    await _storage.write(key: key, value: value);
    _versions[key] = (_versions[key] ?? 0) + 1;
    _cache[key] = value;
    _loadedKeys.add(key);
  }

  Future<void> _delete(String key) async {
    await _storage.delete(key: key);
    _versions[key] = (_versions[key] ?? 0) + 1;
    _cache.remove(key);
    _loadedKeys.add(key);
  }

  Future<String?> _readExternal(String key) async {
    final version = _versions[key] ?? 0;
    final value = await _storage.read(key: key);
    if ((_versions[key] ?? 0) == version) {
      if (value == null) {
        _cache.remove(key);
      } else {
        _cache[key] = value;
      }
      _loadedKeys.add(key);
    }
    return value;
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

  @override
  Future<void> deleteFCMPushToken() {
    return _delete(_kFCMPushToken);
  }

  // EXTERNAL PAGE TOKEN

  @override
  Future<String?> readExternalPageAccessToken() {
    return _readExternal(_kExternalPageAccessTokenKey);
  }

  @override
  Future<String?> readExternalPageRefreshToken() {
    return _readExternal(_kExternalPageRefreshTokenKey);
  }

  @override
  Future<String?> readExternalPageTokenExpires() {
    return _readExternal(_kExternalPageTokenExpiresKey);
  }

  @override
  Future<String?> readExternalPageAccessTokenSessionAssociated() {
    return _readExternal(_kExternalPageAccessTokenSessionAssociated);
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
