import 'package:equatable/equatable.dart';

/// Configuration of the voicemail feature resolved from the app config.
class VoicemailConfig extends Equatable {
  const VoicemailConfig({this.transcription = const VoicemailTranscriptionConfig()});

  final VoicemailTranscriptionConfig transcription;

  @override
  List<Object?> get props => [transcription];
}

/// Raw client-side voicemail transcription settings; parsing and validation
/// happen when the transcription source is built from this config.
class VoicemailTranscriptionConfig extends Equatable {
  const VoicemailTranscriptionConfig({
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

  /// Expected voicemail language (ISO 639-1); null or empty means auto-detect.
  final String? language;

  /// Whisper model tier downloaded to the device in the `local` mode.
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
