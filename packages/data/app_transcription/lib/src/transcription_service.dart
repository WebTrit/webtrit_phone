import 'dart:async';
import 'dart:typed_data';

import 'package:logging/logging.dart';

import 'transcription_datasource.dart';
import 'transcription_store.dart';

final _logger = Logger('TranscriptionService');

/// Produces the audio bytes of a media object when its turn in the pool
/// comes; lazy so queued items do not hold their payloads in memory.
typedef TranscriptionAudioLoader = Future<Uint8List> Function();

/// Builds a transcription source for the given local model tier override
/// (null keeps the configured default); returns null when the feature is
/// disabled or misconfigured.
typedef TranscriptionDataSourceBuilder = TranscriptionDataSource? Function(String? localModelOverride);

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

  /// Switches the local model (null returns to the config default) and
  /// regenerates everything already transcribed; see
  /// [TranscriptionService.switchLocalModel].
  Future<void> switchLocalModel(String? localModel);
}

/// Fire-and-forget transcription pool.
///
/// Consumers enqueue media they want transcribed and walk away: the pool
/// transcribes sequentially through the source it owns (built by the injected
/// [TranscriptionDataSourceBuilder]) and hands every lifecycle fact
/// (in progress, transcript, failure) to the [TranscriptionStore] the
/// application wired in - the pool itself knows nothing about storage.
/// Results are attributed to the engine that actually produced them, and
/// store calls are invalidated when the item was forgotten or the model
/// switched mid-flight, so a stale result can never resurrect a removed or
/// regenerating item. A user model change ([switchLocalModel]) swaps the
/// engine for every consumer at once.
class TranscriptionService implements MediaTranscriber {
  /// Builds the initial source for [initialLocalModel] and rebuilds it on
  /// every [switchLocalModel] call.
  TranscriptionService(
    TranscriptionDataSourceBuilder builder, {
    String? initialLocalModel,
    required TranscriptionStore store,
  }) : _builder = builder,
       _store = store,
       _current = builder(initialLocalModel);

  /// A pool over a fixed source that cannot switch models.
  TranscriptionService.fixed(TranscriptionDataSource? source, {required TranscriptionStore store})
    : _builder = null,
      _store = store,
      _current = source;

  final TranscriptionDataSourceBuilder? _builder;
  final TranscriptionStore _store;

  /// The source transcribing right now; null while transcription is disabled.
  TranscriptionDataSource? _current;

  final _requests = <_TranscriptionRequest>[];

  /// The queued or in-flight request per media key. An entry removed or
  /// replaced mid-work (forget, model switch, re-enqueue) invalidates the
  /// pending store calls of the request that no longer owns its key.
  final _active = <String, _TranscriptionRequest>{};

  bool _draining = false;
  int _generation = 0;
  bool _disposed = false;

  /// False while transcription is disabled or unsupported on this platform.
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
    unawaited(_drain());
  }

  /// The media was deleted: drops it from the pool, invalidates an in-flight
  /// result and removes its stored transcription through the store.
  @override
  Future<void> forget(String mediaType, String mediaId) async {
    final key = _mediaKey(mediaType, mediaId);
    _requests.removeWhere((request) => request.key == key);
    _active.remove(key);
    if (_disposed) return;
    await _store.remove(mediaType, mediaId);
  }

  /// Every media object of [mediaType] was deleted: drops them from the pool
  /// in one pass and removes their stored transcriptions.
  @override
  Future<void> forgetAllForType(String mediaType) async {
    _requests.removeWhere((request) => request.mediaType == mediaType);
    _active.removeWhere((_, request) => request.mediaType == mediaType);
    if (_disposed) return;
    await _store.removeAllForType(mediaType);
  }

  /// Switches the local model (null returns to the config default) and
  /// regenerates everything: the store removes every transcription, the
  /// source is rebuilt and in-flight results of the old model are
  /// invalidated. Consumers observe the wipe through their storage and
  /// re-enqueue what they want regenerated.
  ///
  /// No-op when the replacement engine is identical to the active one (a
  /// [TranscriptionService.fixed] pool, the same tier picked again, or a
  /// remote source that ignores the local tier) - nothing is wiped then.
  /// Throws when the wipe fails; the engine is not swapped in that case, so
  /// the stored transcripts stay consistent with the engine that made them.
  @override
  Future<void> switchLocalModel(String? localModel) async {
    if (_disposed) return;
    final builder = _builder;
    if (builder == null) return;

    // Build the replacement first: if it comes out byte-identical there is
    // nothing to regenerate and the stored transcripts must survive.
    final replacement = builder(localModel);
    if (replacement?.engine == _current?.engine) {
      replacement?.dispose();
      return;
    }

    // Invalidate before wiping: an item may still be transcribing on the
    // previous engine and its result must not land.
    _generation++;
    _requests.clear();
    _active.clear();

    try {
      await _store.removeAll();
    } catch (e, st) {
      _logger.warning('Failed to wipe transcriptions for regeneration; keeping the current engine', e, st);
      replacement?.dispose();
      rethrow;
    }

    final previous = _current;
    _current = replacement;
    previous?.dispose();
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

      // Re-check between the expensive steps: a forget or model switch that
      // landed meanwhile makes the download and the inference dead work that
      // would only delay the queue behind it.
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

  /// True when the world changed while the work ran: a model switch or a
  /// forget must not be overwritten by a stale result.
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
