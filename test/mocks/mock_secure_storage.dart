import 'package:webtrit_phone/data/data.dart';

class MockSecureStorage implements SecureStorage {
  final Map<String, dynamic> _storage;

  MockSecureStorage({Map<String, dynamic>? initialData}) : _storage = initialData ?? {};

  static const _kCoreUrlKey = 'core-url';
  static const _kTenantIdKey = 'tenant-id';
  static const _kTokenKey = 'token';
  static const _kUserIdKey = 'user-id';
  static const _kSystemInfoKey = 'system-info';
  static const _kExternalPageAccessTokenSessionAssociated = 'external-page-access-token-session-associated';
  static const _kExternalPageAccessTokenKey = 'external-page-access-token';
  static const _kExternalPageRefreshTokenKey = 'external-page-refresh-token';
  static const _kExternalPageTokenExpiresKey = 'external-page-token-expires';
  static const _kFCMPushToken = 'fcm-push-token';

  @override
  String? readCoreUrl() {
    return _storage[_kCoreUrlKey];
  }

  @override
  Future<void> writeCoreUrl(String coreUrl) async {
    _storage[_kCoreUrlKey] = coreUrl;
  }

  @override
  Future<void> deleteCoreUrl() async {
    _storage.remove(_kCoreUrlKey);
  }

  @override
  String? readTenantId() {
    final tenantId = _storage[_kTenantIdKey];
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
  Future<void> writeTenantId(String tenantId) async {
    _storage[_kTenantIdKey] = tenantId;
  }

  @override
  Future<void> deleteTenantId() async {
    _storage.remove(_kTenantIdKey);
  }

  @override
  String? readToken() {
    return _storage[_kTokenKey];
  }

  @override
  Future<void> writeToken(String token) async {
    _storage[_kTokenKey] = token;
  }

  @override
  Future<void> deleteToken() async {
    _storage.remove(_kTokenKey);
  }

  @override
  String? readUserId() {
    return _storage[_kUserIdKey];
  }

  @override
  Future<void> writeUserId(String userId) async {
    _storage[_kUserIdKey] = userId;
  }

  @override
  Future<void> deleteUserId() async {
    _storage.remove(_kUserIdKey);
  }

  @override
  Future<void> prefetchSession() async {}

  @override
  Future<void> prefetchSignaling() async {}

  @override
  String? readFCMPushToken() {
    return _storage[_kFCMPushToken];
  }

  @override
  Future<void> writeFCMPushToken(String token) async {
    _storage[_kFCMPushToken] = token;
  }

  @override
  Future<void> deleteFCMPushToken() async {
    _storage.remove(_kFCMPushToken);
  }

  @override
  Future<String?> readExternalPageAccessToken() async {
    return _storage[_kExternalPageAccessTokenKey];
  }

  @override
  Future<String?> readExternalPageAccessTokenSessionAssociated() async {
    return _storage[_kExternalPageAccessTokenSessionAssociated];
  }

  @override
  Future<String?> readExternalPageRefreshToken() async {
    return _storage[_kExternalPageRefreshTokenKey];
  }

  @override
  Future<String?> readExternalPageTokenExpires() async {
    return _storage[_kExternalPageTokenExpiresKey];
  }

  @override
  Future<void> writeExternalPageTokenData(
    String accessToken,
    String refreshToken,
    String expires,
    String associate,
  ) async {
    _storage[_kExternalPageAccessTokenKey] = accessToken;
    _storage[_kExternalPageRefreshTokenKey] = refreshToken;
    _storage[_kExternalPageTokenExpiresKey] = expires;
    _storage[_kExternalPageAccessTokenSessionAssociated] = associate;
  }

  @override
  Future<void> deleteExternalPageTokenData() async {
    _storage.remove(_kExternalPageAccessTokenKey);
    _storage.remove(_kExternalPageRefreshTokenKey);
    _storage.remove(_kExternalPageTokenExpiresKey);
    _storage.remove(_kExternalPageAccessTokenSessionAssociated);
  }

  @override
  String? readSystemInfo() {
    return _storage[_kSystemInfoKey];
  }

  @override
  Future<void> writeSystemInfo(String systemInfo) async {
    _storage[_kSystemInfoKey] = systemInfo;
  }

  @override
  Future<void> deleteSystemInfo() async {
    _storage.remove(_kSystemInfoKey);
  }
}
