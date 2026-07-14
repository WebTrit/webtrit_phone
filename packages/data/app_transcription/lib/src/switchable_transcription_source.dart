import 'transcription_datasource.dart';

/// Builds a transcription source for the given local model tier override
/// (null keeps the configured default); returns null when the feature is
/// disabled or misconfigured.
typedef TranscriptionDataSourceBuilder = TranscriptionDataSource? Function(String? localModelOverride);

/// The active transcription source together with the ability to rebuild it
/// when the user overrides the local model tier.
///
/// Provided session-wide in the main shell: any feature can transcribe media
/// through [current], and a model switch applies to all of them at once.
class SwitchableTranscriptionSource {
  /// Builds the initial source for [initialLocalModel] and rebuilds it on
  /// every [switchLocalModel] call.
  SwitchableTranscriptionSource(TranscriptionDataSourceBuilder builder, {String? initialLocalModel})
    : _builder = builder,
      _current = builder(initialLocalModel);

  /// A fixed source that cannot switch models.
  SwitchableTranscriptionSource.fixed(this._current) : _builder = null;

  final TranscriptionDataSourceBuilder? _builder;
  TranscriptionDataSource? _current;

  /// The source transcribing right now; null while transcription is disabled.
  TranscriptionDataSource? get current => _current;

  /// Rebuilds the source for [localModelOverride] and disposes the previous
  /// one (a transcription in flight on it fails transiently and is retried
  /// by the caller's follow-up sweep). Returns false, doing nothing, when
  /// switching is not supported.
  bool switchLocalModel(String? localModelOverride) {
    final builder = _builder;
    if (builder == null) return false;

    final previous = _current;
    _current = builder(localModelOverride);
    previous?.dispose();
    return true;
  }

  /// Releases the active source; [current] is null afterwards and the object
  /// must not be used again.
  void dispose() {
    _current?.dispose();
    _current = null;
  }
}
