import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:whisper_ggml/whisper_ggml.dart';

import 'package:app_transcription/src/local_whisper_transcription_datasource_io.dart';
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
