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
    return await _webtritApiClient.createAppPushToken(
      _token,
      appPushToken,
      // TODO(Serdun): Retry up to 100 times with a 1-second delay between attempts. This is necessary to ensure FCM token registration.
      // Note: This does not cover all cases (e.g., extended lack of internet); 100 retries cover approximately 2 minutes.
      // Additional logic may be needed for handling prolonged connectivity issues.
      options: const RequestOptions(retries: 100),
    );
  }
}
