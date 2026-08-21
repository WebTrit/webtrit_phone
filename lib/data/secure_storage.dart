import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  // Core URL
  Future<String?> readCoreUrl();

  Future<void> writeCoreUrl(String coreUrl);

  Future<void> deleteCoreUrl();

  // Tenant ID
  Future<String?> readTenantId();

  Future<void> writeTenantId(String tenantId);

  Future<void> deleteTenantId();

  // Token
  Future<String?> readToken();

  Future<void> writeToken(String token);

  Future<void> deleteToken();

  // User ID
  Future<String?> readUserId();

  Future<void> writeUserId(String userId);

  Future<void> deleteUserId();

  // External Page Token (Composite methods)
  Future<String?> readExternalPageAccessToken();

  Future<String?> readExternalPageRefreshToken();

  Future<String?> readExternalPageTokenExpires();

  Future<String?> readExternalPageAccessTokenSessionAssociated();

  Future<void> writeExternalPageTokenData(String accessToken, String refreshToken, String expires, String associate);

  Future<void> deleteExternalPageTokenData();
}

/// Reads a record the first time it is asked for and remembers it, so every
/// later read of that record is answered from memory. Nothing has to be loaded
/// up front, and adding a record needs no list kept in step: it costs one
/// keychain read the first time somebody wants it.
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
  static const _kExternalPageAccessTokenSessionAssociated = 'external-page-access-token-session-associated';
  static const _kExternalPageAccessTokenKey = 'external-page-access-token';
  static const _kExternalPageRefreshTokenKey = 'external-page-refresh-token';
  static const _kExternalPageTokenExpiresKey = 'external-page-token-expires';

  static Future<SecureStorage> init() async {
    const storage = FlutterSecureStorage(iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));
    return SecureStorageImpl._(storage);
  }

  SecureStorageImpl._(this._storage);

  final FlutterSecureStorage _storage;

  /// Records already known, absent ones included: a key present here with a
  /// null value means the keychain has nothing under it.
  final Map<String, String?> _cache = {};

  /// Reads in progress, so simultaneous readers of the same record share one
  /// keychain round trip instead of racing each other.
  final Map<String, Future<String?>> _inFlight = {};

  /// Bumped by every write and delete, so a read that started earlier cannot
  /// put the older value back into the cache when it lands.
  final Map<String, int> _versions = {};

  Future<String?> _read(String key) {
    if (_cache.containsKey(key)) return Future.value(_cache[key]);

    final pending = _inFlight[key];
    if (pending != null) return pending;

    final version = _versions[key] ?? 0;
    final future = _storage.read(key: key).then((value) {
      if ((_versions[key] ?? 0) == version) _cache[key] = value;
      return _cache.containsKey(key) ? _cache[key] : value;
    });
    _inFlight[key] = future;
    return future.whenComplete(() => _inFlight.remove(key));
  }

  /// The session records are only honoured while a user id is stored with
  /// them. Installations that predate that key kept a session the app can no
  /// longer make sense of, and it is treated as no session at all.
  ///
  /// The rule applies to what the keychain holds, not to what this app wrote:
  /// a value written here is authoritative, so writing a token before a user id
  /// exists cannot make it unreadable. Both reads start together, so honouring
  /// the rule costs no extra round trip.
  Future<String?> _readSessionRecord(String key) async {
    if (_cache.containsKey(key)) return _cache[key];

    final stored = _read(key);
    if (await _read(_kUserIdKey) == null) {
      await stored;
      // Forget it as well, so the stale session cannot resurface once a user
      // id appears.
      _cache.remove(key);
      return null;
    }
    return stored;
  }

  Future<void> _write(String key, String value) async {
    await _storage.write(key: key, value: value);
    _versions[key] = (_versions[key] ?? 0) + 1;
    _cache[key] = value;
  }

  Future<void> _delete(String key) async {
    await _storage.delete(key: key);
    _versions[key] = (_versions[key] ?? 0) + 1;
    _cache[key] = null;
  }

  @override
  Future<String?> readCoreUrl() {
    return _readSessionRecord(_kCoreUrlKey);
  }

  @override
  Future<void> writeCoreUrl(String coreUrl) {
    return _write(_kCoreUrlKey, coreUrl);
  }

  @override
  Future<void> deleteCoreUrl() {
    return _delete(_kCoreUrlKey);
  }

  Future<String?> _readTenantId() {
    return _readSessionRecord(_kTenantIdKey);
  }

  // TODO: this can be replaces by _readTenantId once all users have migrated to the new version of the app
  // Backwards compatible functionality that if necessary return empty Tenant ID for not null Core URL
  @override
  Future<String?> readTenantId() async {
    final tenantId = await _readTenantId();
    if (tenantId != null) return tenantId;
    return await readCoreUrl() != null ? '' : null;
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
  Future<String?> readToken() {
    return _readSessionRecord(_kTokenKey);
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
  Future<String?> readUserId() {
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

  // EXTERNAL PAGE TOKEN

  @override
  Future<String?> readExternalPageAccessToken() {
    return _read(_kExternalPageAccessTokenKey);
  }

  @override
  Future<String?> readExternalPageAccessTokenSessionAssociated() {
    return _read(_kExternalPageAccessTokenSessionAssociated);
  }

  @override
  Future<String?> readExternalPageRefreshToken() {
    return _read(_kExternalPageRefreshTokenKey);
  }

  @override
  Future<String?> readExternalPageTokenExpires() {
    return _read(_kExternalPageTokenExpiresKey);
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
}
