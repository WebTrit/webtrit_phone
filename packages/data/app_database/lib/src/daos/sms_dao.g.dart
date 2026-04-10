// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_dao.dart';

// ignore_for_file: type=lint
mixin _$SmsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SmsConversationsTableTable get smsConversationsTable =>
      attachedDatabase.smsConversationsTable;
  $SmsMessagesTableTable get smsMessagesTable =>
      attachedDatabase.smsMessagesTable;
  $SmsMessageSyncCursorTableTable get smsMessageSyncCursorTable =>
      attachedDatabase.smsMessageSyncCursorTable;
  $SmsMessageReadCursorTableTable get smsMessageReadCursorTable =>
      attachedDatabase.smsMessageReadCursorTable;
  $SmsOutboxMessagesTableTable get smsOutboxMessagesTable =>
      attachedDatabase.smsOutboxMessagesTable;
  $SmsOutboxMessageDeleteTableTable get smsOutboxMessageDeleteTable =>
      attachedDatabase.smsOutboxMessageDeleteTable;
  $SmsOutboxReadCursorsTableTable get smsOutboxReadCursorsTable =>
      attachedDatabase.smsOutboxReadCursorsTable;
  $UserSmsNumbersTableTable get userSmsNumbersTable =>
      attachedDatabase.userSmsNumbersTable;
  SmsDaoManager get managers => SmsDaoManager(this);
}

class SmsDaoManager {
  final _$SmsDaoMixin _db;
  SmsDaoManager(this._db);
  $$SmsConversationsTableTableTableManager get smsConversationsTable =>
      $$SmsConversationsTableTableTableManager(
        _db.attachedDatabase,
        _db.smsConversationsTable,
      );
  $$SmsMessagesTableTableTableManager get smsMessagesTable =>
      $$SmsMessagesTableTableTableManager(
        _db.attachedDatabase,
        _db.smsMessagesTable,
      );
  $$SmsMessageSyncCursorTableTableTableManager get smsMessageSyncCursorTable =>
      $$SmsMessageSyncCursorTableTableTableManager(
        _db.attachedDatabase,
        _db.smsMessageSyncCursorTable,
      );
  $$SmsMessageReadCursorTableTableTableManager get smsMessageReadCursorTable =>
      $$SmsMessageReadCursorTableTableTableManager(
        _db.attachedDatabase,
        _db.smsMessageReadCursorTable,
      );
  $$SmsOutboxMessagesTableTableTableManager get smsOutboxMessagesTable =>
      $$SmsOutboxMessagesTableTableTableManager(
        _db.attachedDatabase,
        _db.smsOutboxMessagesTable,
      );
  $$SmsOutboxMessageDeleteTableTableTableManager
  get smsOutboxMessageDeleteTable =>
      $$SmsOutboxMessageDeleteTableTableTableManager(
        _db.attachedDatabase,
        _db.smsOutboxMessageDeleteTable,
      );
  $$SmsOutboxReadCursorsTableTableTableManager get smsOutboxReadCursorsTable =>
      $$SmsOutboxReadCursorsTableTableTableManager(
        _db.attachedDatabase,
        _db.smsOutboxReadCursorsTable,
      );
  $$UserSmsNumbersTableTableTableManager get userSmsNumbersTable =>
      $$UserSmsNumbersTableTableTableManager(
        _db.attachedDatabase,
        _db.userSmsNumbersTable,
      );
}
