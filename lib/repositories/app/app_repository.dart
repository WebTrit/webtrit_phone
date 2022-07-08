import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

class AppRepository {
  AppRepository({
    required this.webtritApiClient,
    required this.token,
  });

  final WebtritApiClient webtritApiClient;
  final String token;

  Future<bool> getRegisterStatus() async {
    final appStatus = await webtritApiClient.appStatus(token);
    return appStatus.register;
  }

  Future<void> setRegisterStatus(bool value) async {
    await webtritApiClient.appStatusUpdate(token, AppStatus(register: value));
  }
}
