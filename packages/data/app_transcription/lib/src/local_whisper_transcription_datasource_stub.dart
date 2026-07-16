import 'dart:typed_data';

import 'transcription_datasource.dart';

/// Stub for platforms without FFI support (web); local Whisper is unavailable there.
class LocalWhisperTranscriptionDataSource extends TranscriptionDataSource {
  LocalWhisperTranscriptionDataSource({String model = 'base', String? defaultLanguage}) : modelName = model;

  /// Name of the whisper model tier this source runs.
  final String modelName;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) {
    throw const TranscriptionException('local whisper transcription is not supported on this platform');
  }

  @override
  String get engine => 'unsupported';

  /// Local models never exist on platforms without FFI support.
  static Future<bool> isModelDownloaded(String model) async => false;

  /// No model files can exist on platforms without FFI support.
  static Future<int> downloadedModelsSizeBytes() async => 0;

  static Future<void> deleteDownloadedModels() async {}

  @override
  void dispose() {}
}
