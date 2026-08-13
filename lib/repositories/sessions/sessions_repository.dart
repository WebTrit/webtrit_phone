import 'package:webtrit_api/webtrit_api.dart' show WebtritApiClient, UnauthorizedException;

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract interface class SessionsRepository {
  /// Fetches the account's active sessions, the current one included.
  Future<List<ActiveSession>> getSessions();

  /// Revokes the session with [sessionId], ending its SIP registration.
  Future<void> revokeSession(String sessionId);
}

class SessionsRepositoryApiImpl with ActiveSessionApiMapper implements SessionsRepository {
  SessionsRepositoryApiImpl(this._webtritApiClient, this._token, this._sessionGuard);

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<List<ActiveSession>> getSessions() async {
    try {
      final sessions = await _webtritApiClient.getUserSessions(_token);
      return sessions.map(activeSessionFromApi).toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }

  @override
  Future<void> revokeSession(String sessionId) async {
    try {
      await _webtritApiClient.deleteUserSession(_token, sessionId);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }
}
