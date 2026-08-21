import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SessionRepository');

abstract class SessionRepository {
  /// Returns the current in-memory session snapshot. Before [whenRestored]
  /// completes this is an empty session, which is not the same as being signed
  /// out - ask [isRestored] when the difference matters.
  Session getCurrent();

  /// Whether the stored session has been read yet.
  bool get isRestored;

  /// Completes once the stored session has been read.
  Future<void> get whenRestored;

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

  /// Patches the current session with new values.
  /// Only non-null parameters will be updated; null parameters will be ignored.
  Future<void> patchSession({String? tenantId, String? token, String? coreUrl, String? userId});
}

class SessionRepositoryImpl implements SessionRepository, Disposable {
  /// Takes the session that was already read from storage, so every later
  /// reader is served from memory and nothing on a hot path has to wait for the
  /// keychain again. Read it with [readStoredSession], early enough to overlap
  /// with the rest of startup.
  SessionRepositoryImpl({
    required this.secureStorage,
    required this.apiClientFactory,
    required Future<Session> restoredSession,
    this.sessionCleanupWorker,
  }) {
    _restored = restoredSession.then((session) {
      // A session saved or cleared while the read was in flight is newer than
      // what the keychain held, so it wins.
      _currentSession ??= session;
      _isRestored = true;
    });
  }

  late final Future<void> _restored;
  var _isRestored = false;

  @override
  bool get isRestored => _isRestored;

  @override
  Future<void> get whenRestored => _restored;

  /// Reads the stored session. Asked for as a batch, so the whole session costs
  /// one round trip rather than one per record.
  static Future<Session> readStoredSession(SecureStorage secureStorage) async {
    final records = await Future.wait([
      secureStorage.readCoreUrl(),
      secureStorage.readToken(),
      secureStorage.readTenantId(),
      secureStorage.readUserId(),
    ]);

    return Session(coreUrl: records[0], token: records[1], tenantId: records[2] ?? '', userId: records[3] ?? '');
  }

  final SecureStorage secureStorage;
  final WebtritApiClientFactory apiClientFactory;
  final SessionCleanupWorker? sessionCleanupWorker;

  /// The single source of truth for the session state in memory.
  Session? _currentSession;

  Session get _effectiveSession => _currentSession ?? const Session();

  @override
  Session getCurrent() => _effectiveSession;

  @override
  Future<void> save(Session session) async {
    if (_effectiveSession.isLoggedIn) {
      await clean();
    }

    _logger.info('Saving session for user: ${session.userId}');
    _currentSession = session;

    await secureStorage.writeUserId(session.userId);
    await secureStorage.writeTenantId(session.tenantId);

    // Explicitly update or delete coreUrl based on new session data
    if (session.coreUrl != null) {
      await secureStorage.writeCoreUrl(session.coreUrl!);
    } else {
      await secureStorage.deleteCoreUrl();
    }

    // Explicitly update or delete token based on new session data
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

  @override
  Future<void> patchSession({String? tenantId, String? token, String? coreUrl, String? userId}) async {
    if (tenantId != null) {
      await secureStorage.writeTenantId(tenantId);
      _currentSession = _currentSession?.copyWith(tenantId: tenantId) ?? _currentSession;
      _logger.warning('tenantId patched: $tenantId');
    }

    if (token != null) {
      await secureStorage.writeToken(token);
      _currentSession = _currentSession?.copyWith(token: token) ?? _currentSession;
      _logger.warning('token patched: ${token.substring(0, 8)}...');
    }

    if (coreUrl != null) {
      await secureStorage.writeCoreUrl(coreUrl);
      _currentSession = _currentSession?.copyWith(coreUrl: coreUrl) ?? _currentSession;
      _logger.warning('coreUrl patched: $coreUrl');
    }

    if (userId != null) {
      await secureStorage.writeUserId(userId);
      _currentSession = _currentSession?.copyWith(userId: userId) ?? _currentSession;
      _logger.warning('userId patched: $userId');
    }
  }

  /// Releases the cleanup worker this repository was built with: it is nobody
  /// else's, and left alone it keeps retrying stored sessions on every network
  /// change.
  @override
  Future<void> dispose() async {
    await sessionCleanupWorker?.dispose();
  }
}
