import 'package:logging/logging.dart';

import 'package:_http_client/_http_client.dart' show TrustedCertificates;

import 'remote_whisper_transcription_datasource.dart';
import 'transcription_config.dart';
import 'transcription_datasource.dart';

final _logger = Logger('TranscriptionDataSourceFactory');

/// Source selector for media transcription.
enum TranscriptionMode {
  disabled,
  remote;

  static TranscriptionMode fromName(String name) {
    return TranscriptionMode.values.firstWhere(
      (value) => value.name == name.toLowerCase(),
      orElse: () => TranscriptionMode.disabled,
    );
  }
}

/// Builds the transcription source described by [config] (the `transcription`
/// section of the app config), or `null` when the feature is disabled or
/// misconfigured.
///
/// [certs] lets the remote source talk to self-hosted endpoints secured by
/// the same trusted certificates the rest of the app uses.
TranscriptionDataSource? createTranscriptionDataSource(
  TranscriptionConfig config, {
  TrustedCertificates certs = TrustedCertificates.empty,
  Duration? connectionTimeout,
}) {
  final mode = TranscriptionMode.fromName(config.mode);

  if (config.mode.isNotEmpty && mode == TranscriptionMode.disabled && config.mode != TranscriptionMode.disabled.name) {
    _logger.warning('Unknown transcription mode "${config.mode}"; transcription disabled');
  }

  switch (mode) {
    case TranscriptionMode.disabled:
      return null;

    case TranscriptionMode.remote:
      final url = Uri.tryParse(config.remoteUrl ?? '');
      if (url == null || !url.hasScheme) {
        _logger.warning('Transcription remote URL is missing or invalid; transcription disabled');
        return null;
      }
      return RemoteWhisperTranscriptionDataSource(
        url: url,
        apiKey: config.remoteApiKey,
        model: config.remoteModel,
        defaultLanguage: config.language,
        connectionTimeout: connectionTimeout,
        certs: certs,
      );
  }
}
