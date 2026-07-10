import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:app_transcription/app_transcription.dart';

void main() {
  final audio = Uint8List.fromList(List.generate(64, (i) => i));

  http.Client okClient(void Function(http.Request request) onRequest, {String text = ' hello world '}) {
    return MockClient((request) async {
      onRequest(request);
      return http.Response(jsonEncode({'text': text}), 200);
    });
  }

  group('RemoteWhisperTranscriptionDataSource', () {
    test('posts multipart request to the resolved endpoint and returns trimmed text', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        apiKey: 'secret-key',
        model: 'whisper-large',
        httpClient: okClient((request) => captured = request),
      );

      final result = await dataSource.transcribe(audio);

      expect(result, 'hello world');
      expect(captured.method, 'POST');
      expect(captured.url.toString(), 'https://stt.example.com/v1/audio/transcriptions');
      expect(captured.headers['Authorization'], 'Bearer secret-key');
      expect(captured.headers['content-type'], contains('multipart/form-data'));

      final body = utf8.decode(captured.bodyBytes, allowMalformed: true);
      expect(body, contains('name="model"'));
      expect(body, contains('whisper-large'));
      expect(body, contains('name="file"'));
      expect(body, isNot(contains('name="language"')));
    });

    test('uses a full audio/transcriptions URL as-is', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/openai/v1/audio/transcriptions'),
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio);

      expect(captured.url.toString(), 'https://stt.example.com/openai/v1/audio/transcriptions');
    });

    test('passes the language hint and omits the auth header without an api key', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        defaultLanguage: 'uk',
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio);

      final body = utf8.decode(captured.bodyBytes, allowMalformed: true);
      expect(body, contains('name="language"'));
      expect(body, contains('uk'));
      expect(captured.headers.containsKey('Authorization'), isFalse);
    });

    test('treats an empty default language as auto-detect (no language field)', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        defaultLanguage: '',
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio);

      final body = utf8.decode(captured.bodyBytes, allowMalformed: true);
      expect(body, isNot(contains('name="language"')));
    });

    test('per-call language overrides the default one', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        defaultLanguage: 'uk',
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio, language: 'it');

      final body = utf8.decode(captured.bodyBytes, allowMalformed: true);
      expect(body, contains('it'));
    });

    test('throws a transient TranscriptionException on a retryable response', () async {
      for (final statusCode in [408, 425, 429, 500, 503]) {
        final dataSource = RemoteWhisperTranscriptionDataSource(
          url: Uri.parse('https://stt.example.com/v1'),
          httpClient: MockClient((request) async => http.Response('nope', statusCode)),
        );

        await expectLater(
          dataSource.transcribe(audio),
          throwsA(isA<TranscriptionException>().having((e) => e.transient, 'transient', isTrue)),
        );
      }
    });

    test('throws a permanent TranscriptionException on a non-retryable response', () async {
      for (final statusCode in [400, 401, 404, 422]) {
        final dataSource = RemoteWhisperTranscriptionDataSource(
          url: Uri.parse('https://stt.example.com/v1'),
          httpClient: MockClient((request) async => http.Response('nope', statusCode)),
        );

        await expectLater(
          dataSource.transcribe(audio),
          throwsA(isA<TranscriptionException>().having((e) => e.transient, 'transient', isFalse)),
        );
      }
    });

    test('throws TranscriptionException on a non-JSON payload', () async {
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        httpClient: MockClient((request) async => http.Response('plain text', 200)),
      );

      await expectLater(dataSource.transcribe(audio), throwsA(isA<TranscriptionException>()));
    });

    test('throws TranscriptionException when the payload has no text field', () async {
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        httpClient: MockClient((request) async => http.Response(jsonEncode({'result': 'oops'}), 200)),
      );

      await expectLater(
        dataSource.transcribe(audio),
        throwsA(isA<TranscriptionException>().having((e) => e.transient, 'transient', isFalse)),
      );
    });

    test('throws a transient TranscriptionException when the transport fails', () async {
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        httpClient: MockClient((request) async => throw http.ClientException('connection refused')),
      );

      await expectLater(
        dataSource.transcribe(audio),
        throwsA(isA<TranscriptionException>().having((e) => e.transient, 'transient', isTrue)),
      );
    });
  });
}
