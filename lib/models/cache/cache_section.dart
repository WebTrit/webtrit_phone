import 'package:equatable/equatable.dart';

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

  /// Measures the section's current cache usage.
  Future<CacheUsage> usage();

  /// Deletes the section's cached data; it is rebuilt on demand.
  Future<void> clear();
}

/// Measured usage of a [CacheSection]: file-based caches report bytes on
/// disk, database-backed ones report stored records.
class CacheUsage extends Equatable {
  const CacheUsage.bytes(this.amount) : unit = CacheUsageUnit.bytes;

  const CacheUsage.items(this.amount) : unit = CacheUsageUnit.items;

  final int amount;
  final CacheUsageUnit unit;

  @override
  List<Object?> get props => [amount, unit];
}

enum CacheUsageUnit { bytes, items }
