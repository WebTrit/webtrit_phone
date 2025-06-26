import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

export 'package:webtrit_api/webtrit_api.dart'
    show Balance, BalanceType, BillingModel, Numbers, UserInfo, $UserInfoCopyWith;

final _logger = Logger('UserRepository');

class UserRepository {
  UserRepository(
    this.webtritApiClient,
    this.token, {
    this.polling = true,
    this.pollPeriod = const Duration(seconds: 10),
    this.sessionCleanupWorker,
  }) {
    _updatesController = StreamController<UserInfo>.broadcast(
      onListen: _onListen,
      onCancel: _onCancel,
    );
  }

  final WebtritApiClient webtritApiClient;
  final String token;
  final bool polling;
  final Duration pollPeriod;
  final SessionCleanupWorker? sessionCleanupWorker;
  late final StreamController<UserInfo> _updatesController;

  Timer? _pullTimer;
  UserInfo? _lastInfo;

  /// Pay attention, this callback calling only on first listener
  /// read [StreamController.broadcast]
  void _onListen() async {
    if (polling) {
      _pullTimer = Timer.periodic(pollPeriod, (_) => _gatherUserInfo().ignore());
    }
  }

  void _onCancel() {
    _pullTimer?.cancel();
    _pullTimer = null;
  }

  Future<UserInfo?> _gatherUserInfo() async {
    try {
      final newInfo = await webtritApiClient.getUserInfo(token);
      if (newInfo != _lastInfo) _updatesController.add(newInfo);
      _lastInfo = newInfo;
      return newInfo;
    } on UserNotFoundException catch (e, stackTrace) {
      _logger.warning('_gatherUserInfo: user not found', e, stackTrace);
      _updatesController.addError(e, stackTrace);
      return null;
    } catch (e, stackTrace) {
      _logger.warning('_gatherUserInfo', e, stackTrace);
      _updatesController.addError(e, stackTrace);
      rethrow;
    }
  }

  Future<UserInfo?> getInfo([bool force = false]) {
    if (force == false && _lastInfo != null) {
      return Future.value(_lastInfo);
    } else {
      return _gatherUserInfo();
    }
  }

  Stream<UserInfo> infoUpdates() => _updatesController.stream;

  Stream<UserInfo> getInfoAndListen() async* {
    final info = _lastInfo ?? await _gatherUserInfo();
    if (info != null) yield info;
    yield* _updatesController.stream;
  }

  Future<void> logout() async {
    try {
      await webtritApiClient.deleteSession(token, options: RequestOptions.withExtraRetries());
    } catch (e) {
      if (e is RequestFailure && e.statusCode == null) sessionCleanupWorker?.saveFailedSession(e.url, token: token);
      rethrow;
    }
  }

  Future<void> delete() async {
    await webtritApiClient.deleteUserInfo(token);
  }
}
