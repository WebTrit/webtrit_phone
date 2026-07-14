import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:app_transcription/app_transcription.dart';

class _GatedDataSource implements TranscriptionDataSource {
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
  Future<Uint8List> loadAudio() async => Uint8List(0);

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
