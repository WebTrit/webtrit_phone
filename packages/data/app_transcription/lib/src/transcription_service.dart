import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

import 'transcription_datasource.dart';
import 'transcription_store.dart';

final _logger = Logger('TranscriptionService');

/// Produces the audio bytes of a media object when its turn in the pool
/// comes; lazy so queued items do not hold their payloads in memory.
typedef TranscriptionAudioLoader = Future<Uint8List> Function();

/// The narrow consumer-facing contract of the transcription pool: hand media
/// off and forget deleted items. Nothing is ever returned or awaited by
/// consumers - results and lifecycle states land in the application's
/// [TranscriptionStore], observed through the consumer's own storage
/// queries. Consumers depend on this instead of [TranscriptionService]
/// itself.
abstract interface class MediaTranscriber {
  /// Fire-and-forget request to transcribe a media object.
  void enqueue(String mediaType, String mediaId, TranscriptionAudioLoader loadAudio, {String? language});

  /// The media object was deleted: pending or in-flight work is invalidated
  /// and the stored transcription removed, so a late result cannot resurrect
  /// it.
  Future<void> forget(String mediaType, String mediaId);

  /// [forget] for every media object of [mediaType] in one pass.
  Future<void> forgetAllForType(String mediaType);
}

/// Fire-and-forget transcription pool.
///
/// Consumers enqueue media they want transcribed and walk away: the pool
/// transcribes through the source it owns, processing up to `concurrency`
/// items at once, and hands every lifecycle fact (in progress, transcript,
/// failure) to the [TranscriptionStore] the application wired in - the pool
/// itself knows nothing about storage. Results are attributed to the engine
/// that actually produced them, and store calls are invalidated when the item
/// was forgotten mid-flight, so a stale result can never resurrect a removed
/// item.
class TranscriptionService implements MediaTranscriber {
  /// [concurrency] caps how many items are processed at once; a
  /// network-bound source benefits from a few concurrent requests.
  TranscriptionService(TranscriptionDataSource? source, {required TranscriptionStore store, int concurrency = 1})
    : assert(concurrency >= 1),
      _store = store,
      _concurrency = concurrency,
      _current = source;

  final TranscriptionStore _store;
  final int _concurrency;

  /// The source transcribing right now; null while transcription is disabled.
  TranscriptionDataSource? _current;

  final _requests = <_TranscriptionRequest>[];

  /// The queued or in-flight request per media key. An entry removed or
  /// replaced mid-work (forget, model switch, re-enqueue) invalidates the
  /// pending store calls of the request that no longer owns its key.
  final _active = <String, _TranscriptionRequest>{};

  int _workers = 0;
  int _generation = 0;
  bool _disposed = false;

  /// False while transcription is disabled or misconfigured.
  bool get isEnabled => _current != null;

  /// Queues the media for transcription; duplicates of an already queued or
  /// in-flight item and calls while the feature is disabled are no-ops.
  @override
  void enqueue(String mediaType, String mediaId, TranscriptionAudioLoader loadAudio, {String? language}) {
    if (_disposed || !isEnabled) return;
    final key = _mediaKey(mediaType, mediaId);
    if (_active.containsKey(key)) return;

    final request = _TranscriptionRequest(mediaType, mediaId, loadAudio, language);
    _active[key] = request;
    _requests.add(request);
    // Mark the item in progress right away: the rows of everything still
    // waiting in the queue would otherwise stay absent until a worker picks
    // the item up, and the UI would show neither a transcript nor a status
    // for most of the backlog.
    unawaited(_markQueued(request, _generation, _current!.engine));
    _kickWorkers();
  }

  Future<void> _markQueued(_TranscriptionRequest request, int generation, String engine) async {
    try {
      await _saveGuardedProceed(
        request,
        generation,
        () => _store.saveInProgress(request.mediaType, request.mediaId, engine),
      );
    } catch (e) {
      _logger.warning('Failed to mark ${request.key} as queued', e);
    }
  }

  /// The media was deleted: drops it from the pool, invalidates an in-flight
  /// result and removes its stored transcription through the store.
  @override
  Future<void> forget(String mediaType, String mediaId) async {
    final key = _mediaKey(mediaType, mediaId);
    _requests.removeWhere((request) => request.key == key);
    _active.remove(key);
    // The store outlives the pool (app-scoped storage), so the row removal
    // must happen even when the deletion races session teardown.
    await _store.remove(mediaType, mediaId);
  }

  /// Every media object of [mediaType] was deleted: drops them from the pool
  /// in one pass and removes their stored transcriptions.
  @override
  Future<void> forgetAllForType(String mediaType) async {
    _requests.removeWhere((request) => request.mediaType == mediaType);
    _active.removeWhere((_, request) => request.mediaType == mediaType);
    await _store.removeAllForType(mediaType);
  }

  /// Tops the worker count up to [_concurrency], never spawning more than
  /// the queue can feed; each worker drains until the queue is empty.
  void _kickWorkers() {
    var spawn = _concurrency - _workers;
    if (spawn > _requests.length) spawn = _requests.length;
    while (spawn-- > 0) {
      _workers++;
      unawaited(_drainWorker());
    }
  }

  Future<void> _drainWorker() async {
    try {
      while (_requests.isNotEmpty && !_disposed) {
        final request = _requests.removeAt(0);
        await _process(request);
        // Only release the key if this request still owns it: a forget or
        // model switch may have replaced it with a re-enqueued successor.
        if (identical(_active[request.key], request)) _active.remove(request.key);
      }
    } finally {
      _workers--;
    }
  }

  Future<void> _process(_TranscriptionRequest request) async {
    final generation = _generation;
    final source = _current;
    if (source == null || _isStale(request, generation)) return;

    final String transcript;
    try {
      // The store may already hold a result for this media (a re-enqueue that
      // raced its own completion); skip the expensive work then.
      final proceed = await _saveGuardedProceed(
        request,
        generation,
        () => _store.saveInProgress(request.mediaType, request.mediaId, source.engine),
      );
      if (!proceed) return;

      // Re-check between the expensive steps: a forget that landed meanwhile
      // makes the download and the inference dead work that would only delay
      // the queue behind it.
      if (_isStale(request, generation)) return;
      final audio = await request.loadAudio();
      if (_isStale(request, generation)) return;
      transcript = await source.transcribe(audio, language: request.language);
    } catch (e, st) {
      _logger.warning('Failed to transcribe ${request.key}', e, st);
      final keepGoing = await _saveFailureGuarded(request, generation, e, source.engine);
      if (!keepGoing) {
        _requests.clear();
        _active.clear();
      }
      return;
    }

    // A failure to persist a successfully produced transcript is NOT a
    // transcription failure: the row stays inProgress and is retried by the
    // consumer's next pending pass instead of being classified terminal.
    try {
      await _saveGuarded(
        request,
        generation,
        () => _store.saveTranscript(request.mediaType, request.mediaId, transcript, source.engine),
      );
    } catch (e) {
      _logger.warning('Failed to store the transcript of ${request.key}', e);
    }
  }

  /// True when the world changed while the work ran: a forget must not be
  /// overwritten by a stale result.
  bool _isStale(_TranscriptionRequest request, int generation) {
    return _disposed || generation != _generation || !identical(_active[request.key], request);
  }

  Future<void> _saveGuarded(_TranscriptionRequest request, int generation, Future<void> Function() save) async {
    if (_isStale(request, generation)) return;
    await save();
  }

  Future<bool> _saveGuardedProceed(_TranscriptionRequest request, int generation, Future<bool> Function() save) async {
    if (_isStale(request, generation)) return false;
    return save();
  }

  Future<bool> _saveFailureGuarded(_TranscriptionRequest request, int generation, Object error, String engine) async {
    if (_isStale(request, generation)) return true;
    try {
      return await _store.saveFailure(request.mediaType, request.mediaId, error, engine);
    } catch (e) {
      _logger.warning('Failed to store transcription failure for ${request.key}', e);
      return true;
    }
  }

  static String _mediaKey(String mediaType, String mediaId) => '$mediaType/$mediaId';

  void dispose() {
    _disposed = true;
    _generation++;
    _requests.clear();
    _active.clear();
    _current?.dispose();
    _current = null;
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
