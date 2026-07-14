import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:logging/logging.dart';

import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('TranscriptionDataSourceFactory');

/// Source selector for media transcription.
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

/// Builds the transcription source described by [config] (the `transcription`
/// section of the app config), or `null` when the feature
/// is disabled or misconfigured for this platform.
///
/// [localModelOverride] replaces the configured local model tier with the
/// user's choice from the transcription settings; null keeps the config default.
///
/// [certs] lets the remote source talk to self-hosted endpoints secured by
/// the same trusted certificates the rest of the app uses.
TranscriptionDataSource? createTranscriptionDataSource(
  TranscriptionConfig config, {
  String? localModelOverride,
  TrustedCertificates certs = TrustedCertificates.empty,
}) {
  final mode = TranscriptionMode.fromName(config.mode);

  if (config.mode.isNotEmpty && mode == TranscriptionMode.disabled && config.mode != TranscriptionMode.disabled.name) {
    _logger.warning('Unknown transcription mode "${config.mode}"; transcription disabled');
  }

  switch (mode) {
    case TranscriptionMode.disabled:
      return null;

    case TranscriptionMode.local:
      if (kIsWeb) {
        _logger.warning('Local transcription is not supported on web; transcription disabled');
        return null;
      }
      return LocalWhisperTranscriptionDataSource(
        model: localModelOverride ?? config.localModel,
        defaultLanguage: config.language,
      );

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
        connectionTimeout: kApiClientConnectionTimeout,
        certs: certs,
      );
  }
}
