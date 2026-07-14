import 'package:equatable/equatable.dart';

/// Local Whisper model tiers offered to the user as presets (fast, balanced,
/// accurate); UIs append the config default and the stored selection when
/// those fall outside this list. The full tier vocabulary is the official
/// Whisper model table (see `LocalWhisperTranscriptionDataSource`).
const kTranscriptionModelPresets = ['base', 'small', 'medium'];

/// Raw client-side media transcription settings (the resolved `transcription`
/// section of the application config); parsing and validation happen when the
/// transcription source is built from this config by
/// `createTranscriptionDataSource`. Voicemail is the first consumer.
class TranscriptionConfig extends Equatable {
  const TranscriptionConfig({
    this.mode = 'disabled',
    this.language,
    this.localModel = 'base',
    this.remoteUrl,
    this.remoteApiKey,
    this.remoteModel = 'whisper-1',
  });

  /// Transcription source name: `disabled`, `local` or `remote`; unknown
  /// values disable the feature.
  final String mode;

  /// Expected audio language (ISO 639-1); null or empty means auto-detect.
  final String? language;

  /// Whisper model tier downloaded to the device in the `local` mode; the
  /// default the user's in-app model choice falls back to.
  final String localModel;

  /// Base URL of an OpenAI-compatible speech-to-text service for the `remote` mode.
  final String? remoteUrl;

  /// Optional bearer token sent to the remote service.
  final String? remoteApiKey;

  /// Model name passed to the remote service.
  final String remoteModel;

  @override
  List<Object?> get props => [mode, language, localModel, remoteUrl, remoteApiKey, remoteModel];
}
