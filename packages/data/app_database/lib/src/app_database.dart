import 'package:drift/drift.dart';

import 'daos/daos.dart';
import 'migrations/migrations.dart';
import 'tables/tables.dart';

export 'daos/daos.dart';
export 'tables/tables.dart';

part 'app_database.g.dart';

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
    ChatMessageSyncCursorTable,
    ChatMessageReadCursorTable,
    ChatOutboxMessageTable,
    ChatOutboxMessageEditTable,
    ChatOutboxMessageDeleteTable,
    ChatOutboxReadCursorsTable,
    SmsConversationsTable,
    SmsMessagesTable,
    SmsMessageSyncCursorTable,
    SmsMessageReadCursorTable,
    SmsOutboxMessagesTable,
    SmsOutboxMessageDeleteTable,
    SmsOutboxReadCursorsTable,
    UserSmsNumbersTable,
    ActiveMessageNotificationsTable,
    VoicemailTable,
    SystemNotificationsTable,
    SystemNotificationsOutboxTable,
    PresenceInfoTable,
    CdrTable,
  ],
  daos: [
    ContactsDao,
    ContactPhonesDao,
    ContactEmailsDao,
    CallLogsDao,
    RecentsDao,
    FavoritesDao,
    ChatsDao,
    SmsDao,
    ActiveMessageNotificationsDao,
    VoicemailDao,
    SystemNotificationsDao,
    PresenceInfoDao,
    CdrsDao,
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

        if (to < from) {
          // Perform a clean downgrade of the database when the app is downgraded from a newer test flight version to an older production version.
          // This ensures that the database schema is compatible with the older version by removing all existing tables.
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }

          await m.createAll();
        } else {
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
