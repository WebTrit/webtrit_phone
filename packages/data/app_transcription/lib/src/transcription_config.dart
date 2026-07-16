import 'package:equatable/equatable.dart';

/// Local Whisper model tiers offered to the user as presets (fast, balanced,
/// accurate); UIs append the config default and the stored selection when
/// those fall outside this list. The full tier vocabulary is the official
/// Whisper model table (see `LocalWhisperTranscriptionDataSource`).
const kTranscriptionModelPresets = ['base', 'small', 'medium'];

/// The raw config/prefs value meaning "no local model" ([LocalTranscriptionModelOff]).
const kLocalTranscriptionModelOffValue = 'off';

/// The user's/config's choice for the `local` transcription engine: either no
/// model at all ([LocalTranscriptionModelOff]) or a specific Whisper tier
/// ([LocalTranscriptionModelTier]). Kept as its own type - rather than a bare
/// tier string that could be confused with a real (if unrecognized) tier name
/// - so "no model" can never reach `WhisperModel` resolution and silently
/// fall back to a tier the user never picked.
sealed class LocalTranscriptionModel extends Equatable {
  const LocalTranscriptionModel();

  /// Parses the raw config/prefs string: [kLocalTranscriptionModelOffValue]
  /// becomes [LocalTranscriptionModelOff], anything else is kept as a tier
  /// name verbatim (validated later, against `WhisperModel`, by the local
  /// data source).
  factory LocalTranscriptionModel.parse(String raw) {
    return raw == kLocalTranscriptionModelOffValue
        ? const LocalTranscriptionModelOff()
        : LocalTranscriptionModelTier(raw);
  }

  /// The inverse of [LocalTranscriptionModel.parse].
  String toRawValue();
}

/// No model selected; local transcription does not run.
class LocalTranscriptionModelOff extends LocalTranscriptionModel {
  const LocalTranscriptionModelOff();

  @override
  String toRawValue() => kLocalTranscriptionModelOffValue;

  @override
  List<Object?> get props => const [];
}

/// A specific Whisper tier (`tiny`, `base`, `small`, ...).
class LocalTranscriptionModelTier extends LocalTranscriptionModel {
  const LocalTranscriptionModelTier(this.name);

  final String name;

  @override
  String toRawValue() => name;

  @override
  List<Object?> get props => [name];
}

/// Raw client-side media transcription settings (the resolved `transcription`
/// section of the application config); parsing and validation happen when the
/// transcription source is built from this config by
/// `createTranscriptionDataSource`. Voicemail is the first consumer.
class TranscriptionConfig extends Equatable {
  const TranscriptionConfig({
    this.mode = 'disabled',
    this.language,
    this.localModel = const LocalTranscriptionModelOff(),
    this.remoteUrl,
    this.remoteApiKey,
    this.remoteModel = 'whisper-1',
  });

  /// Transcription source name: `disabled`, `local` or `remote`; unknown
  /// values disable the feature.
  final String mode;

  /// Expected audio language (ISO 639-1); null or empty means auto-detect.
  final String? language;

  /// Local engine selection in the `local` mode; the default the user's
  /// in-app choice falls back to.
  final LocalTranscriptionModel localModel;

  /// Base URL of an OpenAI-compatible speech-to-text service for the `remote` mode.
  final String? remoteUrl;

  /// Optional bearer token sent to the remote service.
  final String? remoteApiKey;

  /// Model name passed to the remote service.
  final String remoteModel;

  @override
  List<Object?> get props => [mode, language, localModel, remoteUrl, remoteApiKey, remoteModel];
}
