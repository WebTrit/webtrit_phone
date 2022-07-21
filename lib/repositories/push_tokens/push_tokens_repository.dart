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

  Future<void> insertOrUpdatePushToken(PushTokenType type, String value) async {
    return await _webtritApiClient.appCreatePushToken(_token, type, value);
  }
}
