import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());

    final contactsDao = database.contactsDao;
    final contactEmailsDao = database.contactEmailsDao;
    final contactPhonesDao = database.contactPhonesDao;

    await contactsDao.insertOnUniqueConflictUpdateContact(
      ContactDataCompanion(
        sourceType: Value(ContactSourceTypeEnum.local),
        sourceId: Value('source1'),
        firstName: Value(''),
        lastName: Value('Тарас Шевченко'),
        aliasName: Value('ТШ'),
      ),
    );

    await contactsDao.insertOnUniqueConflictUpdateContact(
      ContactDataCompanion(
        sourceType: Value(ContactSourceTypeEnum.local),
        sourceId: Value('source2'),
        firstName: Value(''),
        lastName: Value('Шевченко Кобзар'),
        aliasName: Value('ШК'),
      ),
    );

    await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
      ContactPhoneDataCompanion(
        contactId: Value(1),
        number: Value('1234567890'),
        label: Value('Home'),
      ),
    );

    await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
      ContactPhoneDataCompanion(
        contactId: Value(2),
        number: Value('1234567890'),
        label: Value('Home'),
      ),
    );

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
      ContactEmailDataCompanion(contactId: Value(1), address: Value('taras@example.com'), label: Value('Personal')),
    );

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
      ContactEmailDataCompanion(contactId: Value(2), address: Value('kobzar@example.com'), label: Value('Work')),
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('watchAllLikeContacts', () {
    test('matching "Тарас"', () async {
      final likeContactsStream = database.contactsDao.watchAllContacts(['Тарас']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.contact.firstName, '');
      expect(likeContacts.first.contact.lastName, 'Тарас Шевченко');
    });

    test('matching "шев"', () async {
      final likeContactsStream = database.contactsDao.watchAllContacts(['шев']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 2);
      expect(likeContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(likeContacts.any((contact) => contact.contact.lastName == 'Шевченко Кобзар'), isTrue);
    });

    test('all contacts', () async {
      final allContactsStream = database.contactsDao.watchAllContacts();
      final allContacts = await allContactsStream.first;

      expect(allContacts.length, 2);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Шевченко Кобзар'), isTrue);
    });
  });

  group('watchAllContactsWithPhonesAndEmailsLikeExt', () {
    test('matching "Тарас"', () async {
      final likeContactsStream = database.contactsDao.watchAllContacts(['Тарас']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.contact.firstName, '');
      expect(likeContacts.first.contact.lastName, 'Тарас Шевченко');
      expect(likeContacts.first.emails.length, 1);
      expect(likeContacts.first.emails.first.address, 'taras@example.com');
      expect(likeContacts.first.phones.length, 1);
      expect(likeContacts.first.phones.first.number, '1234567890');
    });

    test('matching "шев"', () async {
      final likeContactsStream = database.contactsDao.watchAllContacts(['шев']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 2);
      expect(likeContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(likeContacts.any((contact) => contact.contact.lastName == 'Шевченко Кобзар'), isTrue);
      expect(likeContacts.first.emails.length, 1);
      expect(likeContacts.first.emails.first.address, 'taras@example.com');
      expect(likeContacts.first.phones.length, 1);
      expect(likeContacts.first.phones.first.number, '1234567890');
    });

    test('all contacts', () async {
      final allContactsStream = database.contactsDao.watchAllContacts();
      final allContacts = await allContactsStream.first;

      expect(allContacts.length, 2);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Шевченко Кобзар'), isTrue);
    });
  });

  group('getContactByPhoneNumber', () {
    test('should return contact for existing phone number', () async {
      final fetchedContact = await database.contactsDao.getContactByPhoneNumber('1234567890');

      expect(fetchedContact, isNotNull);
      expect(fetchedContact!.phones, isNotEmpty);
      expect(fetchedContact.phones.first.number == '1234567890', isTrue);
      expect(fetchedContact.emails, isNotEmpty);
      expect(fetchedContact.emails.first.address == 'taras@example.com', isTrue);
      expect(fetchedContact.contact.lastName == 'Тарас Шевченко', isTrue);
    });

    test('should return empty list for non-existent phone number', () async {
      final fetchedContact = await database.contactsDao.getContactByPhoneNumber('0000000000');

      expect(fetchedContact, isNull);
    });
  });

  group('insertOnUniqueConflictUpdateContact', () {
    test('All contacts with phone and emails', () async {
      final contactsDao = database.contactsDao;
      final contactPhonesDao = database.contactPhonesDao;

      // Insert contacts with sourceId == null
      final contact1 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('John'),
          lastName: Value('Doe'),
          aliasName: Value('JD'),
        ),
      );

      final contact2 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
          aliasName: Value('JS'),
        ),
      );

      await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(
          contactId: Value(contact2.id),
          number: Value('1234567890'),
          label: Value('Home'),
        ),
      );

      await database.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
        ContactEmailDataCompanion(contactId: Value(contact2.id), address: Value('asd@qwe.main'), label: Value('Work')),
      );

      // Verify all fields
      final allContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 2);

      final insertedContact1 = allContacts.firstWhere((data) => data.contact.id == contact1.id);
      expect(insertedContact1.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact1.contact.sourceId, isNull);
      expect(insertedContact1.contact.firstName, 'John');
      expect(insertedContact1.contact.lastName, 'Doe');
      expect(insertedContact1.contact.aliasName, 'JD');
      expect(insertedContact1.phones, isEmpty);
      expect(insertedContact1.emails, isEmpty);

      final insertedContact2 = allContacts.firstWhere((data) => data.contact.id == contact2.id);
      expect(insertedContact2.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact2.contact.sourceId, isNull);
      expect(insertedContact2.contact.firstName, 'Jane');
      expect(insertedContact2.contact.lastName, 'Smith');
      expect(insertedContact2.contact.aliasName, 'JS');
      expect(insertedContact2.phones, hasLength(1));
      expect(insertedContact2.phones.first.number, '1234567890');
      expect(insertedContact2.emails, hasLength(1));
      expect(insertedContact2.emails.first.address, 'asd@qwe.main');
    });

    test('All contacts with sourceId == null', () async {
      final contactsDao = database.contactsDao;

      // Insert contacts with sourceId == null
      final contact1 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('John'),
          lastName: Value('Doe'),
          aliasName: Value('JD'),
        ),
      );

      final contact2 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
          aliasName: Value('JS'),
        ),
      );

      // Verify all fields
      final allContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 2);

      final insertedContact1 = allContacts.firstWhere((data) => data.contact.id == contact1.id);
      expect(insertedContact1.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact1.contact.sourceId, isNull);
      expect(insertedContact1.contact.firstName, 'John');
      expect(insertedContact1.contact.lastName, 'Doe');
      expect(insertedContact1.contact.aliasName, 'JD');

      final insertedContact2 = allContacts.firstWhere((data) => data.contact.id == contact2.id);
      expect(insertedContact2.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact2.contact.sourceId, isNull);
      expect(insertedContact2.contact.firstName, 'Jane');
      expect(insertedContact2.contact.lastName, 'Smith');
      expect(insertedContact2.contact.aliasName, 'JS');
    });

    test('All contacts with sourceId != null', () async {
      final contactsDao = database.contactsDao;

      // Insert contacts with sourceId != null
      final contact1 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source1'),
          firstName: Value('John'),
          lastName: Value('Doe'),
          aliasName: Value('JD'),
        ),
      );

      final contact2 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source2'),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
          aliasName: Value('JS'),
        ),
      );

      // Verify all fields
      final allContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 2);

      final insertedContact1 = allContacts.firstWhere((data) => data.contact.id == contact1.id);
      expect(insertedContact1.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact1.contact.sourceId, 'source1');
      expect(insertedContact1.contact.firstName, 'John');
      expect(insertedContact1.contact.lastName, 'Doe');
      expect(insertedContact1.contact.aliasName, 'JD');

      final insertedContact2 = allContacts.firstWhere((data) => data.contact.id == contact2.id);
      expect(insertedContact2.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact2.contact.sourceId, 'source2');
      expect(insertedContact2.contact.firstName, 'Jane');
      expect(insertedContact2.contact.lastName, 'Smith');
      expect(insertedContact2.contact.aliasName, 'JS');
    });

    test('Half contacts with sourceId == null and half with sourceId != null', () async {
      final contactsDao = database.contactsDao;

      // Insert mixed contacts
      final contact1 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('John'),
          lastName: Value('Doe'),
          aliasName: Value('JD'),
        ),
      );

      final contact2 = await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source1'),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
          aliasName: Value('JS'),
        ),
      );

      // Verify all fields
      final allContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(allContacts.length, 2);

      final insertedContact1 = allContacts.firstWhere((data) => data.contact.id == contact1.id);
      expect(insertedContact1.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact1.contact.sourceId, isNull);
      expect(insertedContact1.contact.firstName, 'John');
      expect(insertedContact1.contact.lastName, 'Doe');
      expect(insertedContact1.contact.aliasName, 'JD');

      final insertedContact2 = allContacts.firstWhere((data) => data.contact.id == contact2.id);
      expect(insertedContact2.contact.sourceType, ContactSourceTypeEnum.external);
      expect(insertedContact2.contact.sourceId, 'source1');
      expect(insertedContact2.contact.firstName, 'Jane');
      expect(insertedContact2.contact.lastName, 'Smith');
      expect(insertedContact2.contact.aliasName, 'JS');
    });
  });

  group('deleteContactBySourceWithCompatibility', () {
    test(' Contacts with sourceId == null', () async {
      final contactsDao = database.contactsDao;

      // Insert contacts with sourceId == null
      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('John'),
          lastName: Value('Doe'),
        ),
      );

      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
        ),
      );

      // Delete contacts
      final deletedCount = await contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, null);

      // Verify deletion
      expect(deletedCount, 2);
      final remainingContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(remainingContacts, isEmpty);
    });

    test('Contacts with sourceId != null', () async {
      final contactsDao = database.contactsDao;

      // Insert contacts with sourceId != null
      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source1'),
          firstName: Value('John'),
          lastName: Value('Doe'),
        ),
      );

      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source2'),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
        ),
      );

      // Delete contacts with specific sourceId
      final deletedCount1 = await contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, 'source1');

      // Verify partial deletion
      expect(deletedCount1, 1);
      final remainingContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(remainingContacts.length, 1);
      expect(remainingContacts.first.contact.sourceId, 'source2');

      // Delete remaining contacts
      final deletedCount2 = await contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, 'source2');

      // Verify complete deletion
      expect(deletedCount2, 1);
      final finalContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(finalContacts, isEmpty);
    });

    test('Half contacts with sourceId == null and half with sourceId != null', () async {
      final contactsDao = database.contactsDao;

      // Insert mixed contacts
      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value(null),
          firstName: Value('John'),
          lastName: Value('Doe'),
        ),
      );

      await contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('source1'),
          firstName: Value('Jane'),
          lastName: Value('Smith'),
        ),
      );

      // Delete contacts with sourceId == null
      final deletedCount1 = await contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, null);

      // Verify partial deletion
      expect(deletedCount1, 1);
      final remainingContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(remainingContacts.length, 1);
      expect(remainingContacts.first.contact.sourceId, 'source1');

      // Delete contacts with sourceId != null
      final deletedCount2 = await contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, 'source1');

      // Verify complete deletion
      expect(deletedCount2, 1);
      final finalContacts = await contactsDao.getAllContacts(ContactSourceTypeEnum.external);
      expect(finalContacts, isEmpty);
    });
  });

  group('ContactKind Tests', () {
    test('Contact defaults to ContactKind.visible when kind is not provided', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          lastName: Value('Gail'),
        ),
      );

      final currentContacts = await database.contactsDao.getAllContacts(null);

      expect(currentContacts.length, initialVisibleCount + 1);

      final newContact = currentContacts.firstWhere((c) => c.contact.firstName == 'Abi');
      expect(newContact.contact.kind, ContactKind.visible);
    });

    test('getAllContacts filters based on kind', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          lastName: Value('Gail'),
          kind: Value(ContactKind.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Davis'),
          lastName: Value('Charles'),
          kind: Value(ContactKind.service),
        ),
      );

      final visibleContacts = await database.contactsDao.getAllContacts(null);
      expect(visibleContacts.length, initialVisibleCount + 1);
      expect(visibleContacts.first.contact.firstName, 'Abi');
      expect(visibleContacts.first.contact.kind, ContactKind.visible);

      final serviceContacts = await database.contactsDao.getAllContacts(null, kind: ContactKind.service);
      expect(serviceContacts.length, 1);
      expect(serviceContacts.first.contact.firstName, 'Davis');
      expect(serviceContacts.first.contact.kind, ContactKind.service);
    });

    test('getServiceContacts returns only service contacts', () async {
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          kind: Value(ContactKind.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          firstName: Value('Davis'),
          kind: Value(ContactKind.service),
        ),
      );

      final result = await database.contactsDao.getServiceContacts();

      expect(result.length, 1);

      expect(result.first.contact.firstName, 'Davis');
      expect(result.first.contact.kind, ContactKind.service);
    });

    test('getServiceContacts returns only visible contacts', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null, kind: ContactKind.visible);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          lastName: Value('Gail'),
          kind: Value(ContactKind.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Davis'),
          lastName: Value('Charles'),
          kind: Value(ContactKind.service),
        ),
      );

      final result = await database.contactsDao.getAllContacts(null, kind: ContactKind.visible);

      expect(result.length, initialVisibleCount + 1);

      expect(result.any((c) => c.contact.firstName == 'Abi'), isTrue);
      expect(result.any((c) => c.contact.firstName == 'Davis'), isFalse);
    });

    test('watchAllContacts respects kind parameter', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null, kind: ContactKind.visible);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Wilson'),
          kind: Value(ContactKind.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Moore'),
          kind: Value(ContactKind.service),
        ),
      );

      final visibleStream = database.contactsDao.watchAllContacts();
      final visibleList = await visibleStream.first;

      expect(visibleList.length, initialVisibleCount + 1);
      expect(visibleList.first.contact.firstName, 'Wilson');

      final serviceStream = database.contactsDao.watchAllContacts(null, null, ContactKind.service);
      final serviceList = await serviceStream.first;

      expect(serviceList.length, 1);
      expect(serviceList.first.contact.firstName, 'Moore');
    });

    test('Service contacts persist phones and emails correctly', () async {
      final dao = database.contactsDao;

      final contact = await dao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Harris'),
          kind: Value(ContactKind.service),
        ),
      );

      await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(
          contactId: Value(contact.id),
          number: Value('911'),
          label: Value('Emergency'),
        ),
      );

      final fetched = await dao.getServiceContacts();

      expect(fetched.length, 1);
      expect(fetched.first.phones.length, 1);
      expect(fetched.first.phones.first.number, '911');
    });
  });
}
