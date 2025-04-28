import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/api/self_config_mapper.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/models/self_config.dart';

final _logger = Logger('SelfConfigRepository');

/// Repository for accessing self-configuration and external page access tokens.
///
/// External page access token management is designed as follows:
/// - Before injecting the token (e.g., into a WebView), the stored token is validated.
/// - If the token is valid, it is injected once during the initialization phase.
/// - After injection, the WebView becomes fully responsible for refreshing and updating the token as needed.
///
/// Flutter is only responsible for the initial token validation and injection.
/// All subsequent lifecycle management of the token is delegated to the embedded WebView.

// TODO(Serdun): This repository primarily encapsulates private API methods.
// Consider renaming it to better reflect its specialized purpose (e.g., PrivateApiRepository).
class SelfConfigRepository with SelfConfigApiMapper {
  SelfConfigRepository(
    this._webtritApiClient,
    this._secureStorage,
    this._token,
  );

  final api.WebtritApiClient _webtritApiClient;
  final SecureStorage _secureStorage;
  final String _token;

  SelfConfig? _lastSelfConfig;

  Timer? _refreshTimer;

  bool _isFetchingExternalPageToken = false;
  bool _isUnsupportedExternalPageTokenEndpoint = false;

  Future<SelfConfig> _getSelfConfigRemote() async {
    try {
      final response = await _webtritApiClient.getSelfConfig(_token);
      return selfConfigFromApi(response);
    } on api.EndpointNotSupportedException catch (_) {
      return SelfConfig.unsupported();
    }
  }

  Future<SelfConfig> getSelfConfig() async {
    final cached = _lastSelfConfig;

    if (cached is SelfConfigUnsupported) return cached;
    if (cached is SelfConfigSupported && !cached.isExpired) return cached;

    return (_lastSelfConfig = await _getSelfConfigRemote());
  }

  Future<void> fetchExternalPageToken() async {
    if (!_isFetchingExternalPageToken || !_isUnsupportedExternalPageTokenEndpoint) {
      _isFetchingExternalPageToken = true;

      try {
        final requestOptions = api.RequestOptions.withExtraRetries();
        final newToken = await _webtritApiClient.getExternalPageAccessToken(_token, options: requestOptions);

        // Convert the API response to an ExpiringToken
        final externalPageToken = externalPageTokenFromApi(newToken);

        // Store the latest external page access token received from the server in secure storage
        await _secureStorage.writeExternalPageTokenExt(externalPageToken);
      } on api.EndpointNotSupportedException catch (_) {
        // Endpoint is not supported, stop fetching the token
        _isUnsupportedExternalPageTokenEndpoint = true;
        _refreshTimer?.cancel();
      } catch (e, st) {
        // Catch all other errors and try again in 1 minute
        _logger.warning('Failed to fetch external page token: $e', e, st);
        _refreshTimer?.cancel();
        _refreshTimer = Timer(const Duration(minutes: 1), fetchExternalPageToken);
      } finally {
        _isFetchingExternalPageToken = false;
        _tryScheduleTokenRefresh();
      }
    }
  }

  Future<bool> isExternalPageTokenAvailable() async {
    final token = await _secureStorage.readExternalPageTokenExt();
    return token != null && token.isValid;
  }

  Future<void> _tryScheduleTokenRefresh() async {
    // Proceed with scheduling only if the endpoint is supported.
    if (_isUnsupportedExternalPageTokenEndpoint) return;

    // Read the last saved external page token from secure storage.
    // If the token is missing or expired/invalid, skip scheduling.
    final token = await _secureStorage.readExternalPageTokenExt();
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
    _isFetchingExternalPageToken = false;
  }
}

extension SecureStorageExtension on SecureStorage {
  Future<void> writeExternalPageTokenExt(ExternalPageToken token) async {
    await writeExternalPageAccessToken(token.accessToken);
    await writeExternalPageRefreshToken(token.refreshToken);
    await writeExternalPageTokenExpires(token.expiration.toIso8601String());
  }

  Future<ExternalPageToken?> readExternalPageTokenExt() async {
    final accessToken = readExternalPageAccessToken();
    final refreshToken = readExternalPageRefreshToken();
    final expires = readExternalPageTokenExpires();

    final expiresAt = DateTime.tryParse(expires ?? '');

    if (accessToken != null && refreshToken != null && expiresAt != null) {
      return ExternalPageToken(accessToken, refreshToken, expiresAt);
    }
    return null;
  }
}
