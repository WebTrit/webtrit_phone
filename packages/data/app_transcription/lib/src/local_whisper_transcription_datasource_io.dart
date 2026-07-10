import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whisper_ggml/whisper_ggml.dart';

import 'transcription_datasource.dart';

final _logger = Logger('LocalWhisperTranscriptionDataSource');

/// On-device Whisper transcription backed by `whisper_ggml` (whisper.cpp).
///
/// The ggml model is downloaded on first use and cached on disk, so the
/// first transcription may take noticeably longer than the following ones.
/// Incoming audio is converted to the 16 kHz mono WAV expected by Whisper
/// before recognition (voicemail audio is telephony 8 kHz).
class LocalWhisperTranscriptionDataSource implements TranscriptionDataSource {
  LocalWhisperTranscriptionDataSource({
    String model = 'base',
    String? defaultLanguage,
    WhisperController? controller,
    http.Client? httpClient,
  }) : _model = WhisperModel.values.firstWhere((value) => value.modelName == model, orElse: () => WhisperModel.base),
       _defaultLanguage = defaultLanguage,
       _controller = controller ?? WhisperController(),
       _httpClient = httpClient ?? http.Client();

  /// Language passed to Whisper when the caller does not provide one;
  /// `auto` enables the built-in language detection.
  static const _autoLanguage = 'auto';

  /// First bytes of a ggml model file: the GGML container magic 0x67676d6c
  /// as stored on disk (little-endian).
  static const ggmlMagic = [0x6c, 0x6d, 0x67, 0x67];

  final WhisperModel _model;
  final String? _defaultLanguage;
  final WhisperController _controller;
  final http.Client _httpClient;

  Future<void>? _modelReady;

  static bool isValidModelFileHeader(List<int> header) {
    if (header.length < ggmlMagic.length) return false;
    for (var i = 0; i < ggmlMagic.length; i++) {
      if (header[i] != ggmlMagic[i]) return false;
    }
    return true;
  }

  @visibleForTesting
  Future<void> ensureModelReady() {
    return _modelReady ??= _prepareModel();
  }

  /// Makes sure a usable ggml model file is present on disk.
  ///
  /// The plugin's own `downloadModel` writes whatever HTTP body it receives
  /// (including error pages) straight to the model path and never re-checks
  /// the file, so the download is done here instead: the status code is
  /// verified, the payload lands in a temporary file first, and the ggml
  /// magic is validated both for pre-existing files (healing a corrupt cache)
  /// and for the fresh download before it is moved into place.
  Future<void> _prepareModel() async {
    final modelFile = File(await _controller.getPath(_model));

    if (await _isUsableModelFile(modelFile)) return;

    if (modelFile.existsSync()) {
      _logger.warning('Cached whisper model ${_model.modelName} is corrupt; re-downloading');
      modelFile.deleteSync();
    }

    final response = await _httpClient.send(http.Request('GET', _model.modelUri));
    if (response.statusCode != 200) {
      await response.stream.drain<void>();
      throw TranscriptionException('model ${_model.modelName} download failed: HTTP ${response.statusCode}');
    }

    final temporaryFile = File('${modelFile.path}.download');
    final sink = temporaryFile.openWrite();
    try {
      await sink.addStream(response.stream);
    } finally {
      await sink.close();
    }

    if (!await _isUsableModelFile(temporaryFile)) {
      temporaryFile.deleteSync();
      throw TranscriptionException('model ${_model.modelName} download returned an invalid ggml file');
    }

    temporaryFile.renameSync(modelFile.path);
  }

  Future<bool> _isUsableModelFile(File file) async {
    if (!file.existsSync()) return false;

    final randomAccessFile = await file.open();
    try {
      final header = await randomAccessFile.read(ggmlMagic.length);
      return isValidModelFileHeader(header);
    } finally {
      await randomAccessFile.close();
    }
  }

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async {
    try {
      await ensureModelReady();
    } catch (e) {
      // Reset so the next attempt retries the download instead of replaying the failure.
      _modelReady = null;
      throw TranscriptionException('failed to prepare whisper model ${_model.modelName}: $e');
    }

    final temporaryDirectory = await getTemporaryDirectory();
    final baseName = 'voicemail_transcribe_${DateTime.now().microsecondsSinceEpoch}';
    final inputFile = File('${temporaryDirectory.path}/$baseName.audio');
    final convertedFile = File('${temporaryDirectory.path}/$baseName.wav');

    try {
      await inputFile.writeAsBytes(audio, flush: true);

      final wavFile = await WhisperAudioConvert(audioInput: inputFile, audioOutput: convertedFile).convert();
      if (wavFile == null) {
        throw const TranscriptionException('audio conversion to 16kHz wav failed');
      }

      final result = await _controller.transcribe(
        model: _model,
        audioPath: wavFile.path,
        lang: language ?? _defaultLanguage ?? _autoLanguage,
      );

      final text = result?.transcription.text.trim();
      if (text == null) {
        throw const TranscriptionException('whisper transcription failed');
      }

      _logger.fine('Transcribed ${audio.length} bytes in ${result!.time.inMilliseconds}ms');
      return text;
    } finally {
      for (final file in [inputFile, convertedFile]) {
        try {
          if (file.existsSync()) file.deleteSync();
        } catch (e) {
          _logger.warning('Failed to clean up temporary file ${file.path}: $e');
        }
      }
    }
  }
}
