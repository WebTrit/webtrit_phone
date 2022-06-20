import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

class PushTokensRepository {
  PushTokensRepository({
    required this.webtritApiClient,
    required this.token,
  });

  final WebtritApiClient webtritApiClient;
  final String token;

  Future<void> insertOrUpdatePushToken(PushTokenType type, String value) async {
    return await webtritApiClient.appCreatePushToken(token, type, value);
  }
}
