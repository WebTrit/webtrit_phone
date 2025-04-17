import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'voicemail_dao.g.dart';

@DriftAccessor(tables: [
  VoicemailTable,
])
class VoicemailDao extends DatabaseAccessor<AppDatabase> with _$VoicemailDaoMixin {
  VoicemailDao(super.db);

  Future<List<VoicemailData>> getAllVoicemails() => select(voicemailTable).get();

  Future<VoicemailData?> getVoicemailById(int id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertVoicemail(Insertable<VoicemailData> voicemail) => into(voicemailTable).insert(voicemail);

  Future<void> insertOrUpdateVoicemail(VoicemailData voicemail) =>
      into(voicemailTable).insertOnConflictUpdate(voicemail);

  Future<bool> updateVoicemail(Insertable<VoicemailData> voicemail) => update(voicemailTable).replace(voicemail);

  Future<int> deleteVoicemail(Insertable<VoicemailData> voicemail) => delete(voicemailTable).delete(voicemail);

  Future<int> deleteVoicemailById(int id) {
    return (delete(voicemailTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAllVoicemails() => delete(voicemailTable).go();

  Stream<List<VoicemailData>> watchAllVoicemails() => select(voicemailTable).watch();

  Stream<VoicemailData?> watchVoicemailById(int id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }
}
