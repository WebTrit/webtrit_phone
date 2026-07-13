import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// The locally stored call history (CDRs) as a manageable [CacheSection].
///
/// The records are a cached copy of the server-side call history; clearing
/// them only frees the local database, the history is fetched again by the
/// next sync.
class CdrsCacheSection implements CacheSection {
  CdrsCacheSection(this._cdrsLocalRepository);

  final CdrsLocalRepository _cdrsLocalRepository;

  @override
  String get id => 'cdrs';

  @override
  String get titleL10n => 'cdrs_Cache_title';

  @override
  String get descriptionL10n => 'cdrs_Cache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.items(await _cdrsLocalRepository.recordsCount());

  @override
  Future<void> clear() => _cdrsLocalRepository.wipeData();
}
