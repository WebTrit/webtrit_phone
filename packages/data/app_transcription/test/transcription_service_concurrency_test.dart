import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show ValueListenable, ValueNotifier;
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

class _NotifyingDataSource extends TranscriptionDataSource {
  _NotifyingDataSource(this.engine);

  @override
  final String engine;

  final state = ValueNotifier<ModelDownloadState>(const ModelDownloadIdle());

  @override
  ValueListenable<ModelDownloadState> get downloadState => state;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';
}

class _BlockingRemoveAllStore extends _NoopTranscriptionStore {
  final removeAllStarted = Completer<void>();
  final removeAllGate = Completer<void>();
  final removed = <String>[];

  @override
  Future<void> removeAll() async {
    if (!removeAllStarted.isCompleted) removeAllStarted.complete();
    await removeAllGate.future;
  }

  @override
  Future<void> remove(String mediaType, String mediaId) async {
    removed.add('$mediaType/$mediaId');
  }
}

void main() {
  Future<Uint8List> loadAudio() async => Uint8List(0);

  test('an enqueue landing during a model switch is dropped, never fed to the outgoing engine', () async {
    final oldSource = _NotifyingDataSource('fake:base');
    final newSource = _NotifyingDataSource('fake:small');
    final store = _BlockingRemoveAllStore();
    final service = TranscriptionService(
      (model) => model == const LocalTranscriptionModelTier('small') ? newSource : oldSource,
      store: store,
    );

    final switching = service.switchLocalModel(const LocalTranscriptionModelTier('small'));
    await store.removeAllStarted.future;

    // The wipe is in flight; the swap has not happened yet.
    service.enqueue('media', '1', loadAudio);
    await pumpEventQueue();
    expect(store.inProgressMarks, isEmpty);

    store.removeAllGate.complete();
    await switching;
    await pumpEventQueue();

    // Nothing was processed by either engine; the consumer's missing-row
    // watch re-enqueues after the wipe instead.
    expect(store.inProgressMarks, isEmpty);
  });

  test('forget still removes the stored row after the pool is disposed', () async {
    final store = _BlockingRemoveAllStore();
    final service = TranscriptionService.fixed(_NotifyingDataSource('fake:base'), store: store);

    service.dispose();
    await service.forget('media', '1');

    expect(store.removed, ['media/1']);
  });

  test('switchLocalModel throws on a disposed pool instead of silently no-opping', () async {
    final service = TranscriptionService((model) => _NotifyingDataSource('fake:x'), store: _NoopTranscriptionStore());

    service.dispose();

    await expectLater(service.switchLocalModel(const LocalTranscriptionModelTier('small')), throwsStateError);
  });

  test('a fixed pool mirrors its source download state too', () async {
    final source = _NotifyingDataSource('fake:base');
    final service = TranscriptionService.fixed(source, store: _NoopTranscriptionStore());

    expect(service.modelDownloadState.value, isA<ModelDownloadIdle>());
    source.state.value = const ModelDownloadReady();
    expect(service.modelDownloadState.value, isA<ModelDownloadReady>());
  });

  test('modelDownloadState mirrors the active source across switches', () async {
    final first = _NotifyingDataSource('fake:base');
    final second = _NotifyingDataSource('fake:small');
    final service = TranscriptionService(
      (model) => model == const LocalTranscriptionModelTier('small') ? second : first,
      store: _NoopTranscriptionStore(),
    );

    expect(service.modelDownloadState.value, isA<ModelDownloadIdle>());

    first.state.value = const ModelDownloading(received: 1, total: 2);
    expect(service.modelDownloadState.value, isA<ModelDownloading>());

    await service.switchLocalModel(const LocalTranscriptionModelTier('small'));
    expect(service.modelDownloadState.value, isA<ModelDownloadIdle>());

    second.state.value = const ModelDownloadReady();
    expect(service.modelDownloadState.value, isA<ModelDownloadReady>());

    // The old source's notifier must be detached: mutating it is a no-op.
    first.state.value = const ModelDownloadFailed('stale');
    expect(service.modelDownloadState.value, isA<ModelDownloadReady>());
  });

  test('processes up to concurrency items at once and feeds the rest as workers free up', () async {
    final source = _GatedDataSource();
    final service = TranscriptionService.fixed(source, store: _NoopTranscriptionStore(), concurrency: 2);

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
    final service = TranscriptionService.fixed(source, store: store);

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
    final service = TranscriptionService.fixed(source, store: _NoopTranscriptionStore());

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
