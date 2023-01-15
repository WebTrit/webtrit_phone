import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

class PushTokensRepository {
  PushTokensRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  Future<void> insertOrUpdatePushToken(AppPushTokenType type, String value) async {
    var appPushToken = AppPushToken(type: type, value: value);
    return await _webtritApiClient.appCreatePushToken(_token, appPushToken);
  }
}
