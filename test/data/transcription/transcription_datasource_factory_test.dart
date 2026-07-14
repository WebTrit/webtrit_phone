import 'package:flutter_test/flutter_test.dart';

import 'dart:typed_data';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

class _NoopTranscriptionStore implements TranscriptionStore {
  @override
  Future<bool> saveInProgress(String mediaType, String mediaId, String engine) async => true;

  @override
  Future<void> saveTranscript(String mediaType, String mediaId, String transcript, String engine) async {}

  @override
  Future<bool> saveFailure(String mediaType, String mediaId, Object error, String engine) async => true;

  @override
  Future<void> remove(String mediaType, String mediaId) async {}

  @override
  Future<void> removeAllForType(String mediaType) async {}

  @override
  Future<void> removeAll() async {}
}

void main() {
  group('createTranscriptionDataSource', () {
    test('returns null for the default config', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig()), isNull);
    });

    test('returns null for an unknown mode', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig(mode: 'cloud')), isNull);
    });

    test('returns the local whisper source for the local mode', () {
      expect(
        createTranscriptionDataSource(const TranscriptionConfig(mode: 'local')),
        isA<LocalWhisperTranscriptionDataSource>(),
      );
    });

    test('uses the configured local model when no override is given', () {
      final dataSource = createTranscriptionDataSource(const TranscriptionConfig(mode: 'local', localModel: 'small'));

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'small');
    });

    test('the local model override wins over the configured model', () {
      final dataSource = createTranscriptionDataSource(
        const TranscriptionConfig(mode: 'local', localModel: 'small'),
        localModelOverride: 'medium',
      );

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'medium');
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
      expect(TranscriptionMode.fromName('local'), TranscriptionMode.local);
      expect(TranscriptionMode.fromName('Remote'), TranscriptionMode.remote);
      expect(TranscriptionMode.fromName('disabled'), TranscriptionMode.disabled);
    });

    test('falls back to disabled for unknown values', () {
      expect(TranscriptionMode.fromName(''), TranscriptionMode.disabled);
      expect(TranscriptionMode.fromName('whatever'), TranscriptionMode.disabled);
    });
  });

  group('TranscriptionService model switching', () {
    test('builds the initial source and rebuilds it per switch, disposing the old one', () async {
      final built = <String?>[];
      final sources = <_RecordingDataSource>[];
      final service = TranscriptionService(
        (model) {
          built.add(model);
          final source = _RecordingDataSource(engine: 'recording:$model');
          sources.add(source);
          return source;
        },
        initialLocalModel: 'base',
        store: _NoopTranscriptionStore(),
      );

      expect(built, ['base']);
      expect(service.isEnabled, isTrue);

      await service.switchLocalModel('small');
      expect(built, ['base', 'small']);
      expect(sources.first.disposeCalls, 1);
      expect(sources.last.disposeCalls, 0);
    });

    test('a fixed pool ignores model switches', () async {
      final source = _RecordingDataSource();
      final service = TranscriptionService.fixed(source, store: _NoopTranscriptionStore());

      await service.switchLocalModel('small');

      expect(service.isEnabled, isTrue);
      expect(source.disposeCalls, 0);
    });
  });

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
      expect(config.localModel, 'small');
      expect(config.remoteUrl, 'https://stt.example.com/v1');
      expect(config.remoteApiKey, 'key');
      expect(config.remoteModel, 'large-v3');
    });

    test('defaults to the disabled mode', () {
      final config = TranscriptionMapper.map(const AppConfig());

      expect(TranscriptionMode.fromName(config.mode), TranscriptionMode.disabled);
      expect(config.language, isNull);
      expect(config.localModel, 'base');
      expect(config.remoteUrl, isNull);
    });
  });
}

class _RecordingDataSource implements TranscriptionDataSource {
  // The pool compares engines on a switch (the real sources embed the model
  // tier), so each built source carries a distinct engine.
  _RecordingDataSource({this.engine = 'recording'});

  int disposeCalls = 0;

  @override
  final String engine;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';

  @override
  void dispose() {
    disposeCalls++;
  }
}
