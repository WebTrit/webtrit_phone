import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:logging/logging.dart';

import 'package:_http_client/_http_client.dart';
import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('TranscriptionDataSourceFactory');

/// Source selector for voicemail transcription.
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

/// Builds the voicemail transcription source described by [config]
/// (`voicemail.transcription` of the app config), or `null` when the feature
/// is disabled or misconfigured for this platform.
///
/// [certs] lets the remote source talk to self-hosted endpoints secured by
/// the same trusted certificates the rest of the app uses.
TranscriptionDataSource? createVoicemailTranscriptionDataSource(
  VoicemailTranscriptionConfig config, {
  TrustedCertificates certs = TrustedCertificates.empty,
}) {
  final mode = TranscriptionMode.fromName(config.mode);

  if (config.mode.isNotEmpty && mode == TranscriptionMode.disabled && config.mode != TranscriptionMode.disabled.name) {
    _logger.warning('Unknown voicemail transcription mode "${config.mode}"; transcription disabled');
  }

  switch (mode) {
    case TranscriptionMode.disabled:
      return null;

    case TranscriptionMode.local:
      if (kIsWeb) {
        _logger.warning('Local voicemail transcription is not supported on web; transcription disabled');
        return null;
      }
      return LocalWhisperTranscriptionDataSource(model: config.localModel, defaultLanguage: config.language);

    case TranscriptionMode.remote:
      final url = Uri.tryParse(config.remoteUrl ?? '');
      if (url == null || !url.hasScheme) {
        _logger.warning('Voicemail transcription remote URL is missing or invalid; transcription disabled');
        return null;
      }
      return RemoteWhisperTranscriptionDataSource(
        url: url,
        apiKey: config.remoteApiKey,
        model: config.remoteModel,
        defaultLanguage: config.language,
        httpClient: createHttpClient(connectionTimeout: kApiClientConnectionTimeout, certs: certs),
      );
  }
}
