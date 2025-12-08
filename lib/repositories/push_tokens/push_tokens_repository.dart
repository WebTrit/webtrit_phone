import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/session/session.dart';

class PushTokensRepository {
  PushTokensRepository({required WebtritApiClient webtritApiClient, required String token, SessionGuard? sessionGuard})
    : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
      _webtritApiClient = webtritApiClient,
      _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  Future<void> insertOrUpdatePushToken(AppPushTokenType type, String value) async {
    var appPushToken = AppPushToken(type: type, value: value);

    try {
      return await _webtritApiClient.createAppPushToken(_token, appPushToken);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }
}
