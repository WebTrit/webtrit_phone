import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import 'migrations/migrations.dart';

export 'package:drift/isolate.dart';

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
  static Future<DriftIsolate> spawn(String databasePath) {
    return DriftIsolate.spawn(
      () => DatabaseConnection(
        NativeDatabase(
          File(databasePath),
          logStatements: EnvironmentConfig.DATABASE_LOG_STATEMENTS,
        ),
      ),
    );
  }

  AppDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  factory AppDatabase.fromIsolate(DriftIsolate isolate, {bool isolateDebugLog = false}) {
    return AppDatabase.connect(
      DatabaseConnection.delayed(isolate.connect(
        isolateDebugLog: isolateDebugLog,
        singleClientMode: true,
      )),
    );
  }

  Future<void> deleteEverything() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      transaction(() async {
        for (final table in allTables) {
          await delete(table).go();
        }
      });
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

  @override
  int get schemaVersion => migrations.schemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        for (var version = from; version < to; version++) {
          await migrations[version - 1].execute(this, m);
        }

        // Assert that the schema is valid after migrations
        if (kDebugMode) {
          final wrongForeignKeys = await customSelect('PRAGMA foreign_key_check').get();
          assert(wrongForeignKeys.isEmpty, '${wrongForeignKeys.map((e) => e.data)}');
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
      },
    );
  }

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities {
    return [
      ...super.allSchemaEntities,
      ...super
          .allSchemaEntities
          .whereType<TableInfo>()
          .map((tableInfo) => generateTableCompanionEntities(tableInfo))
          .expand((e) => e),
    ];
  }

  Iterable<DatabaseSchemaEntity> generateTableCompanionEntities(TableInfo tableInfo) sync* {
    {
      final afterInsertTrigger = _generateTableAfterInsertTrigger(tableInfo);
      if (afterInsertTrigger != null) yield afterInsertTrigger;
    }
    {
      final afterUpdateTrigger = _generateTableAfterUpdateTrigger(tableInfo);
      if (afterUpdateTrigger != null) yield afterUpdateTrigger;
    }
  }

  static const _insertedAtColumnName = 'inserted_at';
  static const _updatedAtColumnName = 'updated_at';

  Trigger? _generateTableAfterInsertTrigger(TableInfo tableInfo) {
    final isInsertedAtColumnExist = tableInfo.columnsByName.containsKey(_insertedAtColumnName);
    final isUpdatedAtColumnExist = tableInfo.columnsByName.containsKey(_updatedAtColumnName);
    if (!isInsertedAtColumnExist && !isUpdatedAtColumnExist) {
      return null;
    } else {
      final tableName = tableInfo.actualTableName;
      final triggerName = '${tableName}_after_insert_trigger';
      final triggerSql = '''
        CREATE TRIGGER $triggerName
          AFTER INSERT ON $tableName
        BEGIN
          ${isInsertedAtColumnExist ? '' : '--'}UPDATE $tableName SET $_insertedAtColumnName = STRFTIME('%s', 'NOW') WHERE id = NEW.id AND $_insertedAtColumnName IS NULL;
          ${isUpdatedAtColumnExist ? '' : '--'}UPDATE $tableName SET $_updatedAtColumnName = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
        END;
        ''';
      return Trigger(triggerSql, triggerName);
    }
  }

  Trigger? _generateTableAfterUpdateTrigger(TableInfo tableInfo) {
    final isUpdatedAtColumnExist = tableInfo.columnsByName.containsKey(_updatedAtColumnName);
    if (!isUpdatedAtColumnExist) {
      return null;
    } else {
      final tableName = tableInfo.actualTableName;
      final triggerName = '${tableName}_after_update_trigger';
      final triggerSql = '''
        CREATE TRIGGER $triggerName
          AFTER UPDATE ON $tableName
        BEGIN
          UPDATE $tableName SET $_updatedAtColumnName = STRFTIME('%s', 'NOW') WHERE id = NEW.id;
        END;
        ''';
      return Trigger(triggerSql, triggerName);
    }
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
  ContactPhonesTable,
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
          (t) => OrderingTerm.asc(t.lastName),
          (t) => OrderingTerm.asc(t.firstName),
          (t) => OrderingTerm.asc(t.displayName),
        ]);

  Stream<List<ContactData>> watchAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).watch();

  Future<List<ContactData>> getAllContacts([ContactSourceType? sourceType]) => _selectAllContacts(sourceType).get();

  Stream<List<ContactData>> watchAllNotEmptyContacts([ContactSourceType? sourceType]) {
    final q = _selectAllContacts(sourceType);
    q.where(
      (t) => [
        t.lastName,
        t.firstName,
        t.displayName,
      ].map((c) => c.isNotNull() & c.equalsExp(const Constant('')).not()).reduce((v, e) => v | e),
    );
    return q.watch();
  }

  Stream<List<ContactData>> watchAllLikeContacts(Iterable<String> searchBits, [ContactSourceType? sourceType]) {
    final q = _selectAllContacts(sourceType).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.contactId.equalsExp(contactsTable.id)),
    ]);
    for (final searchBit in searchBits) {
      q.where(
        [
          contactsTable.lastName,
          contactsTable.firstName,
          contactsTable.displayName,
          contactPhonesTable.number,
        ].map((c) => c.like('%$searchBit%')).reduce((v, e) => v | e),
      );
    }
    q.groupBy([contactPhonesTable.contactId]);
    return q.watch().map((rows) => rows.map((row) => row.readTable(contactsTable)).toList());
  }

  Stream<ContactData> watchContact(Insertable<ContactData> contact) {
    return (select(contactsTable)..whereSamePrimaryKey(contact)).watchSingle();
  }

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

  SimpleSelectStatement<$ContactPhonesTableTable, ContactPhoneData> _selectContactPhonesByContactId(int contactId) {
    return select(contactPhonesTable)
      ..where((t) => t.contactId.equals(contactId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.insertedAt),
      ]);
  }

  Stream<List<ContactPhoneData>> watchContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).watch();
  }

  Future<List<ContactPhoneData>> getContactPhonesByContactId(int contactId) {
    return _selectContactPhonesByContactId(contactId).get();
  }

  JoinedSelectStatement _selectContactPhonesByContactIdJoinFavorites(int contactId) {
    return _selectContactPhonesByContactId(contactId).join([
      leftOuterJoin(favoritesTable, favoritesTable.contactPhoneId.equalsExp(contactPhonesTable.id)),
    ]);
  }

  ContactPhoneDataWithFavoriteData _mapContactPhoneDataWithFavoriteData(TypedResult row) {
    return ContactPhoneDataWithFavoriteData(
      row.readTable(contactPhonesTable),
      row.readTableOrNull(favoritesTable),
    );
  }

  Stream<List<ContactPhoneDataWithFavoriteData>> watchContactPhonesExtByContactId(int contactId) {
    return _selectContactPhonesByContactIdJoinFavorites(contactId)
        .watch()
        .map((rows) => rows.map(_mapContactPhoneDataWithFavoriteData).toList());
  }

  Future<List<ContactPhoneDataWithFavoriteData>> getContactPhonesExtByContactId(int contactId) {
    return _selectContactPhonesByContactIdJoinFavorites(contactId)
        .get()
        .then((rows) => rows.map(_mapContactPhoneDataWithFavoriteData).toList());
  }

  Future<int> insertOnUniqueConflictUpdateContactPhone(Insertable<ContactPhoneData> contactPhone) {
    return into(contactPhonesTable).insert(
      contactPhone,
      onConflict: DoUpdate((_) => contactPhone, target: [contactPhonesTable.number, contactPhonesTable.contactId]),
    );
  }

  Future<int> deleteOtherContactPhonesOfContactId(int id, Iterable<String> numbers) {
    return (delete(contactPhonesTable)
          ..where((t) => t.contactId.equals(id))
          ..where((t) => t.number.isNotIn(numbers)))
        .go();
  }
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

  SimpleSelectStatement<$CallLogsTableTable, CallLogData> _selectLastCallLogs(Duration period) {
    return select(callLogsTable)
      ..where((t) => t.createdAt.isBiggerOrEqualValue(clock.agoBy(period)))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
  }

  SimpleSelectStatement<$CallLogsTableTable, CallLogData> _selectLastCallLogsByNumber(String number, Duration period) {
    return _selectLastCallLogs(period)..where((t) => t.number.equals(number));
  }

  Future<List<CallLogData>> getLastCallLogsByNumber(String number, [Duration period = const Duration(days: 14)]) {
    return _selectLastCallLogsByNumber(number, period).get();
  }

  Stream<List<CallLogData>> watchLastCallLogsByNumber(String number, [Duration period = const Duration(days: 14)]) {
    return _selectLastCallLogsByNumber(number, period).watch();
  }

  Stream<List<CallLogDataWithContactPhoneDataAndContactData>> watchLastCallLogsExt(
      [Duration period = const Duration(days: 14)]) {
    final q = _selectLastCallLogs(period).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    q.groupBy([callLogsTable.id]);
    return q.watch().map((rows) => rows.map(_toCallLogDataWithContactPhoneDataAndContactData).toList());
  }

  Future<CallLogDataWithContactPhoneDataAndContactData> getCallLogExt(Insertable<CallLogData> callLogData) {
    return (select(callLogsTable)..whereSamePrimaryKey(callLogData))
        .join([
          leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
          leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
        ])
        .getSingle()
        .then(_toCallLogDataWithContactPhoneDataAndContactData);
  }

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) {
    return into(callLogsTable).insert(callLogData);
  }

  Future<int> deleteCallLog(Insertable<CallLogData> callLogData) {
    return delete(callLogsTable).delete(callLogData);
  }

  CallLogDataWithContactPhoneDataAndContactData _toCallLogDataWithContactPhoneDataAndContactData(TypedResult row) {
    return CallLogDataWithContactPhoneDataAndContactData(
      row.readTable(callLogsTable),
      row.readTableOrNull(contactPhonesTable),
      row.readTableOrNull(contactsTable),
    );
  }
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
