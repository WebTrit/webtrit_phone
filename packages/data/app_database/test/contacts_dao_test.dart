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
      ContactPhoneDataCompanion(contactId: Value(1), number: Value('1234567890'), label: Value('Home')),
    );

    await contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
      ContactPhoneDataCompanion(contactId: Value(2), number: Value('1234567890'), label: Value('Home')),
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

  group('watchAllContacts search with regex metacharacters', () {
    // Regression for the "contacts search invalid regex" bug: the raw search
    // string is interpolated into the SQL REGEXP pattern, so metacharacters
    // must be escaped or the query throws / matches the wrong rows.
    setUp(() async {
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('source-meta-1'),
          firstName: Value(''),
          lastName: Value('Acme (HQ)'),
          aliasName: Value(''),
        ),
      );
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('source-meta-2'),
          firstName: Value(''),
          lastName: Value('C++ Developer'),
          aliasName: Value(''),
        ),
      );
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('source-meta-3'),
          firstName: Value(''),
          lastName: Value('Cxx Developer'),
          aliasName: Value(''),
        ),
      );
    });

    test('unbalanced "(" does not throw and matches literally', () async {
      // Before the fix, RegExp('.*(.*') is an invalid pattern and the query throws.
      final contacts = await database.contactsDao.watchAllContacts(['(']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, 'Acme (HQ)');
    });

    test('"(HQ)" matches the literal parentheses', () async {
      final contacts = await database.contactsDao.watchAllContacts(['(HQ)']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, 'Acme (HQ)');
    });

    test('"+" is treated as a literal, not a quantifier', () async {
      // Escaped "C\+\+" matches "C++ Developer" but not "Cxx Developer".
      final contacts = await database.contactsDao.watchAllContacts(['C++']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, 'C++ Developer');
    });
  });

  group('watchAllContacts CJK and Thai search', () {
    setUp(() async {
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('source-cjk'),
          firstName: Value(''),
          lastName: Value('王小明'),
          aliasName: Value(''),
        ),
      );
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          sourceId: Value('source-thai'),
          firstName: Value(''),
          lastName: Value('สมชาย'),
          aliasName: Value(''),
        ),
      );
    });

    test('matches a CJK (Chinese/Taiwanese) substring', () async {
      final contacts = await database.contactsDao.watchAllContacts(['小明']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, '王小明');
    });

    test('matches a full CJK name', () async {
      final contacts = await database.contactsDao.watchAllContacts(['王小明']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, '王小明');
    });

    test('matches a Thai substring', () async {
      final contacts = await database.contactsDao.watchAllContacts(['ชาย']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, 'สมชาย');
    });
  });

  group('watchAllContacts regex injection is neutralized', () {
    // The seed data has two contacts ("Тарас Шевченко", "Шевченко Кобзар"),
    // both sharing phone number "1234567890". A crafted search must be treated
    // as a literal string, never as an active pattern that over-matches.

    test('".*" does not act as a wildcard and matches nothing', () async {
      // Unescaped, ".*" makes REGEXP match every row (full contact-list leak).
      final contacts = await database.contactsDao.watchAllContacts(['.*']).first;

      expect(contacts, isEmpty);
    });

    test('alternation "Тарас|Кобзар" is literal and matches nothing', () async {
      // Unescaped, "|" would match either alternative and return both contacts.
      final contacts = await database.contactsDao.watchAllContacts(['Тарас|Кобзар']).first;

      expect(contacts, isEmpty);
    });

    test('"\\d" does not match digits in the phone number', () async {
      // Unescaped, "\d" would match the "1234567890" phone of both contacts.
      final contacts = await database.contactsDao.watchAllContacts([r'\d']).first;

      expect(contacts, isEmpty);
    });

    test('".*" still works as a plain prefix on a real query', () async {
      // Sanity: escaping the injection must not break normal substring search.
      final contacts = await database.contactsDao.watchAllContacts(['Тарас']).first;

      expect(contacts.length, 1);
      expect(contacts.single.contact.lastName, 'Тарас Шевченко');
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
        ContactPhoneDataCompanion(contactId: Value(contact2.id), number: Value('1234567890'), label: Value('Home')),
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

  group('ContactKindTypeEnum Tests', () {
    test('Contact defaults to ContactKindTypeEnum.visible when kind is not provided', () async {
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
      expect(newContact.contact.kind, ContactKindTypeEnum.visible);
    });

    test('getAllContacts filters based on kind', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          lastName: Value('Gail'),
          kind: Value(ContactKindTypeEnum.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Davis'),
          lastName: Value('Charles'),
          kind: Value(ContactKindTypeEnum.service),
        ),
      );

      final visibleContacts = await database.contactsDao.getAllContacts(null);
      expect(visibleContacts.length, initialVisibleCount + 1);
      final abiContact = visibleContacts.firstWhere((c) => c.contact.firstName == 'Abi');
      expect(abiContact.contact.kind, ContactKindTypeEnum.visible);

      final serviceContacts = await database.contactsDao.getAllContacts(null, kind: ContactKindTypeEnum.service);
      expect(serviceContacts.length, 1);
      expect(serviceContacts.first.contact.firstName, 'Davis');
      expect(serviceContacts.first.contact.kind, ContactKindTypeEnum.service);
    });

    test('getServiceContacts returns only service contacts', () async {
      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          kind: Value(ContactKindTypeEnum.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          firstName: Value('Davis'),
          kind: Value(ContactKindTypeEnum.service),
        ),
      );

      final result = await database.contactsDao.getServiceContacts();

      expect(result.length, 1);

      expect(result.first.contact.firstName, 'Davis');
      expect(result.first.contact.kind, ContactKindTypeEnum.service);
    });

    test('getServiceContacts returns only visible contacts', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null, kind: ContactKindTypeEnum.visible);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Abi'),
          lastName: Value('Gail'),
          kind: Value(ContactKindTypeEnum.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Davis'),
          lastName: Value('Charles'),
          kind: Value(ContactKindTypeEnum.service),
        ),
      );

      final result = await database.contactsDao.getAllContacts(null, kind: ContactKindTypeEnum.visible);

      expect(result.length, initialVisibleCount + 1);

      expect(result.any((c) => c.contact.firstName == 'Abi'), isTrue);
      expect(result.any((c) => c.contact.firstName == 'Davis'), isFalse);
    });

    test('watchAllContacts respects kind parameter', () async {
      final initialVisibleContacts = await database.contactsDao.getAllContacts(null, kind: ContactKindTypeEnum.visible);
      final initialVisibleCount = initialVisibleContacts.length;

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Wilson'),
          kind: Value(ContactKindTypeEnum.visible),
        ),
      );

      await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.local),
          firstName: Value('Moore'),
          kind: Value(ContactKindTypeEnum.service),
        ),
      );

      final visibleStream = database.contactsDao.watchAllContacts();
      final visibleList = await visibleStream.first;

      expect(visibleList.length, initialVisibleCount + 1);
      expect(visibleList.first.contact.firstName, 'Wilson');

      final serviceStream = database.contactsDao.watchAllContacts(null, null, ContactKindTypeEnum.service);
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
          kind: Value(ContactKindTypeEnum.service),
        ),
      );

      await database.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(contact.id), number: Value('911'), label: Value('Emergency')),
      );

      final fetched = await dao.getServiceContacts();

      expect(fetched.length, 1);
      expect(fetched.first.phones.length, 1);
      expect(fetched.first.phones.first.number, '911');
    });
  });

  group('phone-number lookups - local vs external number collision', () {
    // A local phonebook contact and an external/PBX contact share the SAME phone
    // number. Without an explicit ORDER BY the winner is left to SQLite's
    // unspecified row order (platform/data dependent). Ordering by sourceType DESC
    // makes the external (PBX) entry win deterministically across every lookup
    // method, regardless of insertion order.
    Future<void> setupCollision({required bool localFirst}) async {
      final dao = database.contactsDao;
      final phonesDao = database.contactPhonesDao;

      Future<void> addLocal() async {
        final c = await dao.insertOnUniqueConflictUpdateContact(
          ContactDataCompanion(
            sourceType: Value(ContactSourceTypeEnum.local),
            sourceId: Value('local-4'),
            firstName: Value('Local Contact 4'),
            aliasName: Value('Local Contact 4'),
          ),
        );
        await phonesDao.insertOnUniqueConflictUpdateContactPhone(
          ContactPhoneDataCompanion(contactId: Value(c.id), number: Value('4'), label: Value('mobile')),
        );
      }

      Future<void> addExternal() async {
        final c = await dao.insertOnUniqueConflictUpdateContact(
          ContactDataCompanion(
            sourceType: Value(ContactSourceTypeEnum.external),
            sourceId: Value('ext-4'),
            aliasName: Value('Dima4'),
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

    // Sanity: prove a REAL collision exists (both a local and an external
    // contact carry number "4") so a passing winner-assertion is not a false
    // negative caused by one side failing to insert.
    Future<void> assertRealCollision() async {
      final all = await database.contactsDao.getAllContacts(null);
      final withNumber4 = all.where((c) => c.phones.any((p) => p.number == '4')).toList();
      expect(withNumber4.length, 2, reason: 'both local + external must carry number 4');
      expect(
        withNumber4.any(
          (c) => c.contact.sourceType == ContactSourceTypeEnum.local && c.contact.aliasName == 'Local Contact 4',
        ),
        isTrue,
      );
      expect(
        withNumber4.any(
          (c) => c.contact.sourceType == ContactSourceTypeEnum.external && c.contact.aliasName == 'Dima4',
        ),
        isTrue,
      );
    }

    // Every lookup path touched by the ORDER BY fix must prefer the external
    // (PBX) contact on a collision - exact-number and matched-ending, get + watch.
    final lookups = <String, Future<FullContactData?> Function()>{
      'getContactByPhoneNumber': () => database.contactsDao.getContactByPhoneNumber('4'),
      'watchContactByPhoneNumber': () => database.contactsDao.watchContactByPhoneNumber('4').first,
      'getContactByPhoneMatchedEnding': () => database.contactsDao.getContactByPhoneMatchedEnding('4'),
      'watchContactByPhoneMatchedEnding': () => database.contactsDao.watchContactByPhoneMatchedEnding('4').first,
    };

    for (final entry in lookups.entries) {
      for (final localFirst in [true, false]) {
        test('${entry.key} prefers external (local-first=$localFirst)', () async {
          await setupCollision(localFirst: localFirst);
          await assertRealCollision();

          final contact = await entry.value();

          expect(contact, isNotNull);
          expect(
            contact!.contact.sourceType,
            ContactSourceTypeEnum.external,
            reason: 'external (PBX) should win on collision',
          );
          expect(contact.contact.aliasName, 'Dima4');
        });
      }
    }
  });

  group('ContactPhonesDao', () {
    late int contactId;

    setUp(() async {
      final contact = await database.contactsDao.insertOnUniqueConflictUpdateContact(
        ContactDataCompanion(
          sourceType: Value(ContactSourceTypeEnum.external),
          sourceId: Value('did_test'),
          firstName: Value('Alice'),
        ),
      );
      contactId = contact.id;
    });

    test('allows same number with different labels (DID-only scenario)', () async {
      final dao = database.contactPhonesDao;

      await dao.insertContactPhonesBatch([
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000002'), label: Value('number')),
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000002'), label: Value('sms')),
      ]);

      final phones = await dao.getContactPhonesByContactId(contactId);

      expect(phones.length, 2);
      expect(phones.any((p) => p.label == 'number'), isTrue);
      expect(phones.any((p) => p.label == 'sms'), isTrue);
    });

    test('upsert same (number, label, contact_id) updates in place — no duplicate', () async {
      final dao = database.contactPhonesDao;

      await dao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000002'), label: Value('number')),
      );
      await dao.insertOnUniqueConflictUpdateContactPhone(
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000002'), label: Value('number')),
      );

      final phones = await dao.getContactPhonesByContactId(contactId);

      expect(phones.length, 1);
      expect(phones.first.number, '16042000002');
      expect(phones.first.label, 'number');
    });

    test('deleteOtherContactPhonesOfContactId with empty list removes all phones', () async {
      final dao = database.contactPhonesDao;

      await dao.insertContactPhonesBatch([
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('1601'), label: Value('ext')),
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000001'), label: Value('number')),
      ]);

      await dao.deleteOtherContactPhonesOfContactId(contactId, []);

      final phones = await dao.getContactPhonesByContactId(contactId);
      expect(phones, isEmpty);
    });

    test('deleteOtherContactPhonesOfContactId keeps only matching (number, label) pairs', () async {
      final dao = database.contactPhonesDao;

      await dao.insertContactPhonesBatch([
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('1601'), label: Value('ext')),
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000001'), label: Value('number')),
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('16042000001'), label: Value('sms')),
        ContactPhoneDataCompanion(
          contactId: Value(contactId),
          number: Value('99900099907'),
          label: Value('additional'),
        ),
        ContactPhoneDataCompanion(contactId: Value(contactId), number: Value('99900099907'), label: Value('sms')),
      ]);

      // Simulate role change: additional is removed, sms for 99900099907 stays
      await dao.deleteOtherContactPhonesOfContactId(contactId, [
        (number: '1601', label: 'ext'),
        (number: '16042000001', label: 'number'),
        (number: '16042000001', label: 'sms'),
        (number: '99900099907', label: 'sms'),
      ]);

      final phones = await dao.getContactPhonesByContactId(contactId);
      expect(phones.length, 4);
      expect(phones.any((p) => p.number == '99900099907' && p.label == 'additional'), isFalse);
      expect(phones.any((p) => p.number == '99900099907' && p.label == 'sms'), isTrue);
    });
  });
}
