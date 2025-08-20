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
    _sessionController.add(getCurrent());
  }

  final SecureStorage secureStorage;
  final AppPreferences appPreferences;
  final AppDatabase appDatabase;
  final WebtritApiClientFactory createApiClient;
  final SessionCleanupWorker? sessionCleanupWorker;

  final _sessionController = StreamController<Session?>.broadcast();

  @override
  Stream<Session?> watch() => _sessionController.stream;

  @override
  bool get isSignedIn => getCurrent().isLoggedIn;

  @override
  Future<void> save(Session session) async {
    final currentSession = getCurrent();

    final isReLogin = currentSession.isLoggedIn;
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

    _sessionController.add(getCurrent());
  }

  @override
  Session getCurrent() {
    final coreUrl = secureStorage.readCoreUrl();
    final tenantId = secureStorage.readTenantId() ?? '';
    final token = secureStorage.readToken();
    final userId = secureStorage.readUserId() ?? '';

    return Session(
      coreUrl: coreUrl,
      token: token,
      tenantId: tenantId,
      userId: userId,
    );
  }

  @override
  Future<void> clean() async {
    await appPreferences.clear();
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
    await secureStorage.deleteUserId();
    await appDatabase.deleteEverything();

    _sessionController.add(getCurrent());
  }

  @override
  Future<void> logout() async {
    final session = getCurrent();
    if (!session.isLoggedIn) return;

    // Clear local state first to immediately notify routing/UI about logout.
    await clean();

    // Revoke remote session in background (do not block UX).
    unawaited(_revokeRemote(session));
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
      return;
    } on UnauthorizedException catch (e, st) {
      _logger.fine('Remote session already revoked or never existed', e, st);
      return;
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
    _sessionController.add(getCurrent());
  }

  Future<void> dispose() async {
    await _sessionController.close();
  }
}
