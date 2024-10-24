import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'contacts_dao.g.dart';

class ContactWithPhonesAndEmailsData {
  ContactWithPhonesAndEmailsData({required this.contact, required this.phones, required this.emails});

  final ContactData contact;
  final List<ContactPhoneData> phones;
  final List<ContactEmailData> emails;
}

@DriftAccessor(tables: [ContactsTable, ContactPhonesTable, ContactEmailsTable])
class ContactsDao extends DatabaseAccessor<AppDatabase> with _$ContactsDaoMixin {
  ContactsDao(super.db);

  SimpleSelectStatement<$ContactsTableTable, ContactData> _selectAllContacts([ContactSourceTypeEnum? sourceType]) =>
      select(contactsTable)
        ..where((t) {
          if (sourceType == null) {
            return const Constant(true);
          } else {
            return t.sourceType.equals(sourceType.index);
          }
        })
        ..orderBy([
          (t) => OrderingTerm.asc(t.lastName),
          (t) => OrderingTerm.asc(t.firstName),
          (t) => OrderingTerm.asc(t.aliasName),
        ]);

  Stream<List<ContactData>> watchAllContacts([ContactSourceTypeEnum? sourceType]) =>
      _selectAllContacts(sourceType).watch();

  Future<List<ContactData>> getAllContacts([ContactSourceTypeEnum? sourceType]) => _selectAllContacts(sourceType).get();

  Future<List<ContactData>> getContactsByPhoneNumber(String number) async {
    final query = select(contactsTable)
        .join([innerJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id))])
      ..groupBy([contactPhonesTable.contactId])
      ..where(contactPhonesTable.number.equals(number));

    final results = await query.get();
    return results.map((row) => row.readTable(contactsTable)).toList();
  }

  Stream<List<ContactData>> watchAllNotEmptyContacts([ContactSourceTypeEnum? sourceType]) {
    final q = _selectAllContacts(sourceType);
    q.where(
      (t) => [
        t.lastName,
        t.firstName,
        t.aliasName,
      ].map((c) => c.isNotNull() & c.equalsExp(const Constant('')).not()).reduce((v, e) => v | e),
    );
    return q.watch();
  }

  Stream<List<ContactData>> watchAllLikeContacts(Iterable<String> searchBits, [ContactSourceTypeEnum? sourceType]) {
    final q = _selectAllContacts(sourceType).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id)),
    ]);
    for (final searchBit in searchBits) {
      q.where(
        [
          contactsTable.lastName,
          contactsTable.firstName,
          contactsTable.aliasName,
          contactPhonesTable.number,
        ].map((c) => c.regexp('.*$searchBit.*', caseSensitive: false)).reduce((v, e) => v | e),
      );
    }
    q.groupBy([contactPhonesTable.contactId]);
    return q.watch().map((rows) => rows.map((row) => row.readTable(contactsTable)).toList());
  }

  Stream<ContactData> watchContact(Insertable<ContactData> contact) {
    return (select(contactsTable)..whereSamePrimaryKey(contact)).watchSingle();
  }

  Stream<ContactData?> watchContactBySource(ContactSourceTypeEnum sourceType, String sourceId) {
    return (select(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId)))
        .watchSingleOrNull();
  }

  Future<ContactData?> getContactBySource(ContactSourceTypeEnum sourceType, String sourceId) {
    return (select(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId)))
        .getSingleOrNull();
  }

  Stream<List<ContactWithPhonesAndEmailsData>> watchAllContactsExt([
    Iterable<String>? searchBits,
    ContactSourceTypeEnum? sourceType,
  ]) {
    final q = _selectAllContacts(sourceType).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
    ]);

    if (searchBits != null) {
      q.where(
        searchBits.map((searchBit) {
          return [
            contactsTable.lastName,
            contactsTable.firstName,
            contactsTable.aliasName,
            contactPhonesTable.number,
            contactEmailsTable.address,
          ].map((c) => c.regexp('.*$searchBit.*', caseSensitive: false)).reduce((v, e) => v | e);
        }).reduce((v, e) => v | e),
      );
    }

    return q.watch().map((rows) {
      final Map<int, ContactWithPhonesAndEmailsData> contactMap = {};

      for (final row in rows) {
        final contact = row.readTable(contactsTable);
        final phone = row.readTableOrNull(contactPhonesTable);
        final email = row.readTableOrNull(contactEmailsTable);

        final contactWithPhonesAndEmails = contactMap.putIfAbsent(
          contact.id,
          () => ContactWithPhonesAndEmailsData(
            contact: contact,
            phones: [],
            emails: [],
          ),
        );

        if (phone != null && !contactWithPhonesAndEmails.phones.contains(phone)) {
          contactWithPhonesAndEmails.phones.add(phone);
        }

        if (email != null && !contactWithPhonesAndEmails.emails.contains(email)) {
          contactWithPhonesAndEmails.emails.add(email);
        }
      }

      return contactMap.values.toList();
    });
  }

  Stream<ContactWithPhonesAndEmailsData?> watchContactExtBySource(ContactSourceTypeEnum sourceType, String sourceId) {
    final q =
        (select(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId))).join(
      [
        leftOuterJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id)),
        leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      ],
    );

    return q.watch().map((rows) {
      if (rows.isEmpty) return null;
      ContactData contact = rows.first.readTable(contactsTable);
      List<ContactPhoneData> phones = [];
      List<ContactEmailData> emails = [];

      for (final row in rows) {
        final phone = row.readTableOrNull(contactPhonesTable);
        final email = row.readTableOrNull(contactEmailsTable);

        if (phone != null && !phones.contains(phone)) phones.add(phone);
        if (email != null && !emails.contains(email)) emails.add(email);
      }

      return ContactWithPhonesAndEmailsData(contact: contact, phones: phones, emails: emails);
    });
  }

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) =>
      into(contactsTable).insertReturning(contact,
          onConflict: DoUpdate((_) => contact, target: [contactsTable.sourceType, contactsTable.sourceId]));

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);

  Future<int> deleteContactBySource(ContactSourceTypeEnum sourceType, String sourceId) =>
      (delete(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId))).go();
}
