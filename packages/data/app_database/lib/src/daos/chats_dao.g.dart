// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_dao.dart';

// ignore_for_file: type=lint
mixin _$ChatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ChatsTableTable get chatsTable => attachedDatabase.chatsTable;
  $ChatMembersTableTable get chatMembersTable =>
      attachedDatabase.chatMembersTable;
  $ChatMessagesTableTable get chatMessagesTable =>
      attachedDatabase.chatMessagesTable;
  $ChatMessageSyncCursorTableTable get chatMessageSyncCursorTable =>
      attachedDatabase.chatMessageSyncCursorTable;
  $ChatMessageReadCursorTableTable get chatMessageReadCursorTable =>
      attachedDatabase.chatMessageReadCursorTable;
  $ChatOutboxMessageTableTable get chatOutboxMessageTable =>
      attachedDatabase.chatOutboxMessageTable;
  $ChatOutboxMessageEditTableTable get chatOutboxMessageEditTable =>
      attachedDatabase.chatOutboxMessageEditTable;
  $ChatOutboxMessageDeleteTableTable get chatOutboxMessageDeleteTable =>
      attachedDatabase.chatOutboxMessageDeleteTable;
  $ChatOutboxReadCursorsTableTable get chatOutboxReadCursorsTable =>
      attachedDatabase.chatOutboxReadCursorsTable;
  ChatsDaoManager get managers => ChatsDaoManager(this);
}

class ChatsDaoManager {
  final _$ChatsDaoMixin _db;
  ChatsDaoManager(this._db);
  $$ChatsTableTableTableManager get chatsTable =>
      $$ChatsTableTableTableManager(_db.attachedDatabase, _db.chatsTable);
  $$ChatMembersTableTableTableManager get chatMembersTable =>
      $$ChatMembersTableTableTableManager(
        _db.attachedDatabase,
        _db.chatMembersTable,
      );
  $$ChatMessagesTableTableTableManager get chatMessagesTable =>
      $$ChatMessagesTableTableTableManager(
        _db.attachedDatabase,
        _db.chatMessagesTable,
      );
  $$ChatMessageSyncCursorTableTableTableManager
  get chatMessageSyncCursorTable =>
      $$ChatMessageSyncCursorTableTableTableManager(
        _db.attachedDatabase,
        _db.chatMessageSyncCursorTable,
      );
  $$ChatMessageReadCursorTableTableTableManager
  get chatMessageReadCursorTable =>
      $$ChatMessageReadCursorTableTableTableManager(
        _db.attachedDatabase,
        _db.chatMessageReadCursorTable,
      );
  $$ChatOutboxMessageTableTableTableManager get chatOutboxMessageTable =>
      $$ChatOutboxMessageTableTableTableManager(
        _db.attachedDatabase,
        _db.chatOutboxMessageTable,
      );
  $$ChatOutboxMessageEditTableTableTableManager
  get chatOutboxMessageEditTable =>
      $$ChatOutboxMessageEditTableTableTableManager(
        _db.attachedDatabase,
        _db.chatOutboxMessageEditTable,
      );
  $$ChatOutboxMessageDeleteTableTableTableManager
  get chatOutboxMessageDeleteTable =>
      $$ChatOutboxMessageDeleteTableTableTableManager(
        _db.attachedDatabase,
        _db.chatOutboxMessageDeleteTable,
      );
  $$ChatOutboxReadCursorsTableTableTableManager
  get chatOutboxReadCursorsTable =>
      $$ChatOutboxReadCursorsTableTableTableManager(
        _db.attachedDatabase,
        _db.chatOutboxReadCursorsTable,
      );
}
