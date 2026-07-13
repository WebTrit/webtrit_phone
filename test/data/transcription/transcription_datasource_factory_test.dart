import 'package:flutter_test/flutter_test.dart';

import 'dart:typed_data';

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

    test('uses the configured local model when no override is given', () {
      final dataSource = createVoicemailTranscriptionDataSource(
        const VoicemailTranscriptionConfig(mode: 'local', localModel: 'small'),
      );

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'small');
    });

    test('the local model override wins over the configured model', () {
      final dataSource = createVoicemailTranscriptionDataSource(
        const VoicemailTranscriptionConfig(mode: 'local', localModel: 'small'),
        localModelOverride: 'medium',
      );

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'medium');
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

  group('SwitchableTranscriptionSource', () {
    test('builds the initial source and rebuilds it per switch, disposing the old one', () {
      final built = <String?>[];
      final sources = <_RecordingDataSource>[];
      final switchable = SwitchableTranscriptionSource((model) {
        built.add(model);
        final source = _RecordingDataSource();
        sources.add(source);
        return source;
      }, initialLocalModel: 'base');

      expect(built, ['base']);
      expect(switchable.current, sources.single);

      expect(switchable.switchLocalModel('small'), isTrue);
      expect(built, ['base', 'small']);
      expect(switchable.current, sources.last);
      expect(sources.first.disposeCalls, 1);
    });

    test('a fixed source reports switching as unsupported', () {
      final source = _RecordingDataSource();
      final switchable = SwitchableTranscriptionSource.fixed(source);

      expect(switchable.switchLocalModel('small'), isFalse);
      expect(switchable.current, source);
      expect(source.disposeCalls, 0);
    });
  });

  group('VoicemailMapper', () {
    test('copies the transcription section from the app config', () {
      const appConfig = AppConfig(
        voicemail: AppConfigVoicemail(
          transcription: AppConfigVoicemailTranscription(
            mode: 'remote',
            language: 'en',
            local: AppConfigVoicemailTranscriptionLocal(model: 'small', userSelectable: false),
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
      expect(config.localModelUserSelectable, isFalse);
      expect(config.remoteUrl, 'https://stt.example.com/v1');
      expect(config.remoteApiKey, 'key');
      expect(config.remoteModel, 'large-v3');
    });

    test('defaults to the disabled mode', () {
      final config = VoicemailMapper.map(const AppConfig()).transcription;

      expect(TranscriptionMode.fromName(config.mode), TranscriptionMode.disabled);
      expect(config.language, isNull);
      expect(config.localModel, 'base');
      expect(config.localModelUserSelectable, isTrue);
      expect(config.remoteUrl, isNull);
    });
  });
}

class _RecordingDataSource implements TranscriptionDataSource {
  int disposeCalls = 0;

  @override
  String get engine => 'recording';

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';

  @override
  void dispose() {
    disposeCalls++;
  }
}
