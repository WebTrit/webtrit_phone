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

  /// Logout user locally (clears data) and revokes remote session asynchronously.
  Future<void> logout();

  /// Clears all local app/session data.
  ///
  /// Updates in-memory state immediately to prevent race conditions.
  Future<void> clean();
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
    final isReLogin = _effectiveSession.isLoggedIn;

    // If a user is re-logging in, ensure the old session is cleaned up first.
    // Note: logout() cleans memory, but we immediately overwrite it below.
    if (isReLogin) {
      await logout();
    }

    _logger.info('Saving session for user: ${session.userId}');

    // Update in-memory state immediately (Memory First strategy).
    _currentSession = session;

    // Persist to storage asynchronously.
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
  Future<void> logout() async {
    // Capture the session before cleaning for the remote revoke call.
    // Uses _effectiveSession to ensure we have the token even if memory was cleared.
    final sessionToRevoke = _effectiveSession;

    // Clear local data (memory + disk).
    await clean();

    // Fire-and-forget remote revocation.
    if (sessionToRevoke.isLoggedIn) {
      unawaited(_revokeRemoteWithLogging(sessionToRevoke));
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

    final client = apiClientFactory.createWebtritApiClient(coreUrl: Uri.parse(coreUrl), tenantId: s.tenantId);

    try {
      await client.deleteSession(token, options: RequestOptions.withExtraRetries());
    } on UserNotFoundException catch (e, st) {
      _logger.fine('Remote session already revoked or never existed (UserNotFound)', e, st);
    } on UnauthorizedException catch (e, st) {
      _logger.fine('Remote session already revoked or never existed (Unauthorized)', e, st);
    } on SessionMissingException catch (e, st) {
      _logger.fine('Remote session already revoked (SessionMissing)', e, st);
    } on RequestFailure catch (e, st) {
      // If it's a network issue or server error (5xx), queue it for later.
      _logger.warning('Queued token revoke retry due to RequestFailure', e, st);
      sessionCleanupWorker?.saveFailedSession(e.url, token: token);
      rethrow;
    } catch (e, st) {
      _logger.severe('Unexpected error during remote revoke', e, st);
    }
  }
}
