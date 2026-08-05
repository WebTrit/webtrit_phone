import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// The whole local database as a single manageable [CacheSection].
///
/// Every table holds a locally cached copy of server- or device-side data
/// (call history, voicemail list, chats, contacts); clearing wipes all of
/// them at once and each feature re-fetches its data on the next sync.
class DatabaseCacheSection implements CacheSection {
  DatabaseCacheSection(this._appDatabase, this._cdrsLocalRepository);

  final AppDatabase _appDatabase;
  final CdrsLocalRepository _cdrsLocalRepository;

  @override
  String get id => 'database';

  @override
  String get titleL10n => 'database_Cache_title';

  @override
  String get descriptionL10n => 'database_Cache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.bytes(await _appDatabase.databaseSizeBytes());

  @override
  Future<void> clear() async {
    await _appDatabase.deleteEverything();
    await _appDatabase.vacuum();
    // The recents cubits keep fetched records in memory and would re-upsert
    // them into the just-cleared database; wiping through the repository
    // emits the event that makes them drop those copies.
    await _cdrsLocalRepository.wipeData();
  }
}
