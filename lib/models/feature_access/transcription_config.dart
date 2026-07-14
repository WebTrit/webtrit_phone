import 'package:equatable/equatable.dart';

/// Raw client-side media transcription settings resolved from the app
/// config; parsing and validation happen when the transcription source is
/// built from this config. Voicemail is the first consumer.
class TranscriptionConfig extends Equatable {
  const TranscriptionConfig({
    this.mode = 'disabled',
    this.language,
    this.localModel = 'base',
    this.localModelUserSelectable = true,
    this.remoteUrl,
    this.remoteApiKey,
    this.remoteModel = 'whisper-1',
  });

  /// Transcription source name: `disabled`, `local` or `remote`; unknown
  /// values disable the feature.
  final String mode;

  /// Expected audio language (ISO 639-1); null or empty means auto-detect.
  final String? language;

  /// Whisper model tier downloaded to the device in the `local` mode.
  final String localModel;

  /// Whether the user may switch the local model tier from the transcription
  /// settings; [localModel] stays the default until overridden there.
  final bool localModelUserSelectable;

  /// Base URL of an OpenAI-compatible speech-to-text service for the `remote` mode.
  final String? remoteUrl;

  /// Optional bearer token sent to the remote service.
  final String? remoteApiKey;

  /// Model name passed to the remote service.
  final String remoteModel;

  @override
  List<Object?> get props => [
    mode,
    language,
    localModel,
    localModelUserSelectable,
    remoteUrl,
    remoteApiKey,
    remoteModel,
  ];
}
