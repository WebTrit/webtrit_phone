import 'dart:convert';
import 'dart:typed_data';

import 'package:_http_client/_http_client.dart';
import 'package:http/http.dart' as http;

import 'transcription_datasource.dart';

/// Remote transcription against an OpenAI-compatible speech-to-text API
/// (`POST <base>/audio/transcriptions`), e.g. OpenAI itself or a self-hosted
/// Whisper server (Speaches, faster-whisper-server, etc.).
///
/// Without an injected [httpClient] the source builds its own client with
/// [connectionTimeout] and [certs], so self-hosted endpoints secured by the
/// consumer's trusted certificates work out of the box.
class RemoteWhisperTranscriptionDataSource extends TranscriptionDataSource {
  RemoteWhisperTranscriptionDataSource({
    required Uri url,
    String? apiKey,
    String model = 'whisper-1',
    String? defaultLanguage,
    http.Client? httpClient,
    Duration? connectionTimeout,
    TrustedCertificates certs = TrustedCertificates.empty,
    Duration timeout = const Duration(seconds: 60),
  }) : _endpoint = _resolveEndpoint(url),
       _apiKey = apiKey,
       _model = model,
       // An empty hint means "not set" (a blank dart-define), i.e. auto-detect.
       _defaultLanguage = (defaultLanguage == null || defaultLanguage.isEmpty) ? null : defaultLanguage,
       _httpClient = httpClient ?? createHttpClient(connectionTimeout: connectionTimeout, certs: certs),
       _timeout = timeout;

  final Uri _endpoint;
  final String? _apiKey;
  final String _model;
  final String? _defaultLanguage;
  final http.Client _httpClient;

  /// Overall deadline for one transcription request. The consumer processes
  /// voicemails sequentially, so a hung endpoint without a deadline would
  /// stall every following message for the rest of the session.
  final Duration _timeout;

  @override
  String get engine => 'openai-compatible:$_model';

  @override
  void dispose() {
    _httpClient.close();
  }

  /// Accepts either the full `.../audio/transcriptions` endpoint or an API base
  /// (e.g. `https://host/v1`) to which the standard suffix is appended.
  /// Trailing slashes are tolerated in both forms.
  static Uri _resolveEndpoint(Uri url) {
    final pathSegments = [...url.pathSegments.where((segment) => segment.isNotEmpty)];

    final isFullEndpoint =
        pathSegments.length >= 2 &&
        pathSegments[pathSegments.length - 2] == 'audio' &&
        pathSegments.last == 'transcriptions';

    return url.replace(pathSegments: isFullEndpoint ? pathSegments : [...pathSegments, 'audio', 'transcriptions']);
  }

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async {
    final request = http.MultipartRequest('POST', _endpoint)
      ..fields['model'] = _model
      ..fields['response_format'] = 'json'
      ..files.add(http.MultipartFile.fromBytes('file', audio, filename: 'voicemail.wav'));

    final effectiveLanguage = (language != null && language.isNotEmpty) ? language : _defaultLanguage;
    if (effectiveLanguage != null) {
      request.fields['language'] = effectiveLanguage;
    }

    final apiKey = _apiKey;
    if (apiKey != null && apiKey.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $apiKey';
    }

    final http.Response response;
    try {
      response = await _httpClient.send(request).then(http.Response.fromStream).timeout(_timeout);
    } catch (e) {
      throw TranscriptionException('remote transcription request failed: $e', transient: true);
    }

    if (response.statusCode != 200) {
      throw TranscriptionException(
        'remote transcription failed: HTTP ${response.statusCode}',
        transient: _isTransientStatusCode(response.statusCode),
      );
    }

    final Object? body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {
      throw const TranscriptionException('remote transcription returned a non-JSON payload');
    }

    final text = body is Map<String, dynamic> ? body['text'] : null;
    if (text is! String) {
      throw const TranscriptionException('remote transcription payload has no text field');
    }

    return text.trim();
  }

  /// Request timeout (408), too early (425), rate limiting (429) and server
  /// errors are worth retrying later; other non-200s are permanent for this
  /// payload.
  static bool _isTransientStatusCode(int statusCode) {
    return statusCode == 408 || statusCode == 425 || statusCode == 429 || statusCode >= 500;
  }
}
