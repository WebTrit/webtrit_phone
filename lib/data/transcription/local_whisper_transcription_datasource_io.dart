import 'dart:io';
import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whisper_ggml/whisper_ggml.dart';

import 'transcription_datasource.dart';

final _logger = Logger('LocalWhisperTranscriptionDataSource');

/// On-device Whisper transcription backed by `whisper_ggml` (whisper.cpp).
///
/// The ggml model is downloaded on first use and cached by the plugin, so the
/// first transcription may take noticeably longer than the following ones.
/// Incoming audio is converted to the 16 kHz mono WAV expected by Whisper
/// before recognition (voicemail audio is telephony 8 kHz).
class LocalWhisperTranscriptionDataSource implements TranscriptionDataSource {
  LocalWhisperTranscriptionDataSource({String model = 'base', String? defaultLanguage, WhisperController? controller})
    : _model = WhisperModel.values.firstWhere((value) => value.modelName == model, orElse: () => WhisperModel.base),
      _defaultLanguage = defaultLanguage,
      _controller = controller ?? WhisperController();

  /// Language passed to Whisper when the caller does not provide one;
  /// `auto` enables the built-in language detection.
  static const _autoLanguage = 'auto';

  final WhisperModel _model;
  final String? _defaultLanguage;
  final WhisperController _controller;

  Future<void>? _modelReady;

  Future<void> _ensureModelReady() {
    return _modelReady ??= _controller.downloadModel(_model).then((_) {});
  }

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async {
    try {
      await _ensureModelReady();
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
