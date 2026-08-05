import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:logging/logging.dart';

import 'package:_http_client/_http_client.dart' show TrustedCertificates;

import 'local_whisper_transcription_datasource.dart';
import 'remote_whisper_transcription_datasource.dart';
import 'transcription_config.dart';
import 'transcription_datasource.dart';

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
/// [localModelOverride] replaces the configured local model selection with
/// the user's choice from the transcription settings; null keeps the config
/// default.
///
/// [certs] lets the remote source talk to self-hosted endpoints secured by
/// the same trusted certificates the rest of the app uses.
TranscriptionDataSource? createTranscriptionDataSource(
  TranscriptionConfig config, {
  LocalTranscriptionModel? localModelOverride,
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

    case TranscriptionMode.local:
      if (kIsWeb) {
        _logger.warning('Local transcription is not supported on web; transcription disabled');
        return null;
      }
      return switch (localModelOverride ?? config.localModel) {
        LocalTranscriptionModelOff() => null,
        LocalTranscriptionModelTier(:final name) => LocalWhisperTranscriptionDataSource(
          model: name,
          defaultLanguage: config.language,
        ),
      };

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
