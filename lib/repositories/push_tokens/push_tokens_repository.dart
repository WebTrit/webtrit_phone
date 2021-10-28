import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/secure_storage.dart';

class PushTokensRepository {
  PushTokensRepository({
    required this.webtritApiClient,
    required this.secureStorage,
  });

  final WebtritApiClient webtritApiClient;
  final SecureStorage secureStorage;

  Future<void> insertOrUpdatePushToken(PushTokenType type, String value) async {
    final token = await secureStorage.readToken();
    return await webtritApiClient.appCreatePushToken(token!, type, value);
  }
}
