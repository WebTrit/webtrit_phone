import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';

void main() {
  late AppDatabase appDatabase;
  late ContactsLocalDataSourceImpl dataSource;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    dataSource = ContactsLocalDataSourceImpl(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group('ContactsLocalDataSource', () {
    group('upsertContact', () {
      test('inserts new external contact with phones and emails', () async {
        final contact = ContactsFixtureFactory.createExternalContact(1, number: '1001', ext: '2001');

        await dataSource.upsertContact(contact, ContactKind.visible);

        final dbContact = await appDatabase.contactsDao.getContactBySource(
          ContactSourceTypeEnum.external,
          contact.safeSourceId,
        );

        expect(dbContact, isNotNull);
        expect(dbContact!.contact.sourceId, contact.id);

        final phones = dbContact.phones;
        expect(phones.length, 2);
        expect(phones.any((p) => p.number == '1001' && p.label == kContactMainLabel), isTrue);
        expect(phones.any((p) => p.number == '2001' && p.label == kContactExtLabel), isTrue);
      });

      test('updates existing contact and replaces phones', () async {
        // Create a contact explicitly with an extension
        final contactInitial = ContactsFixtureFactory.createExternalContact(1, number: '1001', ext: '2001');
        await dataSource.upsertContact(contactInitial, ContactKind.visible);

        // Verify that 2 phones were created (main + ext)
        final dbContactInitial = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');
        expect(dbContactInitial!.phones.length, 2);

        // Update: omit 'ext' so it defaults to null in the factory
        final contactUpdated = ContactsFixtureFactory.createExternalContact(
          1,
          number: '9999',
          // ext is not passed, so it is null
        );

        await dataSource.upsertContact(contactUpdated, ContactKind.visible);

        final dbContact = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');

        // Expect 1 phone because ext was null in the update, removing the old ext record
        expect(dbContact!.phones.length, 1);
        expect(dbContact.phones.first.number, '9999');
      });

      test('does not create duplicate phone if ext equals number', () async {
        final contact = ContactsFixtureFactory.createExternalContact(1, number: '1001', ext: '1001');

        await dataSource.upsertContact(contact, ContactKind.visible);

        final dbContact = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');

        expect(dbContact!.phones.length, 1);
        expect(dbContact.phones.first.label, kContactMainLabel);
      });
    });

    group('syncExternalContacts', () {
      test('inserts multiple contacts correctly', () async {
        final contacts = [
          ContactsFixtureFactory.createExternalContact(1),
          ContactsFixtureFactory.createExternalContact(2),
        ];

        await dataSource.syncExternalContacts(contacts);

        final allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 2);
      });

      test('deletes contacts not present in the new list', () async {
        await dataSource.syncExternalContacts([
          ContactsFixtureFactory.createExternalContact(1),
          ContactsFixtureFactory.createExternalContact(2),
          ContactsFixtureFactory.createExternalContact(3),
        ]);

        var allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 3);

        // Sync with contact #2 removed
        await dataSource.syncExternalContacts([
          ContactsFixtureFactory.createExternalContact(1),
          ContactsFixtureFactory.createExternalContact(3),
        ]);

        allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 2);
        // Ensure "2" (the ID generated for index 2) is gone
        expect(allContacts.any((c) => c.contact.sourceId == '2'), isFalse);
      });
    });

    group('syncLocalContacts', () {
      test('syncs local contacts with full replacement logic', () async {
        await dataSource.syncLocalContacts([
          ContactsFixtureFactory.createLocalContact(1),
          ContactsFixtureFactory.createLocalContact(2),
        ]);

        var stored = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.local);
        expect(stored.length, 2);

        // Update list: Remove #2, Update #1 details, Add #3
        final l1Updated = ContactsFixtureFactory.createLocalContact(
          1,
          phones: [LocalContactPhone(number: '999999', label: 'work')],
        );

        await dataSource.syncLocalContacts([l1Updated, ContactsFixtureFactory.createLocalContact(3)]);

        stored = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.local);
        expect(stored.length, 2);

        // Verify #2 is gone (ID: local_2)
        expect(stored.any((c) => c.contact.sourceId == 'local_2'), isFalse);

        // Verify #1 updated
        final l1 = stored.firstWhere((c) => c.contact.sourceId == 'local_1');
        expect(l1.phones.first.number, '999999');
      });
    });
  });
}
