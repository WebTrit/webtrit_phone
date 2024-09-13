import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

export 'package:webtrit_api/webtrit_api.dart'
    show Balance, BalanceType, BillingModel, Numbers, UserInfo, $UserInfoCopyWith;

final _logger = Logger('UserRepository');

class UserRepository {
  UserRepository({
    required WebtritApiClient webtritApiClient,
    required QueueRequestWorker queueRequestWorker,
    required String token,
    bool periodicPolling = true,
  })  : _webtritApiClient = webtritApiClient,
        _queueRequestWorker = queueRequestWorker,
        _token = token,
        _periodicPolling = periodicPolling {
    _controller = StreamController<UserInfo>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final bool _periodicPolling;

  QueueRequestWorker _queueRequestWorker;

  late StreamController<UserInfo> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  UserInfo? _info;

  Future<UserInfo> getInfo() {
    return _webtritApiClient.getUserInfo(_token);
  }

  Stream<UserInfo> info() {
    return _controller.stream;
  }

  void _onListenCallback() async {
    if (_periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 10), (timer) => _gatherUserInfo());
      _gatherUserInfo();
    }
  }

  void _onCancelCallback() {
    if (_periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  void _gatherUserInfo() async {
    try {
      final newInfo = await getInfo();
      if (newInfo != _info) {
        _info = newInfo;
        _controller.add(_info!);
      }
    } catch (e, stackTrace) {
      _logger.warning('_gatherUserInfo', e, stackTrace);
      _controller.addError(e, stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      await _webtritApiClient.deleteSession(
        _token,
        options: RequestOptions.withExtraRetries(),
      );
    } catch (e) {
      if (e is ResponseException) {
        _queueRequestWorker.storeRequest(e.method, e.url, token: _token);
      }
      rethrow;
    }
  }

  Future<void> delete() async {
    await _webtritApiClient.deleteUserInfo(_token);
  }
}
