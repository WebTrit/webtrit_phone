import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

class AppRepository {
  AppRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  Future<bool> getRegisterStatus() async {
    final appStatus = await _webtritApiClient.getAppStatus(_token);
    return appStatus.register;
  }

  Future<void> setRegisterStatus(bool value) async {
    await _webtritApiClient.updateAppStatus(_token, AppStatus(register: value));
  }
}
