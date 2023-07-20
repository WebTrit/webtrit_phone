import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

export 'package:webtrit_api/webtrit_api.dart' show User, Balance, SipData, BillingModel, BalanceType;

final _logger = Logger('$AccountRepository');

class AccountRepository {
  AccountRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
    bool periodicPolling = true,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _periodicPolling = periodicPolling {
    _controller = StreamController<User>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final bool _periodicPolling;

  late StreamController<User> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  User? _info;

  Future<User> getInfo() {
    return _webtritApiClient.userInfo(_token);
  }

  Stream<User> info() {
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
