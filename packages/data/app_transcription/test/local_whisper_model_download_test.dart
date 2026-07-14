import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:whisper_ggml/whisper_ggml.dart';

import 'package:app_transcription/src/local_whisper_transcription_datasource_io.dart';
import 'package:app_transcription/src/model_download_state.dart';
import 'package:app_transcription/src/transcription_datasource.dart';

class _FixedPathWhisperController extends WhisperController {
  _FixedPathWhisperController(this.modelPath);

  final String modelPath;

  @override
  Future<String> getPath(WhisperModel model) async => modelPath;
}

void main() {
  final ggmlHeader = LocalWhisperTranscriptionDataSource.ggmlMagic;
  final validModelBytes = Uint8List.fromList([...ggmlHeader, 1, 2, 3, 4]);

  late Directory temporaryDirectory;
  late String modelPath;

  setUp(() {
    temporaryDirectory = Directory.systemTemp.createTempSync('whisper_model_test');
    modelPath = '${temporaryDirectory.path}/ggml-base.bin';
  });

  tearDown(() {
    temporaryDirectory.deleteSync(recursive: true);
  });

  LocalWhisperTranscriptionDataSource createDataSource(http.Client httpClient) {
    return LocalWhisperTranscriptionDataSource(
      controller: _FixedPathWhisperController(modelPath),
      httpClient: httpClient,
    );
  }

  group('isValidModelFileHeader', () {
    test('accepts the ggml magic', () {
      expect(LocalWhisperTranscriptionDataSource.isValidModelFileHeader(validModelBytes), isTrue);
    });

    test('rejects other payloads and short reads', () {
      expect(LocalWhisperTranscriptionDataSource.isValidModelFileHeader('<html>'.codeUnits), isFalse);
      expect(LocalWhisperTranscriptionDataSource.isValidModelFileHeader(const []), isFalse);
      expect(LocalWhisperTranscriptionDataSource.isValidModelFileHeader(ggmlHeader.sublist(0, 2)), isFalse);
    });
  });

  group('downloadState', () {
    test('reports progress against the content length and ends ready', () async {
      final dataSource = createDataSource(
        MockClient.streaming((request, bodyStream) async {
          return http.StreamedResponse(
            Stream.fromIterable([validModelBytes.sublist(0, 4), validModelBytes.sublist(4)]),
            200,
            contentLength: validModelBytes.length,
          );
        }),
      );
      final states = <ModelDownloadState>[];
      dataSource.downloadState.addListener(() => states.add(dataSource.downloadState.value));

      await dataSource.ensureModelReady();

      expect(states.first, isA<ModelDownloading>());
      final downloading = states.whereType<ModelDownloading>().toList();
      expect(downloading.last.received, validModelBytes.length);
      expect(downloading.last.total, validModelBytes.length);
      expect(downloading.last.progress, 1.0);
      expect(dataSource.downloadState.value, isA<ModelDownloadReady>());
    });

    test('is ready without a download when a usable model is cached', () async {
      File(modelPath).writeAsBytesSync(validModelBytes);
      final dataSource = createDataSource(MockClient((request) async => http.Response('unused', 500)));

      await dataSource.ensureModelReady();

      expect(dataSource.downloadState.value, isA<ModelDownloadReady>());
    });

    test('reports the failure and lets prepareEngine retry', () async {
      var requests = 0;
      final dataSource = createDataSource(
        MockClient((request) async {
          requests++;
          if (requests == 1) return http.Response('nope', 503);
          return http.Response.bytes(validModelBytes, 200);
        }),
      );

      await expectLater(dataSource.prepareEngine(), throwsA(isA<TranscriptionException>()));
      expect(dataSource.downloadState.value, isA<ModelDownloadFailed>());

      await dataSource.prepareEngine();
      expect(dataSource.downloadState.value, isA<ModelDownloadReady>());
    });
  });

  group('aborted download', () {
    test('cleans up the partial temp file when the stream fails mid-way', () async {
      final dataSource = createDataSource(
        MockClient.streaming((request, bodyStream) async {
          return http.StreamedResponse(
            () async* {
              yield validModelBytes.sublist(0, 4);
              throw Exception('connection reset');
            }(),
            200,
            contentLength: validModelBytes.length,
          );
        }),
      );

      await expectLater(dataSource.prepareEngine(), throwsA(anything));

      expect(File('$modelPath.download').existsSync(), isFalse);
      expect(dataSource.downloadState.value, isA<ModelDownloadFailed>());
    });

    test('cleans up the temp file when the payload is not a ggml model', () async {
      final dataSource = createDataSource(MockClient((request) async => http.Response('<html>error</html>', 200)));

      await expectLater(dataSource.prepareEngine(), throwsA(isA<TranscriptionException>()));

      expect(File('$modelPath.download').existsSync(), isFalse);
    });
  });

  group('model cache management', () {
    test('sizes and deletes downloaded model files including stray partials', () async {
      final controller = _FixedPathWhisperController(modelPath);
      File(modelPath).writeAsBytesSync(validModelBytes);
      File('$modelPath.download').writeAsBytesSync([1, 2, 3]);

      // The fixed-path controller maps every tier to the same file, so the
      // sum counts it once per tier; assert against that arithmetic.
      final tiers = WhisperModel.values.length;
      expect(
        await LocalWhisperTranscriptionDataSource.downloadedModelsSizeBytes(controller: controller),
        tiers * (validModelBytes.length + 3),
      );

      await LocalWhisperTranscriptionDataSource.deleteDownloadedModels(controller: controller);

      expect(File(modelPath).existsSync(), isFalse);
      expect(File('$modelPath.download').existsSync(), isFalse);
      expect(await LocalWhisperTranscriptionDataSource.downloadedModelsSizeBytes(controller: controller), 0);
    });

    test('prepareEngine re-downloads after the model file was deleted externally', () async {
      var requests = 0;
      final dataSource = createDataSource(
        MockClient((request) async {
          requests++;
          return http.Response.bytes(validModelBytes, 200);
        }),
      );

      await dataSource.prepareEngine();
      expect(requests, 1);

      // Cache management wipes the files behind the source's back.
      File(modelPath).deleteSync();

      await dataSource.prepareEngine();
      expect(requests, 2);
      expect(File(modelPath).existsSync(), isTrue);
      expect(dataSource.downloadState.value, isA<ModelDownloadReady>());
    });
  });

  group('isModelDownloaded', () {
    test('true only for a usable cached file', () async {
      final controller = _FixedPathWhisperController(modelPath);

      expect(await LocalWhisperTranscriptionDataSource.isModelDownloaded('base', controller: controller), isFalse);

      File(modelPath).writeAsBytesSync(validModelBytes);
      expect(await LocalWhisperTranscriptionDataSource.isModelDownloaded('base', controller: controller), isTrue);

      File(modelPath).writeAsBytesSync('<html>error</html>'.codeUnits);
      expect(await LocalWhisperTranscriptionDataSource.isModelDownloaded('base', controller: controller), isFalse);
    });
  });

  group('ensureModelReady', () {
    test('downloads and stores a valid model file', () async {
      final dataSource = createDataSource(MockClient((request) async => http.Response.bytes(validModelBytes, 200)));

      await dataSource.ensureModelReady();

      expect(File(modelPath).readAsBytesSync(), validModelBytes);
    });

    test('throws and stores nothing on a non-200 response', () async {
      final dataSource = createDataSource(MockClient((request) async => http.Response('rate limited', 429)));

      await expectLater(dataSource.ensureModelReady(), throwsA(isA<TranscriptionException>()));
      expect(File(modelPath).existsSync(), isFalse);
    });

    test('throws and stores nothing when the payload is not a ggml file', () async {
      final dataSource = createDataSource(MockClient((request) async => http.Response('<html>not found</html>', 200)));

      await expectLater(dataSource.ensureModelReady(), throwsA(isA<TranscriptionException>()));
      expect(File(modelPath).existsSync(), isFalse);
    });

    test('heals a corrupt cached model file by re-downloading', () async {
      File(modelPath).writeAsStringSync('<html>error page cached earlier</html>');
      final dataSource = createDataSource(MockClient((request) async => http.Response.bytes(validModelBytes, 200)));

      await dataSource.ensureModelReady();

      expect(File(modelPath).readAsBytesSync(), validModelBytes);
    });

    test('keeps a valid cached model without re-downloading', () async {
      File(modelPath).writeAsBytesSync(validModelBytes);
      var requests = 0;
      final dataSource = createDataSource(
        MockClient((request) async {
          requests++;
          return http.Response.bytes(validModelBytes, 200);
        }),
      );

      await dataSource.ensureModelReady();

      expect(requests, 0);
    });
  });
}
