import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:app_transcription/app_transcription.dart';

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

    test('returns null for the local mode when no tier is selected (off)', () {
      expect(createTranscriptionDataSource(const TranscriptionConfig(mode: 'local')), isNull);
    });

    test('returns the local whisper source for the local mode with a tier', () {
      expect(
        createTranscriptionDataSource(
          const TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelTier('base')),
        ),
        isA<LocalWhisperTranscriptionDataSource>(),
      );
    });

    test('uses the configured local model when no override is given', () {
      final dataSource = createTranscriptionDataSource(
        const TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelTier('small')),
      );

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'small');
    });

    test('the local model override wins over the configured model', () {
      final dataSource = createTranscriptionDataSource(
        const TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelTier('small')),
        localModelOverride: const LocalTranscriptionModelTier('medium'),
      );

      expect((dataSource! as LocalWhisperTranscriptionDataSource).modelName, 'medium');
    });

    test('an off override wins over a configured tier', () {
      final dataSource = createTranscriptionDataSource(
        const TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelTier('small')),
        localModelOverride: const LocalTranscriptionModelOff(),
      );

      expect(dataSource, isNull);
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
      final built = <LocalTranscriptionModel?>[];
      final sources = <_RecordingDataSource>[];
      final service = TranscriptionService(
        (model) {
          built.add(model);
          final source = _RecordingDataSource(engine: 'recording:${model?.toRawValue()}');
          sources.add(source);
          return source;
        },
        initialLocalModel: const LocalTranscriptionModelTier('base'),
        store: _NoopTranscriptionStore(),
      );

      expect(built, [const LocalTranscriptionModelTier('base')]);
      expect(service.isEnabled, isTrue);

      await service.switchLocalModel(const LocalTranscriptionModelTier('small'));
      expect(built, [const LocalTranscriptionModelTier('base'), const LocalTranscriptionModelTier('small')]);
      expect(sources.first.disposeCalls, 1);
      expect(sources.last.disposeCalls, 0);
    });

    test('switching to off disables the pool without disposing via a rebuilt source', () async {
      final built = <LocalTranscriptionModel?>[];
      final service = TranscriptionService(
        (model) {
          built.add(model);
          return model is LocalTranscriptionModelTier ? _RecordingDataSource(engine: 'recording:${model.name}') : null;
        },
        initialLocalModel: const LocalTranscriptionModelTier('base'),
        store: _NoopTranscriptionStore(),
      );

      await service.switchLocalModel(const LocalTranscriptionModelOff());

      expect(built, [const LocalTranscriptionModelTier('base'), const LocalTranscriptionModelOff()]);
      expect(service.isEnabled, isFalse);
    });

    test('a fixed pool ignores model switches', () async {
      final source = _RecordingDataSource();
      final service = TranscriptionService.fixed(source, store: _NoopTranscriptionStore());

      await service.switchLocalModel(const LocalTranscriptionModelTier('small'));

      expect(service.isEnabled, isTrue);
      expect(source.disposeCalls, 0);
    });
  });
}

class _RecordingDataSource extends TranscriptionDataSource {
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
