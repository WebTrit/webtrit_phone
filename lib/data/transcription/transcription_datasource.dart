import 'dart:typed_data';

/// Engine-agnostic contract for producing a text transcript from an audio payload.
///
/// Implementations decide where the work happens (on-device model, remote
/// service, etc.); consumers pass raw audio bytes and receive plain text.
abstract class TranscriptionDataSource {
  /// Transcribes [audio] and returns the recognized text.
  ///
  /// [language] is an ISO 639-1 hint; when omitted the implementation-level
  /// default (or automatic detection) is used.
  ///
  /// Throws [TranscriptionException] when the transcript cannot be produced.
  Future<String> transcribe(Uint8List audio, {String? language});
}

class TranscriptionException implements Exception {
  const TranscriptionException(this.message);

  final String message;

  @override
  String toString() => 'TranscriptionException: $message';
}
