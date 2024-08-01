import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());

    final contactsDao = database.contactsDao;

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
  });

  tearDown(() async {
    await database.close();
  });

  test('watchAllLikeContacts matching "Тарас"', () async {
    final likeContactsStream = database.contactsDao.watchAllLikeContacts(['Тарас']);
    final likeContacts = await likeContactsStream.first;

    expect(likeContacts.length, 1);
    expect(likeContacts.first.firstName, '');
    expect(likeContacts.first.lastName, 'Тарас Шевченко');
  });

  test('watchAllLikeContacts matching "шев"', () async {
    final likeContactsStream = database.contactsDao.watchAllLikeContacts(['шев']);
    final likeContacts = await likeContactsStream.first;

    expect(likeContacts.length, 1);
    expect(likeContacts.first.firstName, '');
    expect(likeContacts.first.lastName, 'Тарас Шевченко');
  });

  test('watchAllLikeContacts matching "Smit"', () async {
    final likeContactsStream = database.contactsDao.watchAllLikeContacts(['Smit']);
    final likeContacts = await likeContactsStream.first;

    expect(likeContacts.length, 1);
    expect(likeContacts.first.firstName, 'Jane');
    expect(likeContacts.first.lastName, 'Smith');
  });

  test('watchAllLikeContacts matching "mar"', () async {
    final likeContactsStream = database.contactsDao.watchAllLikeContacts(['mar']);
    final likeContacts = await likeContactsStream.first;

    expect(likeContacts.length, 1);
    expect(likeContacts.first.firstName, 'Bob');
    expect(likeContacts.first.lastName, 'Marly');
  });

  test('watchAllContacts', () async {
    final allContactsStream = database.contactsDao.watchAllContacts();
    final allContacts = await allContactsStream.first;

    expect(allContacts.length, 3);
    expect(allContacts.any((contact) => contact.lastName == 'Тарас Шевченко'), isTrue);
    expect(allContacts.any((contact) => contact.lastName == 'Smith'), isTrue);
    expect(allContacts.any((contact) => contact.lastName == 'Marly'), isTrue);
  });
}
