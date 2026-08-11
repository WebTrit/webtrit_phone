import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:app_transcription/app_transcription.dart';

class _GatedDataSource extends TranscriptionDataSource {
  final gates = <Completer<String>>[];

  @override
  String get engine => 'gated';

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) {
    final gate = Completer<String>();
    gates.add(gate);
    return gate.future;
  }

  @override
  void dispose() {}
}

class _NoopTranscriptionStore implements TranscriptionStore {
  final inProgressMarks = <String>[];

  @override
  Future<bool> saveInProgress(String mediaType, String mediaId, String engine) async {
    inProgressMarks.add(mediaId);
    return true;
  }

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

class _IdleDataSource extends TranscriptionDataSource {
  _IdleDataSource(this.engine);

  @override
  final String engine;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';
}

class _RecordingRemoveStore extends _NoopTranscriptionStore {
  final removed = <String>[];

  @override
  Future<void> remove(String mediaType, String mediaId) async {
    removed.add('$mediaType/$mediaId');
  }
}

void main() {
  Future<Uint8List> loadAudio() async => Uint8List(0);

  test('forget still removes the stored row after the pool is disposed', () async {
    final store = _RecordingRemoveStore();
    final service = TranscriptionService(_IdleDataSource('fake:base'), store: store);

    service.dispose();
    await service.forget('media', '1');

    expect(store.removed, ['media/1']);
  });

  test('processes up to concurrency items at once and feeds the rest as workers free up', () async {
    final source = _GatedDataSource();
    final service = TranscriptionService(source, store: _NoopTranscriptionStore(), concurrency: 2);

    service.enqueue('media', '1', loadAudio);
    service.enqueue('media', '2', loadAudio);
    service.enqueue('media', '3', loadAudio);
    await pumpEventQueue();

    // Two in flight, the third waits for a free worker.
    expect(source.gates, hasLength(2));

    source.gates[0].complete('done');
    await pumpEventQueue();

    expect(source.gates, hasLength(3));

    source.gates[1].complete('done');
    source.gates[2].complete('done');
    await pumpEventQueue();
  });

  test('marks every queued item in progress immediately, not only when a worker starts it', () async {
    final source = _GatedDataSource();
    final store = _NoopTranscriptionStore();
    final service = TranscriptionService(source, store: store);

    service.enqueue('media', '1', loadAudio);
    service.enqueue('media', '2', loadAudio);
    service.enqueue('media', '3', loadAudio);
    await pumpEventQueue();

    // One item is in flight, but the whole backlog is already visible as
    // in progress in the store.
    expect(source.gates, hasLength(1));
    expect(store.inProgressMarks.toSet(), {'1', '2', '3'});

    for (final gate in [...source.gates]) {
      gate.complete('done');
      await pumpEventQueue();
    }
    source.gates.skip(1).forEach((gate) => gate.isCompleted ? null : gate.complete('done'));
    await pumpEventQueue();
  });

  test('stays strictly sequential with the default concurrency', () async {
    final source = _GatedDataSource();
    final service = TranscriptionService(source, store: _NoopTranscriptionStore());

    service.enqueue('media', '1', loadAudio);
    service.enqueue('media', '2', loadAudio);
    await pumpEventQueue();

    expect(source.gates, hasLength(1));

    source.gates[0].complete('done');
    await pumpEventQueue();

    expect(source.gates, hasLength(2));
    source.gates[1].complete('done');
    await pumpEventQueue();
  });
}
