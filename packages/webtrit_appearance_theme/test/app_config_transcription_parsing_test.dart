import 'package:test/test.dart';

import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

import 'helpers/helpers.dart';

void main() {
  group('AppConfig.transcription parsing', () {
    test('parses the bundled app config with transcription disabled by default', () async {
      final json = await loadFixtureJson('../../assets/themes/app.config.json');

      final config = AppConfig.fromJson(json);
      final transcription = config.transcription;

      expect(transcription.mode, 'disabled');
      expect(transcription.language, isNull);
      expect(transcription.local.model, 'base');
      expect(transcription.local.userSelectable, isTrue);
      expect(transcription.remote.url, isNull);
      expect(transcription.remote.apiKey, isNull);
      expect(transcription.remote.model, 'whisper-1');
    });

    test('parses a fully populated transcription section', () {
      final config = AppConfig.fromJson({
        'transcription': {
          'mode': 'remote',
          'language': 'en',
          'local': {'model': 'small', 'userSelectable': false},
          'remote': {'url': 'https://stt.example.com/v1', 'apiKey': 'key', 'model': 'large-v3'},
        },
      });
      final transcription = config.transcription;

      expect(transcription.mode, 'remote');
      expect(transcription.language, 'en');
      expect(transcription.local.model, 'small');
      expect(transcription.local.userSelectable, isFalse);
      expect(transcription.remote.url, 'https://stt.example.com/v1');
      expect(transcription.remote.apiKey, 'key');
      expect(transcription.remote.model, 'large-v3');
    });

    test('falls back to defaults when the section is absent', () {
      final config = AppConfig.fromJson(const {});
      final transcription = config.transcription;

      expect(transcription.mode, 'disabled');
      expect(transcription.language, isNull);
      expect(transcription.local.model, 'base');
      expect(transcription.remote.url, isNull);
    });
  });
}
