import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'transcription_datasource.dart';

/// Remote transcription against an OpenAI-compatible speech-to-text API
/// (`POST <base>/audio/transcriptions`), e.g. OpenAI itself or a self-hosted
/// Whisper server (Speaches, faster-whisper-server, etc.).
class RemoteWhisperTranscriptionDataSource implements TranscriptionDataSource {
  RemoteWhisperTranscriptionDataSource({
    required Uri url,
    String? apiKey,
    String model = 'whisper-1',
    String? defaultLanguage,
    http.Client? httpClient,
  }) : _endpoint = _resolveEndpoint(url),
       _apiKey = apiKey,
       _model = model,
       // An empty hint means "not set" (a blank dart-define), i.e. auto-detect.
       _defaultLanguage = (defaultLanguage == null || defaultLanguage.isEmpty) ? null : defaultLanguage,
       _httpClient = httpClient ?? http.Client();

  static const _endpointSuffix = 'audio/transcriptions';

  final Uri _endpoint;
  final String? _apiKey;
  final String _model;
  final String? _defaultLanguage;
  final http.Client _httpClient;

  /// Accepts either the full `.../audio/transcriptions` endpoint or an API base
  /// (e.g. `https://host/v1`) to which the standard suffix is appended.
  static Uri _resolveEndpoint(Uri url) {
    if (url.path.endsWith(_endpointSuffix)) return url;

    final pathSegments = [...url.pathSegments.where((segment) => segment.isNotEmpty), 'audio', 'transcriptions'];
    return url.replace(pathSegments: pathSegments);
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
      response = await http.Response.fromStream(await _httpClient.send(request));
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
