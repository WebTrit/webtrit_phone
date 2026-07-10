import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

void main() {
  tearDown(EnvironmentConfig.clearOverrides);

  group('createVoicemailTranscriptionDataSource', () {
    test('returns null when the mode is not set', () {
      EnvironmentConfig.applyOverrides(const {});

      expect(createVoicemailTranscriptionDataSource(), isNull);
    });

    test('returns null for an unknown mode', () {
      EnvironmentConfig.applyOverrides(const {EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE__NAME: 'cloud'});

      expect(createVoicemailTranscriptionDataSource(), isNull);
    });

    test('returns the local whisper source for the local mode', () {
      EnvironmentConfig.applyOverrides(const {EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE__NAME: 'local'});

      expect(createVoicemailTranscriptionDataSource(), isA<LocalWhisperTranscriptionDataSource>());
    });

    test('returns null for the remote mode without a URL', () {
      EnvironmentConfig.applyOverrides(const {EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE__NAME: 'remote'});

      expect(createVoicemailTranscriptionDataSource(), isNull);
    });

    test('returns null for the remote mode with a scheme-less URL', () {
      EnvironmentConfig.applyOverrides(const {
        EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE__NAME: 'remote',
        EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_REMOTE_URL__NAME: 'stt.example.com/v1',
      });

      expect(createVoicemailTranscriptionDataSource(), isNull);
    });

    test('returns the remote whisper source for the remote mode with a URL', () {
      EnvironmentConfig.applyOverrides(const {
        EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_MODE__NAME: 'remote',
        EnvironmentConfig.VOICEMAIL_TRANSCRIPTION_REMOTE_URL__NAME: 'https://stt.example.com/v1',
      });

      expect(createVoicemailTranscriptionDataSource(), isA<RemoteWhisperTranscriptionDataSource>());
    });
  });

  group('TranscriptionMode.fromName', () {
    test('parses known modes case-insensitively', () {
      expect(TranscriptionMode.fromName('local'), TranscriptionMode.local);
      expect(TranscriptionMode.fromName('Remote'), TranscriptionMode.remote);
    });

    test('falls back to disabled for unknown values', () {
      expect(TranscriptionMode.fromName(''), TranscriptionMode.disabled);
      expect(TranscriptionMode.fromName('whatever'), TranscriptionMode.disabled);
    });
  });
}
