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
    FavoritesTable,
  ],
  daos: [
    ContactsDao,
    ContactPhonesDao,
    CallLogsDao,
    FavoritesDao,
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

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities {
    return [
      ...super.allSchemaEntities,
      ...super
          .allSchemaEntities
          .whereType<TableInfo>()
          .map((t) => [
                if (t.columnsByName.containsKey('inserted_at')) _afterInsertTrigger(t.actualTableName),
                if (t.columnsByName.containsKey('updated_at')) _afterUpdateTrigger(t.actualTableName),
              ])
          .expand((e) => e),
    ];
  }

  Trigger _afterInsertTrigger(String tableName) {
    final triggerName = '${tableName}_after_insert_trigger';
    return Trigger(
      '''
      CREATE TRIGGER $triggerName
        AFTER INSERT ON $tableName
      BEGIN
        UPDATE $tableName SET inserted_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id AND inserted_at IS NULL;
        UPDATE $tableName SET updated_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
      END;
      ''',
      triggerName,
    );
  }

  Trigger _afterUpdateTrigger(String tableName) {
    final triggerName = '${tableName}_after_update_trigger';
    return Trigger(
      '''
      CREATE TRIGGER $triggerName
        AFTER UPDATE ON $tableName
      BEGIN
        UPDATE $tableName SET updated_at = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
      END;
      ''',
      triggerName,
    );
  }
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

  BoolColumn get video => boolean()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get acceptedAt => dateTime().nullable()();

  DateTimeColumn get hungUpAt => dateTime().nullable()();
}

@DataClassName('FavoriteData')
class FavoritesTable extends Table {
  @override
  String get tableName => 'favorites';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get contactPhoneId =>
      integer().customConstraint('NOT NULL REFERENCES contact_phones(id) ON DELETE CASCADE')();

  IntColumn get position => integer()();
}

@DriftAccessor(tables: [
  ContactsTable,
])
class ContactsDao extends DatabaseAccessor<AppDatabase> with _$ContactsDaoMixin {
  ContactsDao(AppDatabase db) : super(db);

  SimpleSelectStatement<$ContactsTableTable, ContactData> _selectAllContacts([ContactSourceType? sourceType]) =>
      select(contactsTable)
        ..where((t) {
          if (sourceType == null) {
            return const Constant(true);
          } else {
            return t.sourceType.equals(sourceType.index);
          }
        })
        ..orderBy([
          (t) => OrderingTerm.asc(t.displayName),
          (t) => OrderingTerm.asc(t.lastName),
          (t) => OrderingTerm.asc(t.firstName),
        ]);

  Stream<List<ContactData>> watchAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).watch();

  Future<List<ContactData>> getAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).get();

  SimpleSelectStatement<$ContactsTableTable, ContactData> _selectAllNotEmptyContacts([ContactSourceType? sourceType]) =>
      _selectAllContacts(sourceType)
        ..where(
          (t) =>
              t.displayName.isNotNull() & t.displayName.equalsExp(const Constant('')).not() |
              t.firstName.isNotNull() & t.firstName.equalsExp(const Constant('')).not() |
              t.lastName.isNotNull() & t.lastName.equalsExp(const Constant('')).not(),
        );

  Stream<List<ContactData>> watchAllNotEmptyContacts([ContactSourceType? sourceType]) =>
      _selectAllNotEmptyContacts(sourceType).watch();

  SimpleSelectStatement<$ContactsTableTable, ContactData> _selectAllLikeContacts(Iterable<String> searchBits,
      [ContactSourceType? sourceType]) {
    final q = _selectAllContacts(sourceType);
    for (final searchBit in searchBits) {
      q.where(
        (t) => t.displayName.like('%$searchBit%') | t.firstName.like('%$searchBit%') | t.lastName.like('%$searchBit%'),
      );
    }
    return q;
  }

  Stream<List<ContactData>> watchAllLikeContacts(Iterable<String> searchBits, [ContactSourceType? sourceType]) =>
      _selectAllLikeContacts(searchBits, sourceType).watch();

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) =>
      into(contactsTable).insertReturning(contact,
          onConflict: DoUpdate((_) => contact, target: [contactsTable.sourceType, contactsTable.sourceId]));

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);

  Future<int> deleteContactBySource(ContactSourceType sourceType, String sourceId) =>
      (delete(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId))).go();
}

@DriftAccessor(tables: [
  ContactPhonesTable,
  FavoritesTable,
])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase> with _$ContactPhonesDaoMixin {
  ContactPhonesDao(AppDatabase db) : super(db);

  Future<List<ContactPhoneData>> getContactPhonesByContactId(int id) => (select(contactPhonesTable)
        ..where((t) => t.contactId.equals(id))
        ..orderBy([
          (t) => OrderingTerm.asc(t.insertedAt),
        ]))
      .get();

  Future<List<ContactPhoneDataWithFavoriteData>> getContactPhonesExtByContactId(int id) => (select(contactPhonesTable)
        ..where((t) => t.contactId.equals(id))
        ..orderBy([
          (t) => OrderingTerm.asc(t.insertedAt),
        ]))
      .join([
        leftOuterJoin(favoritesTable, favoritesTable.contactPhoneId.equalsExp(contactPhonesTable.id)),
      ])
      .get()
      .then((rows) => rows
          .map((row) => ContactPhoneDataWithFavoriteData(
                row.readTable(contactPhonesTable),
                row.readTableOrNull(favoritesTable),
              ))
          .toList());

  Future<int> insertOnUniqueConflictUpdateContactPhone(Insertable<ContactPhoneData> contactPhone) =>
      into(contactPhonesTable).insert(contactPhone,
          onConflict: DoUpdate((_) => contactPhone, target: [contactPhonesTable.number, contactPhonesTable.contactId]));

  Future<int> deleteOtherContactPhonesOfContactId(int id, Iterable<String> numbers) => (delete(contactPhonesTable)
        ..where((t) => t.contactId.equals(id))
        ..where((t) => t.number.isNotIn(numbers)))
      .go();
}

class ContactPhoneDataWithFavoriteData {
  ContactPhoneDataWithFavoriteData(
    this.contactPhoneData,
    this.favoriteData,
  );

  final ContactPhoneData contactPhoneData;
  final FavoriteData? favoriteData;
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

  Stream<List<CallLogDataWithContactPhoneDataAndContactData>> watchLastCallLogsExt(
      [Duration period = const Duration(days: 14)]) {
    final q = (select(callLogsTable)
          ..where((t) => t.createdAt.isBiggerOrEqualValue(DateTime.now().subtract(period)))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    return q.watch().map((rows) => rows
        .map((row) => CallLogDataWithContactPhoneDataAndContactData(
              row.readTable(callLogsTable),
              row.readTableOrNull(contactPhonesTable),
              row.readTableOrNull(contactsTable),
            ))
        .toList());
  }

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) => into(callLogsTable).insert(callLogData);

  Future<int> deleteCallLog(Insertable<CallLogData> callLogData) => delete(callLogsTable).delete(callLogData);
}

class CallLogDataWithContactPhoneDataAndContactData {
  CallLogDataWithContactPhoneDataAndContactData(
    this.callLog,
    this.contactPhoneData,
    this.contactData,
  );

  final CallLogData callLog;
  final ContactPhoneData? contactPhoneData;
  final ContactData? contactData;
}

@DriftAccessor(tables: [
  FavoritesTable,
  ContactPhonesTable,
  ContactsTable,
])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(AppDatabase db) : super(db);

  Stream<List<FavoriteDataWithContactPhoneDataAndContactData>> watchFavoritesExt() {
    final q = (select(favoritesTable)..orderBy([(t) => OrderingTerm.asc(t.position)])).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.id.equalsExp(favoritesTable.contactPhoneId)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    return q.watch().map((rows) => rows
        .map((row) => FavoriteDataWithContactPhoneDataAndContactData(
              row.readTable(favoritesTable),
              row.readTable(contactPhonesTable),
              row.readTable(contactsTable),
            ))
        .toList());
  }

  Future<int> insertFavoriteByContactPhoneId(int contactPhoneId) => customInsert(
        'INSERT INTO favorites (contact_phone_id, position) VALUES (?, (SELECT ifnull(max(position), 0) + 1 FROM favorites))',
        variables: [Variable.withInt(contactPhoneId)],
        updates: {favoritesTable},
      );

  Future<int> deleteByContactPhoneId(int contactPhoneId) =>
      (delete(favoritesTable)..where((t) => t.contactPhoneId.equals(contactPhoneId))).go();

  Future<int> deleteFavorite(Insertable<FavoriteData> favoriteData) => delete(favoritesTable).delete(favoriteData);
}

class FavoriteDataWithContactPhoneDataAndContactData {
  FavoriteDataWithContactPhoneDataAndContactData(
    this.favoriteData,
    this.contactPhoneData,
    this.contactData,
  );

  final FavoriteData favoriteData;
  final ContactPhoneData contactPhoneData;
  final ContactData contactData;
}
