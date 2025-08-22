import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/common/common.dart';

export 'package:webtrit_api/webtrit_api.dart'
    show Balance, BalanceType, BillingModel, Numbers, UserInfo, $UserInfoCopyWith;

final _logger = Logger('UserRepository');

class UserRepository implements Refreshable {
  UserRepository(
    this.webtritApiClient,
    this.token, {
    SessionGuard? sessionGuard,
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard() {
    _updatesController = StreamController<UserInfo>.broadcast();
  }

  final WebtritApiClient webtritApiClient;
  final String token;
  late final StreamController<UserInfo> _updatesController;
  final SessionGuard _sessionGuard;

  UserInfo? _lastInfo;

  Future<UserInfo?> _gatherUserInfo() async {
    try {
      final newInfo = await webtritApiClient.getUserInfo(token);

      if (newInfo != _lastInfo) _updatesController.add(newInfo);
      _lastInfo = newInfo;
      return newInfo;
    } on UnauthorizedException catch (e, st) {
      _sessionGuard.onUnauthorized(e);
      _logger.warning('_gatherUserInfo: unauthorized', e, st);
      rethrow;
    } on UserNotFoundException catch (e, st) {
      _sessionGuard.onUnauthorized(e);
      _logger.warning('_gatherUserInfo: user not found', e, st);
      rethrow;
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

  Future<void> delete() async {
    await webtritApiClient.deleteUserInfo(token);
  }

  @override
  Future<void> refresh() {
    return _gatherUserInfo();
  }
}
