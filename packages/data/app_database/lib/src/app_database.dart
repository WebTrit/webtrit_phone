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
    ChatMessagesTable
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
        for (var version = from; version < to; version++) {
          await migrations[version - 1].execute(this, m);
        }

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

  TextColumn get creatorId => text()();

  DateTimeColumn get createdAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();

  DateTimeColumn get deletedAtRemote => dateTime().nullable()();
}

@DataClassName('ChatMemberData')
class ChatMembersTable extends Table {
  @override
  String get tableName => 'chat_members';

  @override
  Set<Column> get primaryKey => {chatId, userId};

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get userId => text()();

  DateTimeColumn get joinedAt => dateTime()();

  DateTimeColumn get leftAt => dateTime().nullable()();

  DateTimeColumn get blockedAt => dateTime().nullable()();
}

enum SmsOutStateEnum { sending, error, delivered }

@DataClassName('ChatMessageData')
class ChatMessagesTable extends Table {
  @override
  String get tableName => 'chat_messages';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  TextColumn get senderId => text()();

  IntColumn get chatId => integer().references(ChatsTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get replyToId => integer().nullable()();

  IntColumn get forwardFromId => integer().nullable()();

  TextColumn get authorId => text().nullable()();

  BoolColumn get viaSms => boolean().withDefault(const Constant(false))();

  TextColumn get smsOutState => textEnum<SmsOutStateEnum>().nullable()();

  TextColumn get smsNumber => text().nullable()();

  TextColumn get content => text()();

  DateTimeColumn get createdAtRemote => dateTime()();

  DateTimeColumn get updatedAtRemote => dateTime()();

  DateTimeColumn get deletedAtRemote => dateTime().nullable()();
}

@DriftAccessor(tables: [
  ContactsTable,
  ContactPhonesTable,
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
        ].map((c) => c.like('%$searchBit%')).reduce((v, e) => v | e),
      );
    }
    q.groupBy([contactPhonesTable.contactId]);
    return q.watch().map((rows) => rows.map((row) => row.readTable(contactsTable)).toList());
  }

  Stream<ContactData> watchContact(Insertable<ContactData> contact) {
    return (select(contactsTable)..whereSamePrimaryKey(contact)).watchSingle();
  }

  Future<Set<String>> getIdsBySourceType(ContactSourceTypeEnum sourceType) async {
    final rawResult = await (select(contactsTable)
          ..where(
            (t) => t.sourceType.equals(sourceType.index),
          ))
        .map((row) => row.id)
        .get();
    return rawResult.map((e) => e.toString()).toSet();
  }

  Future<ContactData> insertOnUniqueConflictUpdateContact(Insertable<ContactData> contact) =>
      into(contactsTable).insertReturning(contact,
          onConflict: DoUpdate((_) => contact, target: [contactsTable.sourceType, contactsTable.sourceId]));

  Future<int> deleteContact(Insertable<ContactData> contact) => delete(contactsTable).delete(contact);

  Future<int> deleteContactBySource(ContactSourceTypeEnum sourceType, String sourceId) =>
      (delete(contactsTable)..where((t) => t.sourceType.equalsValue(sourceType) & t.sourceId.equals(sourceId))).go();
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
])
class ChatsDao extends DatabaseAccessor<AppDatabase> with _$ChatsDaoMixin {
  ChatsDao(super.db);

  // Chats

  Future<List<ChatData>> getAllChats() => select(chatsTable).get();

  Stream<List<ChatData>> watchAllChats() => select(chatsTable).watch();

  Stream<ChatData> watchChat(Insertable<ChatData> chat) {
    return (select(chatsTable)..whereSamePrimaryKey(chat)).watchSingle();
  }

  Future<int> upsertChat(Insertable<ChatData> chat) {
    return into(chatsTable).insertOnConflictUpdate(chat);
  }

  Future<void> wipeStaleDeletedChatsData({int ttlSeconds = 60 * 60 * 24}) async {
    final staleTime = clock.now().subtract(Duration(seconds: ttlSeconds));
    await (delete(chatsTable)..where((t) => t.deletedAtRemote.isSmallerThanValue(staleTime))).go();
  }

  // ChatMembers

  Stream<List<ChatMemberData>> watchChatMembersByChatId(int chatId) {
    return (select(chatMembersTable)..where((t) => t.chatId.equals(chatId))).watch();
  }

  Future<List<ChatMemberData>> getChatMembersByChatId(int chatId) {
    return (select(chatMembersTable)..where((t) => t.chatId.equals(chatId))).get();
  }

  Future<int> upsertChatMember(Insertable<ChatMemberData> chatMember) {
    return into(chatMembersTable).insertOnConflictUpdate(chatMember);
  }

  Future<int> deleteChatMember(Insertable<ChatMemberData> chatMember) {
    return delete(chatMembersTable).delete(chatMember);
  }

  // ChatDataWithMembers

  Stream<List<ChatDataWithMembers>> watchAllChatsWithMembers() {
    final q = select(chatsTable).join([
      leftOuterJoin(chatMembersTable, chatMembersTable.chatId.equalsExp(chatsTable.id)),
    ]);
    q.groupBy([chatsTable.id]);
    return q.watch().map((rows) {
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

  Future<List<ChatDataWithMembers>> getAllChatsWithMembers() {
    final q = select(chatsTable).join([
      leftOuterJoin(chatMembersTable, chatMembersTable.chatId.equalsExp(chatsTable.id)),
    ]);
    q.groupBy([chatsTable.id]);
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

  // ChatMessages

  Future<List<ChatMessageData>> getLastMessages(int chatId, {int limit = 100}) {
    final q = (select(chatMessagesTable)
      ..where((t) => t.chatId.equals(chatId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAtRemote)])
      ..limit(limit));
    return q.get();
  }

  Future<List<ChatMessageData>> getMessageHistory(int chatId, DateTime from, DateTime to) {
    final q = select(chatMessagesTable)
      ..where((t) => t.chatId.equals(chatId))
      ..where((t) => t.createdAtRemote.isBetweenValues(from, to));
    return q.get();
  }

  Stream<List<ChatMessageData>> watchLastMessageUpdates(int chatId, {int limit = 100}) {
    final q = (select(chatMessagesTable)
      ..where((t) => t.chatId.equals(chatId))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAtRemote)])
      ..limit(limit));
    return q.watch();
  }

  Future<int> upsertChatMessage(Insertable<ChatMessageData> chatMessage) {
    return into(chatMessagesTable).insertOnConflictUpdate(chatMessage);
  }

  Future<void> wipeStaleDeletedChatMessagesData({int ttlSeconds = 60 * 60 * 24}) async {
    final staleTime = clock.now().subtract(Duration(seconds: ttlSeconds));
    await (delete(chatMessagesTable)..where((t) => t.deletedAtRemote.isSmallerThanValue(staleTime))).go();
  }

  Future<void> wipeChatsData() async {
    await transaction(() async {
      await delete(chatsTable).go();
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
