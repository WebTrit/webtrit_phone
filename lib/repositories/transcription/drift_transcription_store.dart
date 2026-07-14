import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';
import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('DriftTranscriptionStore');

/// [TranscriptionStore] over the drift transcriptions table - the only place
/// where transcription pool results meet the database. Consumers watch that
/// table (e.g. through their list joins) and never talk to the pool about
/// results.
class DriftTranscriptionStore implements TranscriptionStore {
  DriftTranscriptionStore({required AppDatabase appDatabase, SessionGuard sessionGuard = const EmptySessionGuard()})
    : _appDatabase = appDatabase,
      _sessionGuard = sessionGuard;

  final AppDatabase _appDatabase;
  final SessionGuard _sessionGuard;

  /// Rows stuck in inProgress belong to a run that never finished (killed
  /// app, previous session); nothing is in flight when the store is wired,
  /// so reset them to "not attempted".
  Future<void> resetStaleInProgress() async {
    try {
      await _appDatabase.transcriptionsDao.clearStatuses(TranscriptStatus.inProgress.name);
    } catch (e, st) {
      _logger.warning('Failed to reset stale in-progress transcriptions', e, st);
    }
  }

  @override
  Future<bool> saveInProgress(String mediaType, String mediaId, String engine) async {
    // A re-enqueue may race its own completion: never overwrite a finished
    // transcript (or a terminal failure) with an in-progress state.
    final existing = await _appDatabase.transcriptionsDao.getByMedia(mediaType, mediaId);
    if (existing?.transcript != null || existing?.status == TranscriptStatus.unavailable.name) return false;

    await _upsert(mediaType, mediaId, status: TranscriptStatus.inProgress, engine: engine);
    return true;
  }

  @override
  Future<void> saveTranscript(String mediaType, String mediaId, String transcript, String engine) {
    return _upsert(mediaType, mediaId, transcript: transcript, status: TranscriptStatus.done, engine: engine);
  }

  @override
  Future<bool> saveFailure(String mediaType, String mediaId, Object error, String engine) async {
    if (error is UnauthorizedException) {
      // The session is gone: roll the item back so the next session retries
      // it, stop the pool (every following audio load would fail the same
      // way) and let the guard drive the logout.
      await _tryUpsert(mediaType, mediaId, engine: engine);
      _sessionGuard.onUnauthorized(error);
      return false;
    }

    // A transient failure rolls back to "not attempted" so a later sweep
    // retries the media; only failures that cannot succeed later are
    // terminal.
    final transient = _isTransientFailure(error);
    await _tryUpsert(mediaType, mediaId, status: transient ? null : TranscriptStatus.unavailable, engine: engine);
    return true;
  }

  @override
  Future<void> remove(String mediaType, String mediaId) async {
    await _appDatabase.transcriptionsDao.deleteByMedia(mediaType, mediaId);
  }

  @override
  Future<void> removeAllForType(String mediaType) async {
    await _appDatabase.transcriptionsDao.deleteAllForType(mediaType);
  }

  @override
  Future<void> removeAll() async {
    await _appDatabase.transcriptionsDao.deleteAll();
  }

  Future<void> _upsert(
    String mediaType,
    String mediaId, {
    String? transcript,
    TranscriptStatus? status,
    String? engine,
  }) {
    return _appDatabase.transcriptionsDao.upsertTranscription(
      TranscriptionData(
        mediaType: mediaType,
        mediaId: mediaId,
        transcript: transcript,
        status: status?.name,
        engine: engine,
      ),
    );
  }

  Future<void> _tryUpsert(String mediaType, String mediaId, {TranscriptStatus? status, String? engine}) async {
    try {
      await _upsert(mediaType, mediaId, status: status, engine: engine);
    } catch (e) {
      _logger.warning('Failed to store transcription state for $mediaType/$mediaId', e);
    }
  }

  static bool _isTransientFailure(Object error) {
    if (error is TranscriptionException) return error.transient;
    // Audio download failures: retry on transport errors (no status), HTTP
    // retry semantics and server errors; other 4xx are terminal.
    if (error is RequestFailure) return error.statusCode == null || error.isTransient || error.isServerError;
    // Unknown runtime errors: fail open toward retry, it is bounded anyway.
    return true;
  }
}
