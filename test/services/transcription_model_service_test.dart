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
  String? value;

  @override
  String? getTranscriptionModel() => value;

  @override
  Future<void> setTranscriptionModel(String? newValue) async => value = newValue;

  @override
  Future<void> clear() async => value = null;
}

void main() {
  const config = TranscriptionConfig(mode: 'local', localModel: 'base');

  TranscriptionService createPool(_Store store) {
    return TranscriptionService((model) => _Source('whisper-ggml:${model ?? 'base'}'), store: store);
  }

  test('setModel persists the override and switches the pool', () async {
    final modelRepo = _FakeModelRepo();
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: createPool(_Store()),
      transcriptionConfig: config,
    );

    await service.setModel('small');

    expect(modelRepo.value, 'small');
    expect(service.selectedModel, 'small');
  });

  test('a refused switch reverts the persisted override', () async {
    final modelRepo = _FakeModelRepo();
    final store = _Store()..removeAllError = Exception('database locked');
    final service = TranscriptionModelService(
      modelRepository: modelRepo,
      transcriptionService: createPool(store),
      transcriptionConfig: config,
    );

    await expectLater(service.setModel('small'), throwsA(anything));

    // The wipe failed, the pool kept the old engine - the disk must agree.
    expect(modelRepo.value, isNull);
    expect(service.selectedModel, 'base');
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

    await expectLater(service.setModel('small'), throwsStateError);
    expect(modelRepo.value, isNull);
  });
}
