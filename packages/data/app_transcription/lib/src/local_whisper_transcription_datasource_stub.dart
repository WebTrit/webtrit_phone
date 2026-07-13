import 'dart:typed_data';

import 'transcription_datasource.dart';

/// Stub for platforms without FFI support (web); local Whisper is unavailable there.
class LocalWhisperTranscriptionDataSource implements TranscriptionDataSource {
  LocalWhisperTranscriptionDataSource({String model = 'base', String? defaultLanguage}) : modelName = model;

  /// Name of the whisper model tier this source runs.
  final String modelName;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) {
    throw const TranscriptionException('local whisper transcription is not supported on this platform');
  }

  @override
  void dispose() {}
}
