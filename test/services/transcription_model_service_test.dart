import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

class _Source extends TranscriptionDataSource {
  _Source(this.engine);

  @override
  final String engine;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';
}

class _Store implements TranscriptionStore {
  Object? removeAllError;

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
  Future<void> removeAll() async {
    final error = removeAllError;
    if (error != null) throw error;
  }
}

class _FakeModelRepo implements TranscriptionModelRepository {
  LocalTranscriptionModel? value;

  @override
  LocalTranscriptionModel? getTranscriptionModel() => value;

  @override
  Future<void> setTranscriptionModel(LocalTranscriptionModel? newValue) async => value = newValue;

  @override
  Future<void> clear() async => value = null;
}

void main() {
  const config = TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelTier('base'));

  TranscriptionService createPool(_Store store) {
    return TranscriptionService(
      (model) => _Source('whisper-ggml:${(model ?? config.localModel).toRawValue()}'),
      store: store,
    );
  }

  test('setModel persists the override and switches the pool', () async {
    final modelRepo = _FakeModelRepo();
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: createPool(_Store()),
      transcriptionConfig: config,
    );

    await service.setModel(const LocalTranscriptionModelTier('small'));

    expect(modelRepo.value, const LocalTranscriptionModelTier('small'));
    expect(service.selectedModel, const LocalTranscriptionModelTier('small'));
  });

  test('setModel(off) persists off and disables the pool', () async {
    final modelRepo = _FakeModelRepo();
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: createPool(_Store()),
      transcriptionConfig: config,
    );

    await service.setModel(const LocalTranscriptionModelOff());

    expect(modelRepo.value, const LocalTranscriptionModelOff());
    expect(service.selectedModel, const LocalTranscriptionModelOff());
  });

  test('a refused switch reverts the persisted override', () async {
    final modelRepo = _FakeModelRepo();
    final store = _Store()..removeAllError = Exception('database locked');
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: createPool(store),
      transcriptionConfig: config,
    );

    await expectLater(service.setModel(const LocalTranscriptionModelTier('small')), throwsA(anything));

    // The wipe failed, the pool kept the old engine - the disk must agree.
    expect(modelRepo.value, isNull);
    expect(service.selectedModel, const LocalTranscriptionModelTier('base'));
  });

  test('a switch on a disposed pool never persists the override', () async {
    final modelRepo = _FakeModelRepo();
    final pool = createPool(_Store());
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: pool,
      transcriptionConfig: config,
    );

    pool.dispose();

    await expectLater(service.setModel(const LocalTranscriptionModelTier('small')), throwsStateError);
    expect(modelRepo.value, isNull);
  });

  group('canSelectModel', () {
    test('true in local mode even when the effective selection is off', () async {
      final modelRepo = _FakeModelRepo();
      final service = TranscriptionModelService(
        modelRepository: modelRepo,
        transcriptionService: createPool(_Store()),
        transcriptionConfig: const TranscriptionConfig(mode: 'local', localModel: LocalTranscriptionModelOff()),
      );

      expect(service.canSelectModel, isTrue);
    });

    test('false outside local mode', () async {
      final modelRepo = _FakeModelRepo();
      final service = TranscriptionModelService(
        modelRepository: modelRepo,
        transcriptionService: createPool(_Store()),
        transcriptionConfig: const TranscriptionConfig(),
      );

      expect(service.canSelectModel, isFalse);
    });
  });
}
