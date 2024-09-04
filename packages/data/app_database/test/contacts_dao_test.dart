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

    await contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
      sourceType: Value(ContactSourceTypeEnum.local),
      sourceId: Value('source1'),
      firstName: Value(''),
      lastName: Value('Тарас Шевченко'),
      aliasName: Value('ТШ'),
    ));

    await contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
      sourceType: Value(ContactSourceTypeEnum.local),
      sourceId: Value('source2'),
      firstName: Value(''),
      lastName: Value('Шевченко Кобзар'),
      aliasName: Value('ШК'),
    ));

    await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
      contactId: Value(1),
      number: Value('1234567890'),
      label: Value('Home'),
    ));

    await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
      contactId: Value(2),
      number: Value('1234567890'),
      label: Value('Home'),
    ));

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
      contactId: Value(1),
      address: Value('taras@example.com'),
      label: Value('Personal'),
    ));

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
      contactId: Value(2),
      address: Value('kobzar@example.com'),
      label: Value('Work'),
    ));
  });

  tearDown(() async {
    await database.close();
  });

  group('watchAllLikeContacts', () {
    test('matching "Тарас"', () async {
      final likeContactsStream = database.contactsDao.watchAllLikeContacts(['Тарас']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.firstName, '');
      expect(likeContacts.first.lastName, 'Тарас Шевченко');
    });

    test('matching "шев"', () async {
      final likeContactsStream = database.contactsDao.watchAllLikeContacts(['шев']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 2);
      expect(likeContacts.any((contact) => contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(likeContacts.any((contact) => contact.lastName == 'Шевченко Кобзар'), isTrue);
    });

    test('all contacts', () async {
      final allContactsStream = database.contactsDao.watchAllContacts();
      final allContacts = await allContactsStream.first;

      expect(allContacts.length, 2);
      expect(allContacts.any((contact) => contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(allContacts.any((contact) => contact.lastName == 'Шевченко Кобзар'), isTrue);
    });
  });

  group('watchAllContactsWithPhonesAndEmailsLikeExt', () {
    test('matching "Тарас"', () async {
      final likeContactsStream = database.contactsDao.watchAllContactsExt(['Тарас']);
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
      final likeContactsStream = database.contactsDao.watchAllContactsExt(['шев']);
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
      final allContactsStream = database.contactsDao.watchAllContactsExt();
      final allContacts = await allContactsStream.first;

      expect(allContacts.length, 2);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Шевченко Кобзар'), isTrue);
    });
  });

  group('getContactByPhoneNumber', () {
    test('should return contacts for existing phone number', () async {
      final fetchedContacts = await database.contactsDao.getContactsByPhoneNumber('1234567890');

      expect(fetchedContacts, isNotEmpty);
      expect(fetchedContacts.length, 2);
      expect(fetchedContacts.any((contact) => contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(fetchedContacts.any((contact) => contact.lastName == 'Шевченко Кобзар'), isTrue);
    });

    test('should return empty list for non-existent phone number', () async {
      final fetchedContacts = await database.contactsDao.getContactsByPhoneNumber('0000000000');

      expect(fetchedContacts, isEmpty);
    });
  });
}
