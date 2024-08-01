import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());

    final contactsDao = database.contactsDao;
    final contactEmailsDao = database.contactEmailsDao;

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
      firstName: Value('Jane'),
      lastName: Value('Smith'),
      aliasName: Value('JS'),
    ));

    await contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
      sourceType: Value(ContactSourceTypeEnum.local),
      sourceId: Value('source3'),
      firstName: Value('Bob'),
      lastName: Value('Marly'),
      aliasName: Value('BM'),
    ));

    await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
      contactId: Value(1),
      number: Value('1234567890'),
      label: Value('Home'),
    ));

    await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
      contactId: Value(2),
      number: Value('0987654321'),
      label: Value('Work'),
    ));

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
      contactId: Value(1),
      address: Value('taras@example.com'),
      label: Value('Personal'),
    ));

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
      contactId: Value(2),
      address: Value('jane@example.com'),
      label: Value('Work'),
    ));

    await contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
      contactId: Value(2),
      address: Value('jane.smith@example.com'),
      label: Value('Personal'),
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
      expect(likeContacts.first.contact.firstName, '');
      expect(likeContacts.first.contact.lastName, 'Тарас Шевченко');
      expect(likeContacts.first.email?.address, 'taras@example.com');
    });

    test('matching "шев"', () async {
      final likeContactsStream = database.contactsDao.watchAllLikeContacts(['шев']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.contact.firstName, '');
      expect(likeContacts.first.contact.lastName, 'Тарас Шевченко');
      expect(likeContacts.first.email?.address, 'taras@example.com');
    });

    test('matching "Smit"', () async {
      final likeContactsStream = database.contactsDao.watchAllLikeContacts(['Smit']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.contact.firstName, 'Jane');
      expect(likeContacts.first.contact.lastName, 'Smith');
      expect(likeContacts.first.email?.address, 'jane.smith@example.com');
    });

    test('matching "mar"', () async {
      final likeContactsStream = database.contactsDao.watchAllLikeContacts(['mar']);
      final likeContacts = await likeContactsStream.first;

      expect(likeContacts.length, 1);
      expect(likeContacts.first.contact.firstName, 'Bob');
      expect(likeContacts.first.contact.lastName, 'Marly');
      expect(likeContacts.first.email?.address, null);
    });

    test('all contacts', () async {
      final allContactsStream = database.contactsDao.watchAllContacts();
      final allContacts = await allContactsStream.first;

      expect(allContacts.length, 3);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Тарас Шевченко'), isTrue);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Smith'), isTrue);
      expect(allContacts.any((contact) => contact.contact.lastName == 'Marly'), isTrue);
    });
  });
}
