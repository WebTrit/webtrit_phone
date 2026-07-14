import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show ValueListenable, ValueNotifier;
import 'package:logging/logging.dart';

import 'model_download_state.dart';
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
/// transcribes through the source it owns (built by the injected
/// [TranscriptionDataSourceBuilder]), processing up to `concurrency` items
/// at once (strictly sequential by default), and hands every lifecycle fact
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
  ///
  /// [concurrency] caps how many items are processed at once. The default of
  /// 1 (strictly sequential) suits a compute-bound local engine, where
  /// parallel inference only multiplies memory; a network-bound remote
  /// engine benefits from a few concurrent requests.
  TranscriptionService(
    TranscriptionDataSourceBuilder builder, {
    String? initialLocalModel,
    required TranscriptionStore store,
    int concurrency = 1,
  }) : assert(concurrency >= 1),
       _builder = builder,
       _store = store,
       _concurrency = concurrency,
       _current = builder(initialLocalModel) {
    _observeSource(_current);
  }

  /// A pool over a fixed source that cannot switch models.
  TranscriptionService.fixed(TranscriptionDataSource? source, {required TranscriptionStore store, int concurrency = 1})
    : assert(concurrency >= 1),
      _builder = null,
      _store = store,
      _concurrency = concurrency,
      _current = source {
    _observeSource(_current);
  }

  final TranscriptionDataSourceBuilder? _builder;
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

  /// True while [switchLocalModel] is between invalidating the old engine
  /// and swapping the new one in; enqueues are dropped in that window (the
  /// consumer's missing-row watch re-feeds them right after the wipe), so a
  /// fresh item can never be transcribed by the outgoing engine.
  bool _switching = false;

  /// False while transcription is disabled or unsupported on this platform.
  bool get isEnabled => _current != null;

  final _modelDownloadState = ValueNotifier<ModelDownloadState>(const ModelDownloadIdle());
  TranscriptionDataSource? _observedSource;

  /// Engine-asset readiness of the active source, stable across model
  /// switches (the source's own notifier dies with the source).
  ValueListenable<ModelDownloadState> get modelDownloadState => _modelDownloadState;

  /// Fetches the active engine's assets ahead of the first transcription
  /// (e.g. starts the model download right after the user picked a tier);
  /// progress is observable through [modelDownloadState].
  Future<void> prepareEngine() => _current?.prepareEngine() ?? Future.value();

  void _observeSource(TranscriptionDataSource? source) {
    _observedSource?.downloadState.removeListener(_onSourceDownloadState);
    _observedSource = source;
    source?.downloadState.addListener(_onSourceDownloadState);
    _modelDownloadState.value = source?.downloadState.value ?? const ModelDownloadIdle();
  }

  void _onSourceDownloadState() {
    final source = _observedSource;
    if (source != null) _modelDownloadState.value = source.downloadState.value;
  }

  /// Queues the media for transcription; duplicates of an already queued or
  /// in-flight item and calls while the feature is disabled or a model
  /// switch is in progress are no-ops.
  @override
  void enqueue(String mediaType, String mediaId, TranscriptionAudioLoader loadAudio, {String? language}) {
    if (_disposed || _switching || !isEnabled) return;
    final key = _mediaKey(mediaType, mediaId);
    if (_active.containsKey(key)) return;

    final request = _TranscriptionRequest(mediaType, mediaId, loadAudio, language);
    _active[key] = request;
    _requests.add(request);
    // Mark the item in progress right away: after a model-switch wipe the
    // rows of everything still waiting in the queue would otherwise stay
    // absent until a worker picks the item up, and the UI would show neither
    // a transcript nor a status for most of the backlog.
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
    // Throw rather than no-op: a silent return would let the caller persist
    // an override that was never applied.
    if (_disposed) throw StateError('switchLocalModel called on a disposed TranscriptionService');
    final builder = _builder;
    if (builder == null) return;

    // Build the replacement first: if it comes out byte-identical there is
    // nothing to regenerate and the stored transcripts must survive.
    final replacement = builder(localModel);
    if (replacement?.engine == _current?.engine) {
      replacement?.dispose();
      return;
    }

    _switching = true;
    try {
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
      // Re-point the download-state mirror before the old source (and its
      // notifier) is disposed.
      _observeSource(replacement);
      previous?.dispose();
    } finally {
      _switching = false;
    }
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
    _observeSource(null);
    _current?.dispose();
    _current = null;
    _modelDownloadState.dispose();
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
