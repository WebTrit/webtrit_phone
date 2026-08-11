import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/theme/theme.dart';

void main() {
  tearDown(EnvironmentConfig.clearOverrides);

  group('TranscriptionMapper', () {
    test('copies the transcription section from the app config', () {
      const appConfig = AppConfig(
        transcription: AppConfigTranscription(
          mode: 'remote',
          language: 'en',
          remote: AppConfigTranscriptionRemote(url: 'https://stt.example.com/v1', model: 'large-v3'),
        ),
      );

      final config = TranscriptionMapper.map(appConfig);

      expect(config.mode, 'remote');
      expect(config.language, 'en');
      expect(config.remoteUrl, 'https://stt.example.com/v1');
      expect(config.remoteModel, 'large-v3');
    });

    test('takes the service credential from the environment, not from the app config', () {
      EnvironmentConfig.applyOverrides({EnvironmentConfig.TRANSCRIPTION_API_KEY__NAME: 'secret'});

      final config = TranscriptionMapper.map(const AppConfig());

      expect(config.remoteApiKey, 'secret');
    });

    test('leaves the credential unset when the build did not define one', () {
      final config = TranscriptionMapper.map(const AppConfig());

      expect(config.remoteApiKey, isNull);
    });

    test('defaults to the remote mode without an endpoint, which keeps the feature off', () {
      final config = TranscriptionMapper.map(const AppConfig());

      expect(TranscriptionMode.fromName(config.mode), TranscriptionMode.remote);
      expect(config.language, isNull);
      expect(config.remoteUrl, isNull);
      expect(createTranscriptionDataSource(config), isNull);
    });
  });
}
