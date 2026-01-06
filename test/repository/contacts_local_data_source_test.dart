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
        final contact = ContactsFixtureFactory.createExternalContact(id: '1', number: '1001', ext: '2001');

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

        final emails = dbContact.emails;
        expect(emails.length, 1);
        expect(emails.first.address, contact.email);
      });

      test('updates existing contact and replaces phones', () async {
        final contactInitial = ContactsFixtureFactory.createExternalContact(id: '1', number: '1001', ext: '2001');
        await dataSource.upsertContact(contactInitial, ContactKind.visible);

        final dbContactInitial = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');
        expect(dbContactInitial!.phones.length, 2);

        final contactUpdated = ContactsFixtureFactory.createExternalContact(id: '1', number: '9999');

        await dataSource.upsertContact(contactUpdated, ContactKind.visible);

        final dbContact = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');

        expect(dbContact!.phones.length, 1);
        expect(dbContact.phones.first.number, '9999');
      });

      test('does not create duplicate phone if ext equals number', () async {
        final contact = ContactsFixtureFactory.createExternalContact(id: '1', number: '1001', ext: '1001');

        await dataSource.upsertContact(contact, ContactKind.visible);

        final dbContact = await appDatabase.contactsDao.getContactBySource(ContactSourceTypeEnum.external, '1');

        expect(dbContact!.phones.length, 1);
        expect(dbContact.phones.first.label, kContactMainLabel);
      });
    });

    group('syncExternalContacts', () {
      test('inserts multiple contacts correctly with details', () async {
        final contacts = [
          ContactsFixtureFactory.createExternalContact(id: '1', number: '1001', email: 'user1@test.com'),
          ContactsFixtureFactory.createExternalContact(id: '2', number: '1002', email: 'user2@test.com'),
        ];

        await dataSource.syncExternalContacts(contacts);

        final allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 2);

        final contact1 = allContacts.firstWhere((c) => c.contact.sourceId == '1');
        expect(contact1.phones.any((p) => p.number == '1001'), isTrue);
        expect(contact1.emails.first.address, 'user1@test.com');

        final contact2 = allContacts.firstWhere((c) => c.contact.sourceId == '2');
        expect(contact2.phones.any((p) => p.number == '1002'), isTrue);
        expect(contact2.emails.first.address, 'user2@test.com');
      });

      test('deletes contacts not present in the new list', () async {
        await dataSource.syncExternalContacts([
          ContactsFixtureFactory.createExternalContact(id: '1'),
          ContactsFixtureFactory.createExternalContact(id: '2'),
          ContactsFixtureFactory.createExternalContact(id: '3'),
        ]);

        var allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 3);

        await dataSource.syncExternalContacts([
          ContactsFixtureFactory.createExternalContact(id: '1'),
          ContactsFixtureFactory.createExternalContact(id: '3'),
        ]);

        allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
        expect(allContacts.length, 2);
        expect(allContacts.any((c) => c.contact.sourceId == '2'), isFalse);
      });
    });

    group('syncLocalContacts', () {
      test('syncs local contacts with full replacement logic', () async {
        await dataSource.syncLocalContacts([
          ContactsFixtureFactory.createLocalContact(id: '1'),
          ContactsFixtureFactory.createLocalContact(id: '2'),
        ]);

        var stored = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.local);
        expect(stored.length, 2);

        final l1Updated = ContactsFixtureFactory.createLocalContact(
          id: '1',
          phones: [LocalContactPhone(number: '999999', label: 'work')],
        );

        await dataSource.syncLocalContacts([l1Updated, ContactsFixtureFactory.createLocalContact(id: '3')]);

        stored = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.local);
        expect(stored.length, 2);

        expect(stored.any((c) => c.contact.sourceId == '2'), isFalse);

        final l1 = stored.firstWhere((c) => c.contact.sourceId == '1');
        expect(l1.phones.first.number, '999999');
      });
    });

    test('correctly handles contacts with null ID (relies on safeSourceId)', () async {
      // id defaults to null, but we pass number explicitly
      // so safeSourceId can generate a stable ID
      final contactNoId = ContactsFixtureFactory.createExternalContact(id: null, number: 'unique_number_1');

      await dataSource.syncExternalContacts([contactNoId]);

      var allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 1);
      expect(allContacts.first.contact.sourceId, 'number_unique_number_1');

      // Subsequent sync to verify no duplicates are created and ID persistence works
      await dataSource.syncExternalContacts([contactNoId]);

      allContacts = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 1);
      expect(allContacts.first.contact.sourceId, 'number_unique_number_1');
    });
  });
}
