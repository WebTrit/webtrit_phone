import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  group('TranscriptionMapper', () {
    test('copies the transcription section from the app config', () {
      const appConfig = AppConfig(
        transcription: AppConfigTranscription(
          mode: 'remote',
          language: 'en',
          local: AppConfigTranscriptionLocal(model: 'small'),
          remote: AppConfigTranscriptionRemote(url: 'https://stt.example.com/v1', apiKey: 'key', model: 'large-v3'),
        ),
      );

      final config = TranscriptionMapper.map(appConfig);

      expect(config.mode, 'remote');
      expect(config.language, 'en');
      expect(config.localModel, const LocalTranscriptionModelTier('small'));
      expect(config.remoteUrl, 'https://stt.example.com/v1');
      expect(config.remoteApiKey, 'key');
      expect(config.remoteModel, 'large-v3');
    });

    test('defaults to the local mode with no local model selected', () {
      final config = TranscriptionMapper.map(const AppConfig());

      expect(TranscriptionMode.fromName(config.mode), TranscriptionMode.local);
      expect(config.language, isNull);
      expect(config.localModel, const LocalTranscriptionModelOff());
      expect(config.remoteUrl, isNull);
    });
  });
}
