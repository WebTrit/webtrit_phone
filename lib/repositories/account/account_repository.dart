import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/secure_storage.dart';

final _logger = Logger('$AccountRepository');

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
      _periodicTimer = Timer.periodic(const Duration(seconds: 10), (timer) => _gatherAccountInfo());
      _gatherAccountInfo();
    }
  }

  void _onCancelCallback() {
    if (periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  void _gatherAccountInfo() async {
    try {
      final newInfo = await _accountInfo();
      if (newInfo != _info) {
        _info = newInfo;
        _controller.add(_info!);
      }
    } catch (e, stackTrace) {
      _logger.warning('_gatherAccountInfo', e, stackTrace);
    }
  }

  Future<AccountInfo> _accountInfo() async {
    final token = await SecureStorage().readToken();
    return await webtritApiClient.accountInfo(token!);
  }

  Future<void> logout() async {
    final token = await SecureStorage().readToken();
    await webtritApiClient.sessionLogout(token!);
  }
}
