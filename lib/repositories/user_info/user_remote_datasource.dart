import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_api/webtrit_api.dart'
    show SessionMissingException, UnauthorizedException, UserNotFoundException, WebtritApiClient;

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/common/disposable.dart';
import 'package:webtrit_phone/mappers/api/user_info_mapper.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('UserRemoteDatasource');

abstract interface class UserRemoteDatasource implements Disposable {
  Future<UserInfo> getInfo();

  Future<void> delete();
}

class UserRemoteDatasourceApiImpl with UserInfoApiMapper implements UserRemoteDatasource {
  UserRemoteDatasourceApiImpl(this._webtritApiClient, this._token, {SessionGuard? sessionGuard})
    : _sessionGuard = sessionGuard ?? const EmptySessionGuard();

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<UserInfo> getInfo() async {
    try {
      final apiUserInfo = await _webtritApiClient.getUserInfo(_token);
      return userInfoFromApi(apiUserInfo);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('getInfo: unauthorized', e);
      rethrow;
    } on UserNotFoundException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('getInfo: user not found', e);
      rethrow;
    } on SessionMissingException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('getInfo: session missing', e);
      rethrow;
    }
  }

  @override
  Future<void> delete() async {
    try {
      await _webtritApiClient.deleteUserInfo(_token);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('delete: unauthorized', e);
      rethrow;
    } on UserNotFoundException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('delete: user not found', e);
      rethrow;
    } on SessionMissingException catch (e) {
      _sessionGuard.onUnauthorized(e);
      _logger.info('delete: session missing', e);
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {}
}
