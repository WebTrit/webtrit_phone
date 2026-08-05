import 'package:equatable/equatable.dart';

/// Raw client-side media transcription settings (the resolved `transcription`
/// section of the application config); parsing and validation happen when the
/// transcription source is built from this config by
/// `createTranscriptionDataSource`. Voicemail is the first consumer.
class TranscriptionConfig extends Equatable {
  const TranscriptionConfig({
    this.mode = 'disabled',
    this.language,
    this.remoteUrl,
    this.remoteApiKey,
    this.remoteModel = 'whisper-1',
  });

  /// Transcription source name: `disabled` or `remote`; unknown values
  /// disable the feature.
  final String mode;

  /// Expected audio language (ISO 639-1); null or empty means auto-detect.
  final String? language;

  /// Base URL of an OpenAI-compatible speech-to-text service.
  final String? remoteUrl;

  /// Bearer token sent to the remote service. Comes from the build-time
  /// environment rather than the application config: the transcription
  /// service is billed per request, so the credential belongs to whoever
  /// builds the brand, not to the theme its editors can pass around.
  final String? remoteApiKey;

  /// Model name passed to the remote service.
  final String remoteModel;

  @override
  List<Object?> get props => [mode, language, remoteUrl, remoteApiKey, remoteModel];
}
