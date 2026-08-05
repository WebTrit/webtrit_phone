import 'package:flutter_test/flutter_test.dart';

import 'package:app_transcription/app_transcription.dart';

void main() {
  group('createTranscriptionDataSource', () {
    test('returns null for the default config', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig()), isNull);
    });

    test('returns null for an unknown mode', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig(mode: 'cloud')), isNull);
    });

    test('returns null for the remote mode without a URL', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig(mode: 'remote')), isNull);
    });

    test('returns null for the remote mode with a scheme-less URL', () {
      expect(
        createTranscriptionDataSource(const TranscriptionConfig(mode: 'remote', remoteUrl: 'stt.example.com/v1')),
        isNull,
      );
    });

    test('returns the remote whisper source for the remote mode with a URL', () {
      expect(
        createTranscriptionDataSource(
          const TranscriptionConfig(mode: 'remote', remoteUrl: 'https://stt.example.com/v1'),
        ),
        isA<RemoteWhisperTranscriptionDataSource>(),
      );
    });
  });

  group('TranscriptionMode.fromName', () {
    test('parses known modes case-insensitively', () {
      expect(TranscriptionMode.fromName('Remote'), TranscriptionMode.remote);
      expect(TranscriptionMode.fromName('disabled'), TranscriptionMode.disabled);
    });

    test('falls back to disabled for unknown values', () {
      expect(TranscriptionMode.fromName(''), TranscriptionMode.disabled);
      expect(TranscriptionMode.fromName('whatever'), TranscriptionMode.disabled);
    });
  });
}
