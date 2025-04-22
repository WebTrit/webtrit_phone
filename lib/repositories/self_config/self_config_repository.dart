import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/api/self_config_mapper.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/models/self_config.dart';

// TODO(Serdun): Handle each error case properly.
class SelfConfigRepository with SelfConfigApiMapper {
  SelfConfigRepository(
    this._webtritApiClient,
    this._secureStorage,
    this._token,
  ) {
    _preloadTokenToCache();
  }

  final WebtritApiClient _webtritApiClient;
  final SecureStorage _secureStorage;
  final String _token;

  SelfConfig? _lastSelfConfig;

  ExpiringToken? externalPageToken;
  Timer? _refreshTimer;
  bool _isFetchingToken = false;

  final _externalPageTokenController = StreamController<ExpiringToken>.broadcast();

  Stream<ExpiringToken> get externalPageTokenStream => _externalPageTokenController.stream;

  Future<void> _preloadTokenToCache() async {
    final response = await _webtritApiClient.getExternalPageAccessToken(_token);
    await _writeTokenToCache(response);
  }

  Future<SelfConfig> _getSelfConfigRemote() async {
    try {
      final response = await _webtritApiClient.getSelfConfig(_token);
      return selfConfigFromApi(response);
    } on RequestFailure catch (e) {
      if (e.statusCode == 404 || e.statusCode == 501) {
        return SelfConfig.unsupported();
      }
      rethrow;
    }
  }

  Future<SelfConfig> getSelfConfig() async {
    final cached = _lastSelfConfig;

    if (cached is SelfConfigUnsupported) return cached;
    if (cached is SelfConfigSupported && !cached.isExpired) return cached;

    return (_lastSelfConfig = await _getSelfConfigRemote());
  }

  Future<void> fetchExternalPageToken() async {
    if (_isFetchingToken) return;

    _isFetchingToken = true;
    try {
      final now = DateTime.now();

      final cached = _readCachedToken();
      if (cached != null && now.isBefore(cached.expiration)) {
        externalPageToken = cached;
        return;
      }

      final newToken = await _webtritApiClient.getExternalPageAccessToken(_token);
      await _writeTokenToCache(newToken);

      externalPageToken = externalPageTokenFromApi(newToken);
      _externalPageTokenController.add(externalPageToken!);
    } finally {
      _isFetchingToken = false;
      _scheduleTokenRefresh();
    }
  }

  Future<String?> getExternalPageToken() async {
    if (_isTokenStillValid()) {
      return externalPageToken!.token;
    }

    await fetchExternalPageToken();
    return externalPageToken?.token;
  }

  bool isExternalPageTokenAvailable() => _isTokenStillValid();

  bool _isTokenStillValid() {
    final token = externalPageToken;
    return token != null && token.isValid;
  }

  ExpiringToken? _readCachedToken() {
    final token = _secureStorage.readExternalPageToken();
    final expiresAt = DateTime.tryParse(_secureStorage.readExternalPageTokenExpires() ?? '');
    if (token != null && expiresAt != null) {
      return ExpiringToken(token, expiresAt);
    }
    return null;
  }

  Future<void> _writeTokenToCache(ExternalPageAccessToken token) async {
    await _secureStorage.writeExternalPageToken(token.token);
    await _secureStorage.writeExternalPageTokenExpires(token.expiresAt.toIso8601String());
  }

  void _scheduleTokenRefresh() {
    final token = externalPageToken;
    if (token == null || !token.isValid) return;

    _refreshTimer?.cancel();

    final refreshAt = token.expiration.subtract(const Duration(minutes: 1));
    final delay = refreshAt.difference(DateTime.now());

    if (delay.isNegative) {
      fetchExternalPageToken();
    } else {
      _refreshTimer = Timer(delay, fetchExternalPageToken);
    }
  }

  void dispose() {
    _refreshTimer?.cancel();
    _externalPageTokenController.close();
  }
}
