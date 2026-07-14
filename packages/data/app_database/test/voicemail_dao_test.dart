import 'package:test/test.dart';

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

  VoicemailData createVoicemail({String id = 'vm-1'}) {
    return VoicemailData(
      id: id,
      date: '2026-01-01T00:00:00Z',
      duration: 3.5,
      sender: '555001',
      receiver: '555002',
      seen: false,
      size: 5,
      type: 'voice',
    );
  }

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
}
