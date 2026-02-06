import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SessionRepository');

abstract class SessionRepository {
  /// Returns the current in-memory session snapshot.
  Session? getCurrent();

  /// Persists a session.
  ///
  /// Updates in-memory state immediately, then writes to storage asynchronously.
  Future<void> save(Session session);

  /// Clears all local app/session data.
  ///
  /// Updates in-memory state immediately to prevent race conditions.
  Future<void> clean();

  /// Revokes the session on the server (API Call).
  /// This does NOT clear local data.
  Future<void> revokeSession(Session session);
}

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({required this.secureStorage, this.sessionCleanupWorker, required this.apiClientFactory}) {
    // Initialize in-memory cache immediately on startup.
    _currentSession = _loadFromStorage();
  }

  final SecureStorage secureStorage;
  final WebtritApiClientFactory apiClientFactory;
  final SessionCleanupWorker? sessionCleanupWorker;

  /// The single source of truth for the session state in memory.
  Session? _currentSession;

  /// Smart getter that attempts to restore the session from storage
  /// if the in-memory cache is empty (e.g. after a Hot Restart).
  Session get _effectiveSession {
    // Capture local reference to prevent race conditions and redundant field access
    final current = _currentSession;

    if (current != null && current.isLoggedIn) {
      return current;
    }

    final fromStorage = _loadFromStorage();

    if (fromStorage.isLoggedIn) {
      _logger.info('Restored lost session from storage: ${fromStorage.userId}');
      _currentSession = fromStorage;
      return fromStorage;
    }

    return current ?? const Session();
  }

  @override
  Session? getCurrent() => _effectiveSession;

  @override
  Future<void> save(Session session) async {
    if (_effectiveSession.isLoggedIn) {
      await clean();
    }

    _logger.info('Saving session for user: ${session.userId}');
    _currentSession = session;
    await secureStorage.writeUserId(session.userId);
    await secureStorage.writeTenantId(session.tenantId);
    if (session.coreUrl != null) await secureStorage.writeCoreUrl(session.coreUrl!);
    if (session.token != null) await secureStorage.writeToken(session.token!);
  }

  @override
  Future<void> clean() async {
    // Clear in-memory state immediately.
    _currentSession = const Session();

    // Clear storage asynchronously.
    await secureStorage.deleteCoreUrl();
    await secureStorage.deleteTenantId();
    await secureStorage.deleteToken();
    await secureStorage.deleteUserId();
  }

  @override
  Future<void> revokeSession(Session session) async {
    if (!session.isLoggedIn) return;

    final client = apiClientFactory.createWebtritApiClient(
      coreUrl: Uri.parse(session.coreUrl!),
      tenantId: session.tenantId,
    );

    try {
      await client.deleteSession(session.token!, options: RequestOptions.withExtraRetries());
    } on UserNotFoundException catch (e) {
      _logger.fine('Remote session already revoked (UserNotFound)', e);
    } on UnauthorizedException catch (e) {
      _logger.fine('Remote session already revoked (Unauthorized)', e);
    } on SessionMissingException catch (e) {
      _logger.fine('Remote session already revoked (SessionMissing)', e);
    } on RequestFailure catch (e, st) {
      if (e.statusCode == 401) {
        _logger.fine('Remote session already revoked (401)', e);
      } else {
        _logger.warning('Remote revoke failed, queuing retry', e, st);
        sessionCleanupWorker?.saveFailedSession(e.url, token: session.token!);
      }
    } catch (e, st) {
      _logger.severe('Unexpected error during remote revoke', e, st);
    }
  }

  Session _loadFromStorage() {
    return Session(
      coreUrl: secureStorage.readCoreUrl(),
      token: secureStorage.readToken(),
      tenantId: secureStorage.readTenantId() ?? '',
      userId: secureStorage.readUserId() ?? '',
    );
  }
}
