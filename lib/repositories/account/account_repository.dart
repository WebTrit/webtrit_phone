import 'dart:async';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/secure_storage.dart';

class AccountRepository {
  AccountRepository({
    required this.webtritApiClient,
    this.periodicPolling = true,
  }) {
    _controller = StreamController<AccountInfo>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  final WebtritApiClient webtritApiClient;
  final bool periodicPolling;

  late StreamController<AccountInfo> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  AccountInfo? _info;

  Stream<AccountInfo> info() {
    return _controller.stream;
  }

  void _onListenCallback() async {
    if (periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        final newInfo = await _listInfo();
        if (newInfo != _info) {
          _info = newInfo;
          _controller.add(_info!);
        }
      });
      _info = await _listInfo();
      _controller.add(_info!);
    }
  }

  void _onCancelCallback() {
    if (periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  Future<AccountInfo> _listInfo() async {
    final token = await SecureStorage().readToken();
    return await webtritApiClient.accountInfo(token!);
  }

  Future<void> logout() async {
    final token = await SecureStorage().readToken();
    await webtritApiClient.sessionLogout(token!);
  }
}
