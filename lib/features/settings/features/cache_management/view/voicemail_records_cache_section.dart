import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

/// The locally stored voicemail messages as a manageable [CacheSection].
///
/// The records are a cached copy of the server-side voicemail list (the audio
/// files live in the separate voicemail audio section); clearing them only
/// frees the local database, the list is fetched again on the next refresh.
class VoicemailRecordsCacheSection implements CacheSection {
  VoicemailRecordsCacheSection(this._appDatabase);

  final AppDatabase _appDatabase;

  @override
  String get id => 'voicemailRecords';

  @override
  String get titleL10n => 'voicemail_RecordsCache_title';

  @override
  String get descriptionL10n => 'voicemail_RecordsCache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.items(await _appDatabase.voicemailDao.recordsCount());

  @override
  Future<void> clear() => _appDatabase.voicemailDao.deleteAllVoicemails();
}
