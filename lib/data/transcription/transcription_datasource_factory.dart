import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:logging/logging.dart';

import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_phone/environment_config.dart';

final _logger = Logger('TranscriptionDataSourceFactory');

/// Source selector for voicemail transcription, driven by dart-defines.
enum TranscriptionMode {
  disabled,
  local,
  remote;

  static TranscriptionMode fromName(String name) {
    return TranscriptionMode.values.firstWhere(
      (value) => value.name == name.toLowerCase(),
      orElse: () => TranscriptionMode.disabled,
    );
  }
}

/// Builds the voicemail transcription source configured via [EnvironmentConfig],
/// or `null` when the feature is disabled or misconfigured for this platform.
TranscriptionDataSource? createVoicemailTranscriptionDataSource() {
  final rawMode = EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE;
  final mode = TranscriptionMode.fromName(rawMode);

  if (rawMode.isNotEmpty && mode == TranscriptionMode.disabled) {
    _logger.warning('Unknown voicemail transcription mode "$rawMode"; transcription disabled');
  }

  switch (mode) {
    case TranscriptionMode.disabled:
      return null;

    case TranscriptionMode.local:
      if (kIsWeb) {
        _logger.warning('Local voicemail transcription is not supported on web; transcription disabled');
        return null;
      }
      return LocalWhisperTranscriptionDataSource(
        model: EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_LOCAL_MODEL,
        defaultLanguage: EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_LANGUAGE,
      );

    case TranscriptionMode.remote:
      final url = Uri.tryParse(EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_REMOTE_URL ?? '');
      if (url == null || !url.hasScheme) {
        _logger.warning('Voicemail transcription remote URL is missing or invalid; transcription disabled');
        return null;
      }
      return RemoteWhisperTranscriptionDataSource(
        url: url,
        apiKey: EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_REMOTE_API_KEY,
        model: EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_REMOTE_MODEL,
        defaultLanguage: EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_LANGUAGE,
      );
  }
}
