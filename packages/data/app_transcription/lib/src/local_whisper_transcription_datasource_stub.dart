import 'dart:typed_data';

import 'transcription_datasource.dart';

/// Stub for platforms without FFI support (web); local Whisper is unavailable there.
class LocalWhisperTranscriptionDataSource implements TranscriptionDataSource {
  LocalWhisperTranscriptionDataSource({String model = 'base', String? defaultLanguage});

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) {
    throw const TranscriptionException('local whisper transcription is not supported on this platform');
  }
}
