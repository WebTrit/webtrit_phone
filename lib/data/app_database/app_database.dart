import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/contacts/models/models.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    ContactsTable,
    ContactPhonesTable,
    CallLogsTable,
  ],
  daos: [
    ContactsDao,
    ContactPhonesDao,
    CallLogsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    String databasePath,
  ) : super(NativeDatabase(
          File(databasePath),
          logStatements: kDebugMode,
        ));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );
}

@DataClassName('ContactData')
class ContactsTable extends Table {
  @override
  String get tableName => 'contacts';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get sourceType => intEnum<ContactSourceType>()();

  TextColumn get sourceId => text()();

  TextColumn get displayName => text().nullable()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(source_type, source_id)',
      ];
}

@DataClassName('ContactPhoneData')
class ContactPhonesTable extends Table {
  @override
  String get tableName => 'contact_phones';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get number => text()();

  TextColumn get label => text()();

  IntColumn get contactId => integer().customConstraint('NOT NULL REFERENCES contacts(id) ON DELETE CASCADE')();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(number, contact_id)',
      ];
}

@DataClassName('CallLogData')
class CallLogsTable extends Table {
  @override
  String get tableName => 'call_logs';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get direction => intEnum<Direction>()();

  TextColumn get number =>
      text().customConstraint('NOT NULL CONSTRAINT "call_logs.number not_empty" CHECK (length(number) > 0)')();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get acceptedAt => dateTime().nullable()();

  DateTimeColumn get hungUpAt => dateTime().nullable()();
}

@DriftAccessor(tables: [
  ContactsTable,
])
class ContactsDao extends DatabaseAccessor<AppDatabase> with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  Selectable<ContactData> _selectAllContacts([ContactSourceType? sourceType]) => select(contactsTable)
    ..where((t) => sourceType == null ? Variable.withBool(true) : t.sourceType.equals(sourceType.index))
    ..orderBy([
      (t) => OrderingTerm.asc(t.displayName),
      (t) => OrderingTerm.asc(t.lastName),
      (t) => OrderingTerm.asc(t.firstName),
    ]);

  Stream<List<ContactData>> watchAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).watch();

  Future<List<ContactData>> getAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).get();

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) =>
      into(contactsTable).insertReturning(contact,
          onConflict: DoUpdate((_) => contact, target: [contactsTable.sourceType, contactsTable.sourceId]));

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);
}

@DriftAccessor(tables: [
  ContactPhonesTable,
])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase> with _$ContactPhonesDaoMixin {
  ContactPhonesDao(AppDatabase db) : super(db);

  Future<List<ContactPhoneData>> getContactPhonesByContactId(int id) => (select(contactPhonesTable)
        ..where((t) => t.contactId.equals(id))
        ..orderBy([
          (t) => OrderingTerm.asc(t.insertedAt),
        ]))
      .get();

  Future<int> insertOnUniqueConflictUpdateContactPhone(Insertable<ContactPhoneData> contactPhone) =>
      into(contactPhonesTable).insert(contactPhone,
          onConflict: DoUpdate((_) => contactPhone, target: [contactPhonesTable.number, contactPhonesTable.contactId]));

  Future<int> deleteOtherContactPhonesOfContactId(int id, Iterable<String> numbers) => (delete(contactPhonesTable)
        ..where((t) => t.contactId.equals(id))
        ..where((t) => t.number.isNotIn(numbers)))
      .go();
}

@DriftAccessor(tables: [
  CallLogsTable,
  ContactPhonesTable,
  ContactsTable,
])
class CallLogsDao extends DatabaseAccessor<AppDatabase> with _$CallLogsDaoMixin {
  CallLogsDao(AppDatabase db) : super(db);

  Stream<List<CallLogData>> watchLastCallLogs([Duration period = const Duration(days: 14)]) => (select(callLogsTable)
        ..where((t) => t.createdAt.isBiggerOrEqualValue(DateTime.now().subtract(period)))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) => into(callLogsTable).insert(callLogData);

  Future<int> deleteCallLog(Insertable<CallLogData> callLogData) => delete(callLogsTable).delete(callLogData);
}
