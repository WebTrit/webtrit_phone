import 'package:test/test.dart';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  VoicemailData createVoicemail({String id = 'vm-1', String date = '2026-01-01T00:00:00Z', bool seen = false}) {
    return VoicemailData(
      id: id,
      date: date,
      duration: 3.5,
      sender: '555001',
      receiver: '555002',
      seen: seen,
      size: 5,
      type: 'voice',
    );
  }

  group('upsertVoicemailFromRemote', () {
    test('inserts a new row', () async {
      await db.voicemailDao.upsertVoicemailFromRemote(createVoicemail());

      final row = await db.voicemailDao.getVoicemailById('vm-1');
      expect(row, isNotNull);
      expect(row!.sender, '555001');
    });

    test('updates remote fields on conflict', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail());

      await db.voicemailDao.upsertVoicemailFromRemote(createVoicemail(date: '2026-01-02T00:00:00Z', seen: true));

      final row = await db.voicemailDao.getVoicemailById('vm-1');
      expect(row!.date, '2026-01-02T00:00:00Z');
      expect(row.seen, isTrue);
    });
  });

  group('contact resolution', () {
    test('collapses colliding contacts to one deterministic row per voicemail', () async {
      await db.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('local-1'),
          firstName: Value('Local'),
          lastName: Value('Contact'),
        ),
      );
      await db.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('pbx-1'),
          firstName: Value('External'),
          lastName: Value('Contact'),
        ),
      );
      await db.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(1), number: Value('555001'), label: Value('Home')),
      );
      await db.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(2), number: Value('555001'), label: Value('Work')),
      );
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail());

      final rows = await db.voicemailDao.getVoicemailsWithContacts();

      expect(rows, hasLength(1));
      expect(rows.single.contact?.sourceType, ContactSourceTypeEnum.external);
    });
  });

  group('voicemails with transcriptions', () {
    test('joins the voicemail transcription row when present', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail());
      await db.transcriptionsDao.upsertTranscription(
        const TranscriptionData(
          mediaType: kVoicemailTranscriptionMediaType,
          mediaId: 'vm-1',
          transcript: 'hello',
          status: 'done',
        ),
      );

      final rows = await db.voicemailDao.getVoicemailsWithContacts();

      expect(rows.single.transcription?.transcript, 'hello');
      expect(rows.single.transcription?.status, 'done');
    });

    test('leaves the transcription empty when none is stored', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail());

      final rows = await db.voicemailDao.getVoicemailsWithContacts();

      expect(rows.single.transcription, isNull);
    });

    test('ignores transcriptions of other media types', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail());
      await db.transcriptionsDao.upsertTranscription(
        const TranscriptionData(mediaType: 'recording', mediaId: 'vm-1', transcript: 'other media'),
      );

      final rows = await db.voicemailDao.getVoicemailsWithContacts();

      expect(rows.single.transcription, isNull);
    });
  });
}
