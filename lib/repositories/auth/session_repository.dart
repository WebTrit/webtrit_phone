import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SessionRepository');

abstract class SessionRepository {
  bool get isSignedIn;

  /// Emits current session and all further updates.
  Stream<Session?> watch();

  /// Re-read session from storage and emit if changed.
  Future<void> reload();

  /// Persist a session (overwrites storage) and emit updated value.
  Future<void> save(Session session);

  /// Return current session snapshot from storage.
  Session? getCurrent();

  /// Logout user locally and revoke remote session asynchronously.
  Future<void> logout();

  /// Clear all local app/session data and emit updated value.
  Future<void> clean();
}

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({
    required this.secureStorage,
    required this.appPreferences,
    required this.appDatabase,
    this.sessionCleanupWorker,
    this.createApiClient = defaultCreateWebtritApiClient,
  }) {
    _currentSession = _loadFromStorage();
    _sessionController.add(_currentSession);
  }

  final SecureStorage secureStorage;
  final AppPreferences appPreferences;
  final AppDatabase appDatabase;
  final WebtritApiClientFactory createApiClient;
  final SessionCleanupWorker? sessionCleanupWorker;

  final _sessionController = StreamController<Session?>.broadcast();
  Session? _currentSession;

  @override
  Stream<Session?> watch() => _sessionController.stream;

  @override
  bool get isSignedIn => _currentSession?.isLoggedIn ?? false;

  @override
  Future<void> save(Session session) async {
    final isReLogin = _currentSession?.isLoggedIn ?? false;
    if (isReLogin) await logout();

    await secureStorage.writeUserId(session.userId);
    await secureStorage.writeTenantId(session.tenantId);

    if (session.coreUrl != null) {
      await secureStorage.writeCoreUrl(session.coreUrl!);
    } else {
      await secureStorage.deleteCoreUrl();
    }

    if (session.token != null) {
      await secureStorage.writeToken(session.token!);
    } else {
      await secureStorage.deleteToken();
    }

    _updateCurrent(_loadFromStorage());
  }

  @override
  Session? getCurrent() => _currentSession;

  Session _loadFromStorage() {
    return Session(
      coreUrl: secureStorage.readCoreUrl(),
      token: secureStorage.readToken(),
      tenantId: secureStorage.readTenantId() ?? '',
      userId: secureStorage.readUserId() ?? '',
    );
  }

  void _updateCurrent(Session newSession) {
    _currentSession = newSession;
    _sessionController.add(_currentSession);
  }

  @override
  Future<void> clean() async {
    await appPreferences.clear();
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
    await secureStorage.deleteUserId();
    await appDatabase.deleteEverything();

    _updateCurrent(_loadFromStorage());
  }

  @override
  Future<void> logout() async {
    final session = _currentSession;
    if (session == null || !session.isLoggedIn) return;

    await clean();

    unawaited(_revokeRemoteWithLogging(session));
  }

  Future<void> _revokeRemoteWithLogging(Session session) async {
    try {
      await _revokeRemote(session);
    } catch (e, st) {
      _logger.severe('Uncaught error during remote revoke', e, st);
    }
  }

  Future<void> _revokeRemote(Session s) async {
    final coreUrl = s.coreUrl;
    final token = s.token;
    if (coreUrl == null || token == null) return;

    final client = createApiClient(coreUrl, s.tenantId);
    try {
      await client.deleteSession(token, options: RequestOptions.withExtraRetries());
    } on UserNotFoundException catch (e, st) {
      _logger.fine('Remote session already revoked or never existed', e, st);
    } on UnauthorizedException catch (e, st) {
      _logger.fine('Remote session already revoked or never existed', e, st);
    } on RequestFailure catch (e, st) {
      sessionCleanupWorker?.saveFailedSession(e.url, token: token);
      _logger.warning('Queued token revoke retry', e, st);
      rethrow;
    } catch (e, st) {
      _logger.severe('Unexpected error during remote revoke', e, st);
    }
  }

  @override
  Future<void> reload() async {
    _updateCurrent(_loadFromStorage());
  }

  Future<void> dispose() async {
    await _sessionController.close();
  }
}
