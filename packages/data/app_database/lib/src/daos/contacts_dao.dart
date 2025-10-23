import 'dart:async';

import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'contacts_dao.g.dart';

class FullContactData {
  FullContactData({
    required this.contact,
    required this.phones,
    required this.emails,
    required this.favorites,
  });

  final ContactData contact;
  final List<ContactPhoneData> phones;
  final List<ContactEmailData> emails;
  final List<FavoriteData> favorites;
}

@DriftAccessor(tables: [ContactsTable, ContactPhonesTable, ContactEmailsTable, FavoritesTable])
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

  SimpleSelectStatement<$ContactsTableTable, ContactData> _selectBySource(
          ContactSourceTypeEnum sourceType, String sourceId) =>
      (select(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId)));

  FullContactData? _gatherSingleContact(List<TypedResult> rows) {
    if (rows.isEmpty) return null;
    ContactData contact = rows.first.readTable(contactsTable);
    List<ContactPhoneData> phones = [];
    List<ContactEmailData> emails = [];
    List<FavoriteData> favorites = [];

    for (final row in rows) {
      final phone = row.readTableOrNull(contactPhonesTable);
      final email = row.readTableOrNull(contactEmailsTable);
      final favorite = row.readTableOrNull(favoritesTable);

      if (phone != null && !phones.contains(phone)) phones.add(phone);
      if (email != null && !emails.contains(email)) emails.add(email);
      if (favorite != null && !favorites.contains(favorite)) favorites.add(favorite);
    }

    return FullContactData(contact: contact, phones: phones, emails: emails, favorites: favorites);
  }

  List<FullContactData> _gatherMultipleContacts(List<TypedResult> rows) {
    final Map<int, FullContactData> contactMap = {};

    for (final row in rows) {
      final contact = row.readTable(contactsTable);
      final phone = row.readTableOrNull(contactPhonesTable);
      final email = row.readTableOrNull(contactEmailsTable);
      final favorite = row.readTableOrNull(favoritesTable);

      final contactWithPhonesAndEmails = contactMap.putIfAbsent(
        contact.id,
        () => FullContactData(contact: contact, phones: [], emails: [], favorites: []),
      );

      if (phone != null && !contactWithPhonesAndEmails.phones.contains(phone)) {
        contactWithPhonesAndEmails.phones.add(phone);
      }

      if (email != null && !contactWithPhonesAndEmails.emails.contains(email)) {
        contactWithPhonesAndEmails.emails.add(email);
      }

      if (favorite != null && !contactWithPhonesAndEmails.favorites.contains(favorite)) {
        contactWithPhonesAndEmails.favorites.add(favorite);
      }
    }

    return contactMap.values.toList();
  }

  // TODO rename to _joinFullContactData
  /// And favorites and something else in future
  JoinedSelectStatement _joinPhonesAndEmails(SimpleSelectStatement select) {
    return select.join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(favoritesTable, favoritesTable.contactPhoneId.equalsExp(contactPhonesTable.id)),
    ]);
  }

  Future<FullContactData?> getContactByPhoneNumber(String number) async {
    final query = _joinPhonesAndEmails(select(contactsTable))
      ..where(contactPhonesTable.number.equals(number))
      ..limit(1);

    return query.get().then(_gatherSingleContact);
  }

  Stream<FullContactData?> watchContact(int id) {
    final s = (select(contactsTable)..where((t) => t.id.equals(id)));
    final query = _joinPhonesAndEmails(s);
    return query.watch().map(_gatherSingleContact);
  }

  Future<FullContactData?> getContactBySource(ContactSourceTypeEnum sourceType, String sourceId) {
    final query = _joinPhonesAndEmails(_selectBySource(sourceType, sourceId));
    return query.get().then(_gatherSingleContact);
  }

  Stream<FullContactData?> watchContactBySource(ContactSourceTypeEnum sourceType, String sourceId) {
    final query = _joinPhonesAndEmails(_selectBySource(sourceType, sourceId));
    return query.watch().map(_gatherSingleContact);
  }

  Stream<FullContactData?> watchContactByPhoneNumber(String number) {
    final query = _joinPhonesAndEmails(select(contactsTable))
      ..where(contactPhonesTable.number.equals(number))
      ..limit(1);

    return query.watch().map(_gatherSingleContact);
  }

  Stream<FullContactData?> watchContactByPhoneMatchedEnding(String number) {
    final query = _joinPhonesAndEmails(select(contactsTable));
    query.where(contactPhonesTable.number.regexp('.*$number', caseSensitive: false));
    query.limit(1);

    return query.watch().map((data) => _gatherMultipleContacts(data).firstOrNull);
  }

  Future<List<FullContactData>> getAllContacts([ContactSourceTypeEnum? sourceType]) async {
    final query = _joinPhonesAndEmails(_selectAllContacts(sourceType));
    final rows = await query.get();
    return _gatherMultipleContacts(rows);
  }

  Stream<List<FullContactData>> watchAllContacts([
    Iterable<String>? searchBits,
    ContactSourceTypeEnum? sourceType,
  ]) {
    final query = _joinPhonesAndEmails(_selectAllContacts(sourceType));

    if (searchBits != null) {
      query.where(
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

    return query.watch().map(_gatherMultipleContacts);
  }

  Future<Set<String>> getContactsSourceIds(ContactSourceTypeEnum sourceType) async {
    final query = selectOnly(contactsTable);
    query.addColumns([contactsTable.id, contactsTable.sourceId, contactsTable.sourceType]);
    query.where(contactsTable.sourceType.equals(sourceType.index));

    final rows = await query.get();
    return rows.map((row) => row.read(contactsTable.sourceId)).nonNulls.toSet();
  }

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) {
    return into(contactsTable).insertReturning(
      contact,
      onConflict: DoUpdate(
        (old) => contact,
        target: [
          contactsTable.sourceType,
          contactsTable.sourceId,
        ],
      ),
    );
  }

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);

  Future<int> deleteContactBySource(ContactSourceTypeEnum sourceType, String? sourceId) {
    final query = delete(contactsTable)
      ..where((t) => t.sourceType.equalsValue(sourceType))
      ..where((t) => sourceId != null ? t.sourceId.equals(sourceId) : t.sourceId.isNull());

    return query.go();
  }

  Future<int> deleteContactsWithNullSourceId(ContactSourceTypeEnum sourceType) {
    return (delete(contactsTable)
          ..where((t) => t.sourceType.equals(sourceType.index))
          ..where((t) => t.sourceId.isNull()))
        .go();
  }
}
