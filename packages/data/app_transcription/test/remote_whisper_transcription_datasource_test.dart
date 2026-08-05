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

  group('RemoteWhisperTranscriptionDataSource upload naming', () {
    Future<String> uploadedFilename(List<int> payload) async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(Uint8List.fromList(payload));

      final body = utf8.decode(captured.bodyBytes, allowMalformed: true);
      return RegExp('filename="([^"]+)"').firstMatch(body)!.group(1)!;
    }

    test('names a RIFF payload as wav', () async {
      expect(await uploadedFilename([0x52, 0x49, 0x46, 0x46, 0, 0, 0, 0]), 'audio.wav');
    });

    test('names an ID3-tagged payload as mp3', () async {
      expect(await uploadedFilename([0x49, 0x44, 0x33, 0x03, 0, 0, 0, 0]), 'audio.mp3');
    });

    test('names a bare MPEG frame payload as mp3', () async {
      expect(await uploadedFilename([0xFF, 0xFB, 0x90, 0x00]), 'audio.mp3');
    });

    test('names an ftyp payload as m4a', () async {
      expect(await uploadedFilename([0, 0, 0, 0x20, 0x66, 0x74, 0x79, 0x70]), 'audio.m4a');
    });

    test('falls back to wav for an unrecognized container', () async {
      expect(await uploadedFilename([1, 2, 3, 4, 5, 6, 7, 8]), 'audio.wav');
    });
  });

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

    test('tolerates a trailing slash on a full endpoint URL', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1/audio/transcriptions/'),
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio);

      expect(captured.url.toString(), 'https://stt.example.com/v1/audio/transcriptions');
    });

    test('tolerates a trailing slash on a base URL', () async {
      late http.Request captured;
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1/'),
        httpClient: okClient((request) => captured = request),
      );

      await dataSource.transcribe(audio);

      expect(captured.url.toString(), 'https://stt.example.com/v1/audio/transcriptions');
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

    test('throws a transient TranscriptionException when the request exceeds the timeout', () async {
      final dataSource = RemoteWhisperTranscriptionDataSource(
        url: Uri.parse('https://stt.example.com/v1'),
        timeout: const Duration(milliseconds: 50),
        httpClient: MockClient((request) async {
          await Future<void>.delayed(const Duration(seconds: 2));
          return http.Response('{"text": "late"}', 200);
        }),
      );

      await expectLater(
        dataSource.transcribe(audio),
        throwsA(isA<TranscriptionException>().having((e) => e.transient, 'transient', isTrue)),
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
