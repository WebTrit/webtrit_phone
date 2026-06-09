import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  // A period large enough that the recents 14-day window never filters test rows.
  const allTime = Duration(days: 36500);

  Future<void> addLocalContact(String number) async {
    final c = await database.contactsDao.insertOnUniqueConflictUpdateContact(
      ContactDataCompanion(
        sourceType: Value(ContactSourceTypeEnum.local),
        sourceId: Value('local-$number'),
        aliasName: Value('Local $number'),
      ),
    );
    await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
      ContactPhoneDataCompanion(contactId: Value(c.id), number: Value(number), label: Value('mobile')),
    );
  }

  Future<void> addExternalContact(String number) async {
    final c = await database.contactsDao.insertOnUniqueConflictUpdateContact(
      ContactDataCompanion(
        sourceType: Value(ContactSourceTypeEnum.external),
        sourceId: Value('ext-$number'),
        aliasName: Value('PBX $number'),
      ),
    );
    await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
      ContactPhoneDataCompanion(contactId: Value(c.id), number: Value(number), label: Value('ext')),
    );
  }

  Future<int> addCallLog(String number, DateTime createdAt) {
    return database.callLogsDao.insertCallLog(
      CallLogDataCompanion(
        direction: Value(CallLogDirectionEnum.outgoing),
        number: Value(number),
        video: Value(false),
        createdAt: Value(createdAt),
      ),
    );
  }

  group('recents contact source priority (local vs external collision)', () {
    for (final localFirst in [true, false]) {
      test('watchLastRecents prefers external (insertion local-first=$localFirst)', () async {
        if (localFirst) {
          await addLocalContact('4');
          await addExternalContact('4');
        } else {
          await addExternalContact('4');
          await addLocalContact('4');
        }
        await addCallLog('4', DateTime(2026, 6, 1));

        final recents = await database.recentsDao.watchLastRecents(allTime).first;

        expect(recents, hasLength(1));
        expect(recents.single.contactData, isNotNull);
        expect(recents.single.contactData!.sourceType, ContactSourceTypeEnum.external);
        expect(recents.single.contactData!.aliasName, 'PBX 4');
      });

      test('getRecentByCallId prefers external (insertion local-first=$localFirst)', () async {
        if (localFirst) {
          await addLocalContact('4');
          await addExternalContact('4');
        } else {
          await addExternalContact('4');
          await addLocalContact('4');
        }
        final id = await addCallLog('4', DateTime(2026, 6, 1));

        final recent = await database.recentsDao.getRecentByCallId(id);

        expect(recent.contactData, isNotNull);
        expect(recent.contactData!.sourceType, ContactSourceTypeEnum.external);
        expect(recent.contactData!.aliasName, 'PBX 4');
      });
    }

    test('watchLastRecents keeps newest-first order (tie-break must not reorder the list)', () async {
      await addExternalContact('4');
      await addLocalContact('4');
      final oldId = await addCallLog('4', DateTime(2026, 5, 1));
      final newId = await addCallLog('4', DateTime(2026, 6, 1));

      final recents = await database.recentsDao.watchLastRecents(allTime).first;

      expect(recents.map((r) => r.callLogEntry.id).toList(), [newId, oldId]);
    });

    test('non-colliding numbers still resolve to their single contact', () async {
      await addLocalContact('5'); // local only
      await addExternalContact('6'); // external only
      await addCallLog('5', DateTime(2026, 6, 1));
      await addCallLog('6', DateTime(2026, 6, 2));

      final recents = await database.recentsDao.watchLastRecents(allTime).first;
      final sourceByNumber = {for (final r in recents) r.callLogEntry.number: r.contactData?.sourceType};

      expect(sourceByNumber['5'], ContactSourceTypeEnum.local);
      expect(sourceByNumber['6'], ContactSourceTypeEnum.external);
    });
  });
}
