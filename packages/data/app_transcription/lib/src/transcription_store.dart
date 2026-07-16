/// Storage delegate of the transcription pool.
///
/// The pool knows nothing about where transcriptions live: every lifecycle
/// fact is handed to this interface and the application persists it however
/// it stores transcriptions (webtrit_phone writes the drift transcriptions
/// table). Consumers observe the outcome through that storage, never through
/// the pool.
abstract interface class TranscriptionStore {
  /// The media entered processing on [engine].
  ///
  /// Returns false when the stored state says there is nothing left to do
  /// (a transcript already exists or the media is marked terminally
  /// unavailable): the pool then skips the work instead of redoing or
  /// overwriting it.
  Future<bool> saveInProgress(String mediaType, String mediaId, String engine);

  /// Processing produced [transcript] on [engine].
  Future<void> saveTranscript(String mediaType, String mediaId, String transcript, String engine);

  /// Processing failed with [error] (thrown by the audio loader or the
  /// engine). The implementation decides whether the failure is transient or
  /// terminal and stores it accordingly.
  ///
  /// Returns whether the pool should keep processing its queue; return false
  /// when every following item would fail the same way (e.g. the session is
  /// gone).
  Future<bool> saveFailure(String mediaType, String mediaId, Object error, String engine);

  /// The media was deleted and forgotten by the pool: remove its stored
  /// transcription.
  Future<void> remove(String mediaType, String mediaId);

  /// Every media object of [mediaType] was deleted: remove their stored
  /// transcriptions.
  Future<void> removeAllForType(String mediaType);

  /// A model switch invalidated every stored transcription: remove them all
  /// so consumers re-enqueue what they want regenerated.
  Future<void> removeAll();
}
