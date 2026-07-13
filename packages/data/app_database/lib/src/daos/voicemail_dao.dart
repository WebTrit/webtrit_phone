import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'voicemail_dao.g.dart';

@DriftAccessor(tables: [VoicemailTable, ContactsTable])
class VoicemailDao extends DatabaseAccessor<AppDatabase> with _$VoicemailDaoMixin {
  VoicemailDao(super.db);

  Future<List<VoicemailData>> getAllVoicemails() => select(voicemailTable).get();

  Future<VoicemailData?> getVoicemailById(String id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertVoicemail(Insertable<VoicemailData> voicemail) => into(voicemailTable).insert(voicemail);

  Future<void> insertOrUpdateVoicemail(VoicemailData voicemail) =>
      into(voicemailTable).insertOnConflictUpdate(voicemail);

  /// Upserts a voicemail coming from the remote payload without touching the
  /// locally produced transcript columns on conflict: the remote payload never
  /// carries transcripts, and a read-then-write merge would race concurrent
  /// transcription writes and could overwrite a finished transcript.
  Future<void> upsertVoicemailFromRemote(VoicemailData voicemail) {
    return into(voicemailTable).insert(
      voicemail,
      onConflict: DoUpdate(
        (old) => VoicemailDataCompanion(
          date: Value(voicemail.date),
          duration: Value(voicemail.duration),
          sender: Value(voicemail.sender),
          receiver: Value(voicemail.receiver),
          seen: Value(voicemail.seen),
          size: Value(voicemail.size),
          type: Value(voicemail.type),
          attachmentPath: Value(voicemail.attachmentPath),
        ),
      ),
    );
  }

  Future<void> updateVoicemail(VoicemailDataCompanion voicemail) {
    return (update(voicemailTable)..where((tbl) => tbl.id.equals(voicemail.id.value))).write(voicemail);
  }

  Future<int> deleteVoicemail(Insertable<VoicemailData> voicemail) => delete(voicemailTable).delete(voicemail);

  Future<int> deleteVoicemailById(String id) {
    return (delete(voicemailTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAllVoicemails() => delete(voicemailTable).go();

  Future<int> recordsCount() async {
    final query = selectOnly(voicemailTable)..addColumns([countAll()]);
    return query.map((row) => row.read(countAll()) ?? 0).getSingle();
  }

  Stream<List<VoicemailData>> watchAllVoicemails() => select(voicemailTable).watch();

  Stream<VoicemailData?> watchVoicemailById(String id) {
    return (select(voicemailTable)..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<List<VoicemailWithContact>> getVoicemailsWithContacts() async {
    final rows = await _voicemailsWithContactsQuery().get();
    return rows.map(_voicemailWithContactFromRow).toList();
  }

  Stream<List<VoicemailWithContact>> watchVoicemailsWithContacts() {
    return _voicemailsWithContactsQuery().watch().map((rows) => rows.map(_voicemailWithContactFromRow).toList());
  }

  JoinedSelectStatement _voicemailsWithContactsQuery() {
    final voicemail = voicemailTable;
    final contactPhones = db.contactPhonesTable;
    final contacts = db.contactsTable;
    final transcriptions = db.transcriptionTable;

    return select(voicemail).join([
      leftOuterJoin(contactPhones, contactPhones.number.equalsExp(voicemail.sender)),
      leftOuterJoin(contacts, contacts.id.equalsExp(contactPhones.contactId)),
      leftOuterJoin(
        transcriptions,
        transcriptions.mediaType.equals(kVoicemailTranscriptionMediaType) &
            transcriptions.mediaId.equalsExp(voicemail.id),
      ),
    ]);
  }

  VoicemailWithContact _voicemailWithContactFromRow(TypedResult row) {
    return VoicemailWithContact(
      voicemail: row.readTable(voicemailTable),
      contact: row.readTableOrNull(db.contactsTable),
      transcription: row.readTableOrNull(db.transcriptionTable),
    );
  }
}

/// The [TranscriptionTable.mediaType] value owned by voicemails.
const kVoicemailTranscriptionMediaType = 'voicemail';

class VoicemailWithContact {
  final VoicemailData voicemail;
  final ContactData? contact;
  final TranscriptionData? transcription;

  VoicemailWithContact({required this.voicemail, this.contact, this.transcription});
}
