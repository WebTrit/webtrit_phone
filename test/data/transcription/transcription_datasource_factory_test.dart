import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  group('createVoicemailTranscriptionDataSource', () {
    test('returns null for the default config', () {
      expect(createVoicemailTranscriptionDataSource(const VoicemailTranscriptionConfig()), isNull);
    });

    test('returns null for an unknown mode', () {
      expect(createVoicemailTranscriptionDataSource(const VoicemailTranscriptionConfig(mode: 'cloud')), isNull);
    });

    test('returns the local whisper source for the local mode', () {
      expect(
        createVoicemailTranscriptionDataSource(const VoicemailTranscriptionConfig(mode: 'local')),
        isA<LocalWhisperTranscriptionDataSource>(),
      );
    });

    test('returns null for the remote mode without a URL', () {
      expect(createVoicemailTranscriptionDataSource(const VoicemailTranscriptionConfig(mode: 'remote')), isNull);
    });

    test('returns null for the remote mode with a scheme-less URL', () {
      expect(
        createVoicemailTranscriptionDataSource(
          const VoicemailTranscriptionConfig(mode: 'remote', remoteUrl: 'stt.example.com/v1'),
        ),
        isNull,
      );
    });

    test('returns the remote whisper source for the remote mode with a URL', () {
      expect(
        createVoicemailTranscriptionDataSource(
          const VoicemailTranscriptionConfig(mode: 'remote', remoteUrl: 'https://stt.example.com/v1'),
        ),
        isA<RemoteWhisperTranscriptionDataSource>(),
      );
    });
  });

  group('TranscriptionMode.fromName', () {
    test('parses known modes case-insensitively', () {
      expect(TranscriptionMode.fromName('local'), TranscriptionMode.local);
      expect(TranscriptionMode.fromName('Remote'), TranscriptionMode.remote);
      expect(TranscriptionMode.fromName('disabled'), TranscriptionMode.disabled);
    });

    test('falls back to disabled for unknown values', () {
      expect(TranscriptionMode.fromName(''), TranscriptionMode.disabled);
      expect(TranscriptionMode.fromName('whatever'), TranscriptionMode.disabled);
    });
  });

  group('VoicemailMapper', () {
    test('copies the transcription section from the app config', () {
      const appConfig = AppConfig(
        voicemail: AppConfigVoicemail(
          transcription: AppConfigVoicemailTranscription(
            mode: 'remote',
            language: 'en',
            local: AppConfigVoicemailTranscriptionLocal(model: 'small'),
            remote: AppConfigVoicemailTranscriptionRemote(
              url: 'https://stt.example.com/v1',
              apiKey: 'key',
              model: 'large-v3',
            ),
          ),
        ),
      );

      final config = VoicemailMapper.map(appConfig).transcription;

      expect(config.mode, 'remote');
      expect(config.language, 'en');
      expect(config.localModel, 'small');
      expect(config.remoteUrl, 'https://stt.example.com/v1');
      expect(config.remoteApiKey, 'key');
      expect(config.remoteModel, 'large-v3');
    });

    test('defaults to the disabled mode', () {
      final config = VoicemailMapper.map(const AppConfig()).transcription;

      expect(TranscriptionMode.fromName(config.mode), TranscriptionMode.disabled);
      expect(config.language, isNull);
      expect(config.localModel, 'base');
      expect(config.remoteUrl, isNull);
    });
  });
}
