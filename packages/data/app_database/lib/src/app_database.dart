import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

import 'migrations/migrations.dart';

part 'app_database.g.dart';

// TODO (Vlad): split into separate files

@DriftDatabase(
  tables: [
    ContactsTable,
    ContactPhonesTable,
    ContactEmailsTable,
    CallLogsTable,
    FavoritesTable,
    ChatsTable,
    ChatMembersTable,
    ChatMessagesTable,
    ChatOutboxMessageTable,
    ChatOutboxMessageEditTable,
    ChatOutboxMessageDeleteTable,
    ChatOutboxMessageViewsTable,
    ChatMessageSyncCursorTable
  ],
  daos: [
    ContactsDao,
    ContactPhonesDao,
    ContactEmailsDao,
    CallLogsDao,
    FavoritesDao,
    ChatsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  Future<void> deleteEverything() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      await transaction(() async {
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
        // disable foreign_keys before migrations
        await customStatement('PRAGMA foreign_keys = OFF');

        await transaction(() async {
          for (var version = from; version < to; version++) {
            await migrations[version - 1].execute(this, m);
          }
        });

        // Assert that the schema is valid after migrations
        assert(() {
          () async {
            final wrongForeignKeys = await customSelect('PRAGMA foreign_key_check').get();
            assert(wrongForeignKeys.isEmpty, '${wrongForeignKeys.map((e) => e.data)}');
          }();
          return true;
        }());
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

enum ContactSourceTypeEnum {
  local,
  external,
}

@DataClassName('ContactData')
class ContactsTable extends Table {
  @override
  String get tableName => 'contacts';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get sourceType => intEnum<ContactSourceTypeEnum>()();

  TextColumn get sourceId => text()();

  TextColumn get firstName => text().nullable()();

  TextColumn get lastName => text().nullable()();

  TextColumn get aliasName => text().nullable()();

  BlobColumn get thumbnail => blob().nullable()();

  BoolColumn get registered => boolean().nullable()();

  BoolColumn get userRegistered => boolean().nullable()();

  BoolColumn get isCurrentUser => boolean().nullable()();

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

@DataClassName('ContactEmailData')
class ContactEmailsTable extends Table {
  @override
  String get tableName => 'contact_emails';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get address => text()();

  TextColumn get label => text()();

  IntColumn get contactId => integer().customConstraint('NOT NULL REFERENCES contacts(id) ON DELETE CASCADE')();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(address, contact_id)',
      ];
}

enum CallLogDirectionEnum {
  incoming,
  outgoing,
}

@DataClassName('CallLogData')
class CallLogsTable extends Table {
  @override
  String get tableName => 'call_logs';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get direction => intEnum<CallLogDirectionEnum>()();

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

enum ChatTypeEnum { dialog, group }

@DataClassName('ChatData')
class ChatsTable extends Table {
  @override
  String get tableName => 'chats';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get type => textEnum<ChatTypeEnum>()();

  TextColumn get name => text().nullable()();

  DateTimeColumn get insertedAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}

enum GroupAuthoritiesEnum { moderator, owner }

@DataClassName('ChatMemberData')
class ChatMembersTable extends Table {
  @override
  String get tableName => 'chat_members';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();

  TextColumn get groupAuthorities => textEnum<GroupAuthoritiesEnum>().nullable()();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}

enum SmsOutStateEnum { sending, error, delivered }

@DataClassName('ChatMessageData')
class ChatMessagesTable extends Table {
  @override
  String get tableName => 'chat_messages';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  TextColumn get senderId => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get replyToId => integer().nullable()();

  IntColumn get forwardFromId => integer().nullable()();

  TextColumn get authorId => text().nullable()();

  BoolColumn get viaSms => boolean().withDefault(const Constant(false))();

  TextColumn get smsOutState => textEnum<SmsOutStateEnum>().nullable()();

  TextColumn get smsNumber => text().nullable()();

  TextColumn get content => text()();

  DateTimeColumn get viewedAt => dateTime().nullable()();

  DateTimeColumn get editedAt => dateTime().nullable()();

  DateTimeColumn get createdAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();

  DateTimeColumn get deletedAtRemote => dateTime().nullable()();

  DateTimeColumn get insertedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}

@DataClassName('ChatOutboxMessageData')
class ChatOutboxMessageTable extends Table {
  @override
  String get tableName => 'chat_outbox_messages';

  @override
  Set<Column> get primaryKey => {idKey};

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().nullable().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get participantId => text().nullable()();

  IntColumn get replyToId => integer().nullable()();

  IntColumn get forwardFromId => integer().nullable()();

  TextColumn get authorId => text().nullable()();

  BoolColumn get viaSms => boolean().withDefault(const Constant(false))();

  TextColumn get smsNumber => text().nullable()();

  TextColumn get content => text()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}

@DataClassName('ChatOutboxMessageEditData')
class ChatOutboxMessageEditTable extends Table {
  @override
  String get tableName => 'chat_outbox_message_edits';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get newContent => text()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}

@DataClassName('ChatOutboxMessageDeleteData')
class ChatOutboxMessageDeleteTable extends Table {
  @override
  String get tableName => 'chat_outbox_message_deletes';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}

@DataClassName('ChatOutboxMessageViewData')
class ChatOutboxMessageViewsTable extends Table {
  @override
  String get tableName => 'chat_outbox_message_views';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get idKey => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();
}

enum MessageSyncCursorTypeEnum { oldest, newest }

@DataClassName('ChatMessageSyncCursorData')
class ChatMessageSyncCursorTable extends Table {
  @override
  String get tableName => 'chat_message_sync_cursors';

  @override
  Set<Column> get primaryKey => {chatId, cursorType};

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get cursorType => textEnum<MessageSyncCursorTypeEnum>()();

  IntColumn get timestampUsec => integer()();
}

@DriftAccessor(tables: [
  ContactsTable,
  ContactPhonesTable,
  ContactEmailsTable,
])
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

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) =>
      into(contactsTable).insertReturning(contact,
          onConflict: DoUpdate((_) => contact, target: [contactsTable.sourceType, contactsTable.sourceId]));

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);

  Future<int> deleteContactBySource(ContactSourceTypeEnum sourceType, String sourceId) =>
      (delete(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId))).go();
}

class ContactWithPhonesAndEmailsData {
  ContactWithPhonesAndEmailsData({
    required this.contact,
    required this.phones,
    required this.emails,
  });

  final ContactData contact;
  final List<ContactPhoneData> phones;
  final List<ContactEmailData> emails;
}

@DriftAccessor(tables: [
  ContactPhonesTable,
  FavoritesTable,
])
class ContactPhonesDao extends DatabaseAccessor<AppDatabase> with _$ContactPhonesDaoMixin {
  ContactPhonesDao(super.db);

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

@DriftAccessor(tables: [
  ContactEmailsTable,
])
class ContactEmailsDao extends DatabaseAccessor<AppDatabase> with _$ContactEmailsDaoMixin {
  ContactEmailsDao(super.db);

  SimpleSelectStatement<$ContactEmailsTableTable, ContactEmailData> _selectContactEmailsByContactId(int contactId) {
    return select(contactEmailsTable)
      ..where((t) => t.contactId.equals(contactId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.insertedAt),
      ]);
  }

  Stream<List<ContactEmailData>> watchContactEmailsByContactId(int contactId) {
    return _selectContactEmailsByContactId(contactId).watch();
  }

  Future<List<ContactEmailData>> getContactEmailsByContactId(int contactId) {
    return _selectContactEmailsByContactId(contactId).get();
  }

  Future<int> insertOnUniqueConflictUpdateContactEmail(Insertable<ContactEmailData> entity) {
    return into(contactEmailsTable).insert(
      entity,
      onConflict: DoUpdate((_) => entity, target: [contactEmailsTable.address, contactEmailsTable.contactId]),
    );
  }

  Future<int> deleteOtherContactEmailsOfContactId(int contactId, Iterable<String> addresses) {
    return (delete(contactEmailsTable)
          ..where((t) => t.contactId.equals(contactId))
          ..where((t) => t.address.isNotIn(addresses)))
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
  CallLogsDao(super.db);

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
    _groupByCallLogsTableId(q);
    return q.watch().map((rows) => rows.map(_toCallLogDataWithContactPhoneDataAndContactData).toList());
  }

  Future<CallLogDataWithContactPhoneDataAndContactData> getCallLogExt(Insertable<CallLogData> callLogData) {
    final q = (select(callLogsTable)..whereSamePrimaryKey(callLogData)).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
    ]);
    _groupByCallLogsTableId(q);
    return q.getSingle().then(_toCallLogDataWithContactPhoneDataAndContactData);
  }

  Future<int> insertCallLog(Insertable<CallLogData> callLogData) {
    return into(callLogsTable).insert(callLogData);
  }

  Future<int> deleteCallLog(Insertable<CallLogData> callLogData) {
    return delete(callLogsTable).delete(callLogData);
  }

  // necessary to overcome the possibility that one particular number be assigned to more than one contact
  void _groupByCallLogsTableId(JoinedSelectStatement statement) {
    statement.groupBy([callLogsTable.id]);
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
  FavoritesDao(super.db);

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

@DriftAccessor(tables: [
  ChatsTable,
  ChatMembersTable,
  ChatMessagesTable,
  ChatOutboxMessageTable,
  ChatOutboxMessageEditTable,
  ChatOutboxMessageDeleteTable,
  ChatOutboxMessageViewsTable,
  ChatMessageSyncCursorTable,
])
class ChatsDao extends DatabaseAccessor<AppDatabase> with _$ChatsDaoMixin {
  ChatsDao(super.db);

  // Chats

  Future<List<ChatData>> getAllChats() => select(chatsTable).get();

  Future<List<int>> getChatIds() {
    final q = customSelect('SELECT id FROM chats');
    return q.get().then((rows) => rows.map((row) => row.data['id'] as int).toList());
  }

  Future<int?> findDialogId(String participantId) async {
    var variables = [Variable.withString(ChatTypeEnum.dialog.name), Variable.withString(participantId)];
    final query = customSelect('''
      SELECT c.id, c.type
      FROM chats c
      JOIN chat_members cm ON c.id = cm.chat_id
      WHERE c.type = ? AND cm.user_id = ?
    ''', variables: variables);
    final rows = await query.get();
    return rows.firstOrNull?.data.values.first;
  }

  Future<DateTime?> lastChatUpdatedAt() {
    final q = customSelect('SELECT MAX(updated_at_remote) FROM chats');
    return q.getSingle().then((row) {
      if (row.data.values.first == null) return null;
      final secEpoh = row.data.values.first as int;
      final millisEpoh = secEpoh * 1000;
      return DateTime.fromMillisecondsSinceEpoch(millisEpoh);
    });
  }

  Future<int> upsertChat(Insertable<ChatData> chat) {
    return into(chatsTable).insertOnConflictUpdate(chat);
  }

  Future<int> deleteChatById(int chatId) {
    return (delete(chatsTable)..where((t) => t.id.equals(chatId))).go();
  }

  // ChatMembers

  Future<List<ChatMemberData>> getChatMembersByChatId(int chatId) {
    return (select(chatMembersTable)..where((t) => t.chatId.equals(chatId))).get();
  }

  Future<int> upsertChatMember(Insertable<ChatMemberData> chatMember) {
    return into(chatMembersTable).insert(chatMember, mode: InsertMode.insertOrReplace);
  }

  Future<int> deleteChatMember(Insertable<ChatMemberData> chatMember) {
    return delete(chatMembersTable).delete(chatMember);
  }

  // ChatDataWithMembers
  Future<List<ChatDataWithMembers>> getAllChatsWithMembers() {
    final q = select(chatsTable).join([
      leftOuterJoin(chatMembersTable, chatMembersTable.chatId.equalsExp(chatsTable.id)),
    ])
      ..orderBy([OrderingTerm(expression: chatsTable.updatedAtRemote, mode: OrderingMode.desc)]);

    return q.get().then((rows) {
      final chatData = <ChatData>[];
      final members = <ChatMemberData>[];
      for (final row in rows) {
        final chat = row.readTable(chatsTable);
        if (!chatData.contains(chat)) chatData.add(chat);

        final member = row.readTableOrNull(chatMembersTable);
        if (member != null) members.add(member);
      }
      return chatData.map((chat) {
        return ChatDataWithMembers(chat, members.where((m) => m.chatId == chat.id).toList());
      }).toList();
    });
  }

  Future<ChatDataWithMembers> getChatWithMembers(int chatId) {
    final q = select(chatsTable).join([
      leftOuterJoin(chatMembersTable, chatMembersTable.chatId.equalsExp(chatsTable.id)),
    ]);
    return q.get().then((rows) {
      final chatData = <ChatData>[];
      final members = <ChatMemberData>[];
      for (final row in rows) {
        final chat = row.readTable(chatsTable);
        if (!chatData.contains(chat)) chatData.add(chat);

        final member = row.readTableOrNull(chatMembersTable);
        if (member != null) members.add(member);
      }
      return ChatDataWithMembers(
          chatData.firstWhere((c) => c.id == chatId), members.where((m) => m.chatId == chatId).toList());
    });
  }

  Future upsertChatWithMembers(ChatDataWithMembers data) async {
    await transaction(() async {
      final currentChatMembers = await getChatMembersByChatId(data.chatData.id);
      final membersToDelete = currentChatMembers.where((m) => !data.members.any((newM) => newM.userId == m.userId));
      final membersToUpsert = data.members;
      await upsertChat(data.chatData);
      for (final member in membersToDelete) {
        await deleteChatMember(member);
      }
      for (final member in membersToUpsert) {
        await upsertChatMember(member);
      }
    });
  }

  // ChatMessages

  Future<ChatMessageData?> getChatMessageById(int id) {
    return (select(chatMessagesTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<ChatMessageData>> getMessageHistory(
    int chatId, {
    DateTime? from,
    DateTime? to,
    required int limit,
  }) async {
    final q = select(chatMessagesTable);
    q.where((t) => t.chatId.equals(chatId));
    if (from != null) q.where((t) => t.createdAtRemote.isSmallerThanValue(from));
    if (to != null) q.where((t) => t.createdAtRemote.isBiggerOrEqualValue(to));
    q.orderBy([(t) => OrderingTerm.desc(t.createdAtRemote), (t) => OrderingTerm.desc(t.id)]);
    q.limit(limit);
    return q.get();
  }

  Future<int?> upsertChatMessage(ChatMessageData chatMessage) async {
    return into(chatMessagesTable).insertOnConflictUpdate(chatMessage);
  }

  Future<List<ChatMessageData>> updateViews(List<int> messageIds, DateTime viewedAt) async {
    final q = update(chatMessagesTable)..where((t) => t.id.isIn(messageIds));
    final r = await q.writeReturning(
      ChatMessageDataCompanion(
        viewedAt: Value(viewedAt),
        updatedAt: Value(viewedAt),
      ),
    );
    return r;
  }

  Stream<int> unreadMessagesCount(int chatId, String userId) {
    final amount = chatMessagesTable.id.count();
    var q = (selectOnly(chatMessagesTable)..addColumns([amount]));
    q.where(
      chatMessagesTable.chatId.equals(chatId) &
          chatMessagesTable.senderId.isNotIn([userId]) &
          chatMessagesTable.viewedAt.isNull(),
    );
    return q.watchSingle().map((data) => data.read(amount) ?? 0);
  }

  Stream<int> chatsWithUnreadedMessagesCount(String userId) {
    var q = (selectOnly(chatMessagesTable)..addColumns([chatMessagesTable.chatId]));
    q.where(chatMessagesTable.senderId.isNotIn([userId]) & chatMessagesTable.viewedAt.isNull());
    q.groupBy([chatMessagesTable.chatId]);
    return q.watch().map((data) => data.length);
  }

  // Message sync cursor

  Future<ChatMessageSyncCursorData?> getChatMessageSyncCursor(int chatId, MessageSyncCursorTypeEnum cursorType) {
    return (select(chatMessageSyncCursorTable)
          ..where((t) => t.chatId.equals(chatId) & t.cursorType.equals(cursorType.name)))
        .getSingleOrNull();
  }

  Future<int> upsertChatMessageSyncCursor(Insertable<ChatMessageSyncCursorData> chatMessageSyncCursor) {
    return into(chatMessageSyncCursorTable).insertOnConflictUpdate(chatMessageSyncCursor);
  }

  // Messages outbox

  Future<List<ChatOutboxMessageData>> getChatOutboxMessages() {
    return select(chatOutboxMessageTable).get();
  }

  Stream<List<ChatOutboxMessageData>> watchChatOutboxMessages() {
    return select(chatOutboxMessageTable).watch();
  }

  Future<int> upsertChatOutboxMessage(Insertable<ChatOutboxMessageData> chatOutboxMessage) {
    return into(chatOutboxMessageTable).insertOnConflictUpdate(chatOutboxMessage);
  }

  Future<int> deleteChatOutboxMessage(String idKey) {
    return (delete(chatOutboxMessageTable)..where((t) => t.idKey.equals(idKey))).go();
  }

  // Message edits outbox

  Future<List<ChatOutboxMessageEditData>> getChatOutboxMessageEdits() {
    return select(chatOutboxMessageEditTable).get();
  }

  Stream<List<ChatOutboxMessageEditData>> watchChatOutboxMessageEdits() {
    return select(chatOutboxMessageEditTable).watch();
  }

  Future<int> upsertChatOutboxMessageEdit(Insertable<ChatOutboxMessageEditData> chatOutboxMessageEdit) {
    return into(chatOutboxMessageEditTable).insertOnConflictUpdate(chatOutboxMessageEdit);
  }

  Future<int> deleteChatOutboxMessageEdit(int id) {
    return (delete(chatOutboxMessageEditTable)..where((t) => t.id.equals(id))).go();
  }

  // Message deletes outbox

  Future<List<ChatOutboxMessageDeleteData>> getChatOutboxMessageDeletes() {
    return select(chatOutboxMessageDeleteTable).get();
  }

  Stream<List<ChatOutboxMessageDeleteData>> watchChatOutboxMessageDeletes() {
    return select(chatOutboxMessageDeleteTable).watch();
  }

  Future<int> upsertChatOutboxMessageDelete(Insertable<ChatOutboxMessageDeleteData> chatOutboxMessageDelete) {
    return into(chatOutboxMessageDeleteTable).insertOnConflictUpdate(chatOutboxMessageDelete);
  }

  Future<int> deleteChatOutboxMessageDelete(int id) {
    return (delete(chatOutboxMessageDeleteTable)..where((t) => t.id.equals(id))).go();
  }

  // Message views outbox

  Future<List<ChatOutboxMessageViewData>> getChatOutboxMessageViews() {
    return select(chatOutboxMessageViewsTable).get();
  }

  Stream<List<ChatOutboxMessageViewData>> watchChatOutboxMessageViews() {
    return select(chatOutboxMessageViewsTable).watch();
  }

  Future<int> upsertChatOutboxMessageView(Insertable<ChatOutboxMessageViewData> chatOutboxMessageView) {
    return into(chatOutboxMessageViewsTable).insertOnConflictUpdate(chatOutboxMessageView);
  }

  Future<int> deleteChatOutboxMessageView(int id) {
    return (delete(chatOutboxMessageViewsTable)..where((t) => t.id.equals(id))).go();
  }

  // Service

  Future<void> wipeStaleDeletedChatMessagesData({int ttlSeconds = 60 * 60 * 24}) async {
    final staleTime = clock.now().subtract(Duration(seconds: ttlSeconds));
    await (delete(chatMessagesTable)..where((t) => t.deletedAtRemote.isSmallerThanValue(staleTime))).go();
  }

  Future<void> wipeChatsData() async {
    await transaction(() async {
      await delete(chatsTable).go();
      await delete(chatMembersTable).go();
      await delete(chatMessagesTable).go();
      await delete(chatMessageSyncCursorTable).go();
    });
  }

  Future<void> wipeOutboxMessagesData() async {
    await transaction(() async {
      await delete(chatOutboxMessageTable).go();
      await delete(chatOutboxMessageEditTable).go();
      await delete(chatOutboxMessageDeleteTable).go();
      await delete(chatOutboxMessageViewsTable).go();
    });
  }
}

class ChatDataWithMembers {
  ChatDataWithMembers(
    this.chatData,
    this.members,
  );

  final ChatData chatData;
  final List<ChatMemberData> members;
}
