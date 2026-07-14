import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

import 'package:app_database/app_database.dart';
import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/models/models.dart';

import 'switchable_transcription_source.dart';

final _logger = Logger('TranscriptionService');

/// Produces the audio bytes of a media object when its turn in the pool
/// comes; lazy so queued items do not hold their payloads in memory.
typedef TranscriptionAudioLoader = Future<Uint8List> Function();

sealed class TranscriptionServiceEvent {}

/// Every stored transcription was wiped (e.g. the model changed); consumers
/// should re-enqueue the media they want transcribed.
class TranscriptionsWiped extends TranscriptionServiceEvent {}

/// Session-wide fire-and-forget transcription pool.
///
/// Consumers enqueue media they want transcribed and walk away: the service
/// transcribes sequentially through the shared [SwitchableTranscriptionSource]
/// and writes the lifecycle (inProgress -> done/unavailable, transient
/// rollbacks) into the transcriptions table, which consumers observe through
/// their own queries. Results are attributed to the engine that actually
/// produced them, and writes are generation-guarded so a model switch or a
/// deleted media item can never be resurrected by an in-flight transcription.
class TranscriptionService {
  TranscriptionService({
    required AppDatabase appDatabase,
    required SwitchableTranscriptionSource source,
    SessionGuard sessionGuard = const EmptySessionGuard(),
  }) : _appDatabase = appDatabase,
       _source = source,
       _sessionGuard = sessionGuard {
    unawaited(_resetStaleInProgress());
  }

  final AppDatabase _appDatabase;
  final SwitchableTranscriptionSource _source;
  final SessionGuard _sessionGuard;

  final _events = StreamController<TranscriptionServiceEvent>.broadcast();
  final _requests = <_TranscriptionRequest>[];

  /// The queued or in-flight request per media key. An entry removed or
  /// replaced mid-work (forget, model switch, re-enqueue) invalidates the
  /// pending write of the request that no longer owns its key.
  final _active = <String, _TranscriptionRequest>{};

  bool _draining = false;
  int _generation = 0;
  bool _disposed = false;

  Stream<TranscriptionServiceEvent> get events => _events.stream;

  /// False while transcription is disabled or unsupported on this platform.
  bool get isEnabled => _source.current != null;

  /// Queues the media for transcription; duplicates of an already queued or
  /// in-flight item and calls while the feature is disabled are no-ops.
  /// Media already holding a transcript (or marked unavailable) is skipped
  /// when its turn comes.
  void enqueue(String mediaType, String mediaId, TranscriptionAudioLoader loadAudio, {String? language}) {
    if (_disposed || !isEnabled) return;
    final key = _mediaKey(mediaType, mediaId);
    if (_active.containsKey(key)) return;

    final request = _TranscriptionRequest(mediaType, mediaId, loadAudio, language);
    _active[key] = request;
    _requests.add(request);
    unawaited(_drain());
  }

  /// The media was deleted: drops it from the pool, invalidates an in-flight
  /// result and removes its stored transcription.
  Future<void> forget(String mediaType, String mediaId) async {
    final key = _mediaKey(mediaType, mediaId);
    _requests.removeWhere((request) => request.key == key);
    _active.remove(key);
    await _appDatabase.transcriptionsDao.deleteByMedia(mediaType, mediaId);
  }

  /// Drops every queued item and stored transcription of [mediaType].
  Future<void> forgetAllForType(String mediaType) async {
    _requests.removeWhere((request) => request.mediaType == mediaType);
    _active.removeWhere((_, request) => request.mediaType == mediaType);
    await _appDatabase.transcriptionsDao.deleteAllForType(mediaType);
  }

  /// Switches the local model (null returns to the config default) and
  /// regenerates everything: stored transcriptions are wiped, in-flight
  /// results of the old model are invalidated, and [TranscriptionsWiped]
  /// tells consumers to re-enqueue their media.
  void switchLocalModel(String? localModel) {
    if (!_source.switchLocalModel(localModel)) return;

    _generation++;
    _requests.clear();
    _active.clear();
    unawaited(_wipeAndNotify());
  }

  Future<void> _wipeAndNotify() async {
    try {
      await _appDatabase.transcriptionsDao.deleteAll();
    } catch (e, st) {
      _logger.warning('Failed to wipe transcriptions for regeneration', e, st);
    }
    if (!_disposed) _events.add(TranscriptionsWiped());
  }

  /// Rows stuck in inProgress belong to a run that never finished (killed
  /// app, previous session); nothing is in flight when the service starts,
  /// so reset them to "not attempted".
  Future<void> _resetStaleInProgress() async {
    try {
      await _appDatabase.transcriptionsDao.clearStatuses(TranscriptStatus.inProgress.name);
    } catch (e, st) {
      _logger.warning('Failed to reset stale in-progress transcriptions', e, st);
    }
  }

  Future<void> _drain() async {
    if (_draining) return;
    _draining = true;
    try {
      while (_requests.isNotEmpty && !_disposed) {
        final request = _requests.removeAt(0);
        await _process(request);
        // Only release the key if this request still owns it: a forget or
        // model switch may have replaced it with a re-enqueued successor.
        if (identical(_active[request.key], request)) _active.remove(request.key);
      }
    } finally {
      _draining = false;
    }
  }

  Future<void> _process(_TranscriptionRequest request) async {
    final generation = _generation;
    final source = _source.current;
    if (source == null || !identical(_active[request.key], request)) return;

    try {
      final existing = await _appDatabase.transcriptionsDao.getByMedia(request.mediaType, request.mediaId);
      if (existing?.transcript != null || existing?.status == TranscriptStatus.unavailable.name) return;

      await _write(request, generation, status: TranscriptStatus.inProgress, engine: source.engine);
      final audio = await request.loadAudio();
      final transcript = await source.transcribe(audio, language: request.language);
      await _write(request, generation, transcript: transcript, status: TranscriptStatus.done, engine: source.engine);
    } on UnauthorizedException catch (e) {
      // The session is gone: roll the item back, drop the rest of the pool
      // (every following load would fail the same way) and let the guard
      // drive the logout.
      await _tryWrite(request, generation, engine: source.engine);
      _requests.clear();
      _active.clear();
      _sessionGuard.onUnauthorized(e);
    } catch (e, st) {
      final transient = _isTransientFailure(e);
      _logger.warning('Failed to transcribe ${request.key} (transient: $transient)', e, st);
      await _tryWrite(
        request,
        generation,
        status: transient ? null : TranscriptStatus.unavailable,
        engine: source.engine,
      );
    }
  }

  /// Persists the item's state unless the world changed while the work ran:
  /// a model switch or a forget must not be overwritten by a stale result.
  Future<void> _write(
    _TranscriptionRequest request,
    int generation, {
    String? transcript,
    TranscriptStatus? status,
    String? engine,
  }) async {
    if (_disposed || generation != _generation || !identical(_active[request.key], request)) return;

    await _appDatabase.transcriptionsDao.upsertTranscription(
      TranscriptionData(
        mediaType: request.mediaType,
        mediaId: request.mediaId,
        transcript: transcript,
        status: status?.name,
        engine: engine,
      ),
    );
  }

  Future<void> _tryWrite(
    _TranscriptionRequest request,
    int generation, {
    String? transcript,
    TranscriptStatus? status,
    String? engine,
  }) async {
    try {
      await _write(request, generation, transcript: transcript, status: status, engine: engine);
    } catch (e) {
      _logger.warning('Failed to store transcription state for ${request.key}', e);
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

  static String _mediaKey(String mediaType, String mediaId) => '$mediaType/$mediaId';

  Future<void> dispose() async {
    _disposed = true;
    _generation++;
    _requests.clear();
    _active.clear();
    await _events.close();
  }
}

class _TranscriptionRequest {
  _TranscriptionRequest(this.mediaType, this.mediaId, this.loadAudio, this.language);

  final String mediaType;
  final String mediaId;
  final TranscriptionAudioLoader loadAudio;
  final String? language;

  String get key => TranscriptionService._mediaKey(mediaType, mediaId);
}
