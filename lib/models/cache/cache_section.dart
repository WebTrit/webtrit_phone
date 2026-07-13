/// One manageable slice of the app's local cache (e.g. voicemail audio).
///
/// Features expose their disk caches through this contract so cache
/// management UI can size and clear them without knowing where or how the
/// data is stored.
abstract class CacheSection {
  /// Stable identifier of the slice (e.g. 'voicemail').
  String get id;

  /// Localization key of the human-readable section name.
  String get titleL10n;

  /// Localization key describing what the section caches and what clearing
  /// it means for the user.
  String get descriptionL10n;

  /// Total size in bytes of the section's cached data.
  Future<int> totalSizeBytes();

  /// Deletes the section's cached data; it is rebuilt on demand.
  Future<void> clear();
}
