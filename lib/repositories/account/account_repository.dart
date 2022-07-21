import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

final _logger = Logger('$AccountRepository');

class AccountRepository {
  AccountRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
    bool periodicPolling = true,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _periodicPolling = periodicPolling {
    _controller = StreamController<AccountInfo>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final bool _periodicPolling;

  late StreamController<AccountInfo> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  AccountInfo? _info;

  Future<AccountInfo> getInfo() {
    return _webtritApiClient.accountInfo(_token);
  }

  Stream<AccountInfo> info() {
    return _controller.stream;
  }

  void _onListenCallback() async {
    if (_periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 10), (timer) => _gatherAccountInfo());
      _gatherAccountInfo();
    }
  }

  void _onCancelCallback() {
    if (_periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  void _gatherAccountInfo() async {
    try {
      final newInfo = await getInfo();
      if (newInfo != _info) {
        _info = newInfo;
        _controller.add(_info!);
      }
    } catch (e, stackTrace) {
      _logger.warning('_gatherAccountInfo', e, stackTrace);
    }
  }

  Future<void> logout() async {
    await _webtritApiClient.sessionLogout(_token);
  }
}
