import 'package:drift/drift.dart' hide isNull;
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

  // Insert a local AND an external contact that share the SAME number, so the
  // sourcePriorityOrder tie-break has a real collision to resolve.
  Future<void> seedCollision({required bool localFirst}) async {
    final contactsDao = database.contactsDao;
    final phonesDao = database.contactPhonesDao;

    Future<void> addLocal() async {
      final c = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('local-4'),
          aliasName: Value('Local 4'),
        ),
      );
      await phonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(c.id), number: Value('4'), label: Value('mobile')),
      );
    }

    Future<void> addExternal() async {
      final c = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('ext-4'),
          aliasName: Value('PBX 4'),
        ),
      );
      await phonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(c.id), number: Value('4'), label: Value('ext')),
      );
    }

    if (localFirst) {
      await addLocal();
      await addExternal();
    } else {
      await addExternal();
      await addLocal();
    }
  }

  // Run a minimal number lookup that applies only the tie-break ordering, so the
  // assertion isolates sourcePriorityOrder() and nothing else.
  Future<ContactSourceTypeEnum?> winningSource([ContactSourcePreference? preference]) async {
    final contacts = database.contactsTable;
    final phones = database.contactPhonesTable;

    final query = database.select(contacts).join([innerJoin(phones, phones.contactId.equalsExp(contacts.id))])
      ..where(phones.number.equals('4'))
      ..orderBy(preference == null ? contacts.sourcePriorityOrder() : contacts.sourcePriorityOrder(preference))
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row?.readTable(contacts).sourceType;
  }

  group('sourcePriorityOrder', () {
    for (final localFirst in [true, false]) {
      test('defaults to external-first (insertion local-first=$localFirst)', () async {
        await seedCollision(localFirst: localFirst);
        expect(await winningSource(), ContactSourceTypeEnum.external);
      });

      test('externalFirst prefers external (insertion local-first=$localFirst)', () async {
        await seedCollision(localFirst: localFirst);
        expect(await winningSource(ContactSourcePreference.externalFirst), ContactSourceTypeEnum.external);
      });

      test('localFirst prefers local (insertion local-first=$localFirst)', () async {
        await seedCollision(localFirst: localFirst);
        expect(await winningSource(ContactSourcePreference.localFirst), ContactSourceTypeEnum.local);
      });
    }

    test('returns null when no contact carries the number', () async {
      expect(await winningSource(), isNull);
    });
  });
}
