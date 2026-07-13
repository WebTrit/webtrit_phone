import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'helpers/helpers.dart';

void main() {
  group('AppConfig.voicemail parsing', () {
    test('parses the bundled app config with transcription disabled by default', () async {
      final json = await loadFixtureJson('../../assets/themes/app.config.json');

      final config = AppConfig.fromJson(json);
      final transcription = config.voicemail.transcription;

      expect(transcription.mode, 'disabled');
      expect(transcription.language, isNull);
      expect(transcription.local.model, 'base');
      expect(transcription.remote.url, isNull);
      expect(transcription.remote.apiKey, isNull);
      expect(transcription.remote.model, 'whisper-1');
    });

    test('parses a fully populated transcription section', () {
      final config = AppConfig.fromJson({
        'voicemail': {
          'transcription': {
            'mode': 'remote',
            'language': 'en',
            'local': {'model': 'small'},
            'remote': {'url': 'https://stt.example.com/v1', 'apiKey': 'key', 'model': 'large-v3'},
          },
        },
      });
      final transcription = config.voicemail.transcription;

      expect(transcription.mode, 'remote');
      expect(transcription.language, 'en');
      expect(transcription.local.model, 'small');
      expect(transcription.remote.url, 'https://stt.example.com/v1');
      expect(transcription.remote.apiKey, 'key');
      expect(transcription.remote.model, 'large-v3');
    });

    test('falls back to defaults when the section is absent', () {
      final config = AppConfig.fromJson(const {});
      final transcription = config.voicemail.transcription;

      expect(transcription.mode, 'disabled');
      expect(transcription.language, isNull);
      expect(transcription.local.model, 'base');
      expect(transcription.remote.url, isNull);
    });
  });
}
