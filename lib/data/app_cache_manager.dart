import 'package:collection/collection.dart';

import 'package:webtrit_phone/models/models.dart';

/// Registry of the app's manageable cache sections.
///
/// Features register a [CacheSection] here; cache management UI reads the
/// registry to size and clear the individual slices.
class AppCacheManager {
  AppCacheManager({required List<CacheSection> sections}) : sections = List.unmodifiable(sections);

  final List<CacheSection> sections;

  /// The registered section with the given [id], or null when the section is
  /// unavailable (e.g. its feature does not cache on this platform).
  CacheSection? section(String id) => sections.firstWhereOrNull((section) => section.id == id);
}
