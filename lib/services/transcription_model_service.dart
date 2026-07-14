import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Session-wide owner of the transcription model choice, shared by every
/// transcription consumer (the settings page is the only writer today).
///
/// A change switches the pool first and persists the override after: a
/// failed switch (which throws) must not leave a persisted model that would
/// silently apply on the next start. Changes are serialized so rapid
/// re-selection cannot interleave the switch/persist pairs.
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

  /// True when picking a model tier has an effect: the pool transcribes and
  /// runs the local engine (the remote mode ignores the tier entirely).
  /// There is no brand flag behind this - the config only sets the default
  /// tier; the gate is purely functional.
  bool get canSelectModel =>
      _transcriptionService.isEnabled &&
      TranscriptionMode.fromName(_transcriptionConfig.mode) == TranscriptionMode.local;

  /// The config default tier the user's override falls back to.
  String get defaultModel => _transcriptionConfig.localModel;

  /// The currently effective tier.
  String get selectedModel => _modelRepository.getTranscriptionModel() ?? defaultModel;

  /// Applies [model] ([defaultModel] clears the override): switches the pool
  /// (regenerating every stored transcript) and persists the choice. Throws
  /// when the switch fails; nothing is persisted then.
  Future<void> setModel(String model) {
    final override = model == defaultModel ? null : model;

    final task = _queue.then((_) async {
      await _transcriptionService.switchLocalModel(override);
      await _modelRepository.setTranscriptionModel(override);
    });
    // The queue itself must survive a failed task; the error still reaches
    // the caller through the returned future.
    _queue = task.catchError((_) {});
    return task;
  }
}
