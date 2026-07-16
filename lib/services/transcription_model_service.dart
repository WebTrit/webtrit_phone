import 'dart:async';

import 'package:flutter/foundation.dart' show ValueListenable, kIsWeb;

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('TranscriptionModelService');

/// Session-wide owner of the transcription model choice, shared by every
/// transcription consumer (the settings page is the only writer today).
///
/// A change persists the override first and then switches the pool; when the
/// switch fails (it throws, including on a disposed pool) the persisted
/// override is reverted best-effort, so the disk can never claim a tier the
/// running pool refused while the pool itself stays on the old engine.
/// Changes are serialized so rapid re-selection cannot interleave the
/// persist/switch pairs.
class TranscriptionModelService {
  TranscriptionModelService({
    required TranscriptionModelRepository modelRepository,
    required TranscriptionService transcriptionService,
    required TranscriptionConfig transcriptionConfig,
  }) : _modelRepository = modelRepository,
       _transcriptionService = transcriptionService,
       _transcriptionConfig = transcriptionConfig;

  final TranscriptionModelRepository _modelRepository;
  final TranscriptionService _transcriptionService;
  final TranscriptionConfig _transcriptionConfig;

  Future<void> _queue = Future.value();

  /// True when the transcription settings screen has something to offer: the
  /// pool runs the local engine in this mode (the remote mode ignores the
  /// tier entirely). Independent of whether the *currently effective*
  /// selection happens to be [LocalTranscriptionModelOff] - the user must
  /// still be able to reach the screen to turn it on.
  bool get canSelectModel =>
      !kIsWeb && TranscriptionMode.fromName(_transcriptionConfig.mode) == TranscriptionMode.local;

  /// The config default the user's override falls back to.
  LocalTranscriptionModel get defaultModel => _transcriptionConfig.localModel;

  /// The currently effective selection.
  LocalTranscriptionModel get selectedModel => _modelRepository.getTranscriptionModel() ?? defaultModel;

  /// Download/readiness state of the active engine's model, mirrored from
  /// the pool (stable across tier switches).
  ValueListenable<ModelDownloadState> get modelDownloadState => _transcriptionService.modelDownloadState;

  /// Whether a usable model file for the [tier] is already on disk.
  Future<bool> isModelDownloaded(String tier) => LocalWhisperTranscriptionDataSource.isModelDownloaded(tier);

  /// Starts (or retries) the active model download without waiting for the
  /// first transcription; failures land in [modelDownloadState] and are only
  /// logged here.
  Future<void> prepareModel() async {
    try {
      await _transcriptionService.prepareEngine();
    } catch (e, st) {
      _logger.warning('Failed to prepare the transcription model', e, st);
    }
  }

  /// Applies [model] ([defaultModel] clears the override): switches the pool
  /// (regenerating every stored transcript) and persists the choice. Throws
  /// when the switch fails; nothing is persisted then.
  Future<void> setModel(LocalTranscriptionModel model) {
    final override = model == defaultModel ? null : model;

    final task = _queue.then((_) async {
      final previousOverride = _modelRepository.getTranscriptionModel();
      await _modelRepository.setTranscriptionModel(override);
      try {
        await _transcriptionService.switchLocalModel(override);
      } catch (e) {
        // Best effort: the override must not survive a refused switch.
        try {
          await _modelRepository.setTranscriptionModel(previousOverride);
        } catch (revertError) {
          _logger.warning('Failed to revert the model override after a failed switch', revertError);
        }
        rethrow;
      }
      // Start the download right away so the user watches the progress where
      // the choice was made instead of waiting for the first transcription.
      unawaited(prepareModel());
    });
    // The queue itself must survive a failed task; the error still reaches
    // the caller through the returned future.
    _queue = task.catchError((_) {});
    return task;
  }
}
