import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'voicemail_dao.g.dart';

@DriftAccessor(tables: [
  VoicemailTable,
  ContactsTable,
])
class VoicemailDao extends DatabaseAccessor<AppDatabase> with _$VoicemailDaoMixin {
  VoicemailDao(super.db);

  Future<List<VoicemailData>> getAllVoicemails() => select(voicemailTable).get();

  Future<VoicemailData?> getVoicemailById(String id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertVoicemail(Insertable<VoicemailData> voicemail) => into(voicemailTable).insert(voicemail);

  Future<void> insertOrUpdateVoicemail(VoicemailData voicemail) =>
      into(voicemailTable).insertOnConflictUpdate(voicemail);

  Future<void> updateVoicemail(VoicemailDataCompanion voicemail) {
    return (update(voicemailTable)..where((tbl) => tbl.id.equals(voicemail.id.value))).write(voicemail);
  }

  Future<int> deleteVoicemail(Insertable<VoicemailData> voicemail) => delete(voicemailTable).delete(voicemail);

  Future<int> deleteVoicemailById(String id) {
    return (delete(voicemailTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAllVoicemails() => delete(voicemailTable).go();

  Stream<List<VoicemailData>> watchAllVoicemails() => select(voicemailTable).watch();

  Stream<VoicemailData?> watchVoicemailById(String id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<List<TypedResult>> getVoicemailsWithContacts() {
    final voicemail = voicemailTable;
    final contacts = db.contactsTable;

    final query = select(voicemail).join([leftOuterJoin(contacts, contacts.sourceId.equalsExp(voicemail.sender))]);
    return query.get();
  }

  Stream<List<VoicemailWithContact>> watchVoicemailsWithContacts() {
    final voicemail = voicemailTable;
    final contactPhones = db.contactPhonesTable;
    final contacts = db.contactsTable;

    final query = select(voicemail).join([
      leftOuterJoin(
        contactPhones,
        contactPhones.number.equalsExp(voicemail.sender),
      ),
      leftOuterJoin(
        contacts,
        contacts.id.equalsExp(contactPhones.contactId),
      ),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final voicemail = row.readTable(voicemailTable);
        final contact = row.readTableOrNull(contacts);
        return VoicemailWithContact(voicemail: voicemail, contact: contact);
      }).toList();
    });
  }
}

class VoicemailWithContact {
  final VoicemailData voicemail;
  final ContactData? contact;

  VoicemailWithContact({required this.voicemail, this.contact});
}
