import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'chats_dao.g.dart';

@DriftAccessor(tables: [
  ChatsTable,
  ChatMembersTable,
  ChatMessagesTable,
  ChatMessageSyncCursorTable,
  ChatMessageReadCursorTable,
  ChatOutboxMessageTable,
  ChatOutboxMessageEditTable,
  ChatOutboxMessageDeleteTable,
  ChatOutboxReadCursorsTable,
  OutboxAttachmentTable,
  MessageAttachmentTable,
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
    var variables = [Variable.withString(ChatTypeEnum.direct.name), Variable.withString(participantId)];
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
  Future<List<(ChatData, List<ChatMemberData>)>> getAllChatsWithMembers() {
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
        return (chat, members.where((m) => m.chatId == chat.id).toList());
      }).toList();
    });
  }

  Future<List<(ChatData, List<ChatMemberData>, (ChatMessageData, List<MessageAttachmentData>)?)>>
      getAllChatsWithMembersAndLastMessage() async {
    final chats = await getAllChatsWithMembers();
    final result = <(ChatData, List<ChatMemberData>, (ChatMessageData, List<MessageAttachmentData>)?)>[];

    for (final (chat, members) in chats) {
      final lastMsgs = await getMessageHistory(chat.id, limit: 1, skipDeleted: true);
      result.add((chat, members, lastMsgs.firstOrNull));
    }

    return result;
  }

  Future<(ChatData, List<ChatMemberData>)?> getChatWithMembers(int chatId) {
    final q = select(chatsTable).join([
      leftOuterJoin(chatMembersTable, chatMembersTable.chatId.equalsExp(chatsTable.id)),
    ]);
    q.where(chatsTable.id.equals(chatId));
    return q.get().then((rows) {
      ChatData? chatData;
      final members = <ChatMemberData>[];
      for (final row in rows) {
        final chatResult = row.readTableOrNull(chatsTable);
        if (chatResult != null) chatData = chatResult;

        final memberResult = row.readTableOrNull(chatMembersTable);
        if (memberResult != null) members.add(memberResult);
      }

      if (chatData == null) return null;
      return (chatData, members);
    });
  }

  Future upsertChatWithMembers(ChatData chat, List<ChatMemberData> members) async {
    // Todo: replace with batch
    await transaction(() async {
      final currentChatMembers = await getChatMembersByChatId(chat.id);
      final membersToDelete = currentChatMembers.where((m) => !members.any((newM) => newM.userId == m.userId));
      final membersToUpsert = members;
      await upsertChat(chat);
      for (final member in membersToDelete) {
        await deleteChatMember(member);
      }
      for (final member in membersToUpsert) {
        await upsertChatMember(member);
      }
    });
  }

  // ChatMessages

  Future<(ChatMessageData, List<MessageAttachmentData>)?> getMessageById(int id) {
    final q = select(chatMessagesTable).join([
      leftOuterJoin(messageAttachmentTable, messageAttachmentTable.chatsMessageId.equalsExp(chatMessagesTable.id)),
    ]);
    q.where(chatMessagesTable.id.equals(id));
    return q.get().then((rows) {
      if (rows.isEmpty) return null;
      final message = rows.first.readTable(chatMessagesTable);
      final attachments = rows
          .map((row) {
            return row.readTableOrNull(messageAttachmentTable);
          })
          .whereType<MessageAttachmentData>()
          .toList();
      return (message, attachments);
    });
  }

  Future<List<(ChatMessageData, List<MessageAttachmentData>)>> getMessageHistory(
    int chatId, {
    DateTime? from,
    DateTime? to,
    required int limit,
    skipDeleted = false,
  }) async {
    final q = select(chatMessagesTable).join([
      leftOuterJoin(messageAttachmentTable, messageAttachmentTable.chatsMessageId.equalsExp(chatMessagesTable.id)),
    ]);

    q.where(chatMessagesTable.chatId.equals(chatId));
    if (skipDeleted) q.where(chatMessagesTable.deletedAtRemoteUsec.isNull());
    if (from != null) q.where(chatMessagesTable.createdAtRemoteUsec.isSmallerThanValue(from.microsecondsSinceEpoch));
    if (to != null) q.where(chatMessagesTable.createdAtRemoteUsec.isBiggerOrEqualValue(to.microsecondsSinceEpoch));
    q.orderBy([
      OrderingTerm.desc(chatMessagesTable.createdAtRemoteUsec),
      OrderingTerm.desc(chatMessagesTable.id),
    ]);
    q.limit(limit);

    return q.get().then((rows) {
      final messages = <ChatMessageData>[];
      final attachments = <MessageAttachmentData>[];
      for (final row in rows) {
        final message = row.readTable(chatMessagesTable);
        if (!messages.contains(message)) messages.add(message);

        final attachment = row.readTableOrNull(messageAttachmentTable);
        if (attachment != null) attachments.add(attachment);
      }
      return messages.map((message) {
        return (message, attachments.where((a) => a.chatsMessageId == message.id).toList());
      }).toList();
    });
  }

  Future upsertChatMessage((ChatMessageData, List<MessageAttachmentData>) data) async {
    final (message, attachments) = data;
    await batch(
      (batch) {
        batch.insertAllOnConflictUpdate(chatMessagesTable, [message]);
        batch.deleteWhere(
          messageAttachmentTable,
          (t) => t.chatsMessageId.equals(message.id) & t.id.isNotIn(attachments.map((e) => e.id)),
        );
        batch.insertAllOnConflictUpdate(messageAttachmentTable, attachments);
      },
    );
  }

  Future upsertChatMessages(Iterable<(ChatMessageData, List<MessageAttachmentData>)> data) async {
    await batch((batch) {
      for (final (message, attachments) in data) {
        batch.insertAllOnConflictUpdate(chatMessagesTable, [message]);
        batch.deleteWhere(
          messageAttachmentTable,
          (t) => t.chatsMessageId.equals(message.id) & t.id.isNotIn(attachments.map((e) => e.id)),
        );
        batch.insertAllOnConflictUpdate(messageAttachmentTable, attachments);
      }
    });
  }

  // Message read cursors

  Future<ChatMessageReadCursorData?> upsertChatMessageReadCursor(ChatMessageReadCursorData chatMessageReadCursor) {
    return into(chatMessageReadCursorTable).insertReturningOrNull(
      chatMessageReadCursor,
      mode: InsertMode.insertOrReplace,
      onConflict: DoUpdate(
        (_) => chatMessageReadCursor,
        target: [chatMessageReadCursorTable.chatId, chatMessageReadCursorTable.userId],
        where: (old) => old.timestampUsec.isSmallerOrEqualValue(chatMessageReadCursor.timestampUsec),
      ),
    );
  }

  Future<ChatMessageReadCursorData?> getChatMessageReadCursor(int chatId, String userId) async {
    return (select(chatMessageReadCursorTable)..where((t) => t.chatId.equals(chatId) & t.userId.equals(userId)))
        .getSingleOrNull();
  }

  Stream<List<ChatMessageReadCursorData>> watchChatMessageReadCursors(int chatId) {
    return (select(chatMessageReadCursorTable)..where((t) => t.chatId.equals(chatId))).watch();
  }

  Future<Map<int, int>> unreadedCountPerChat(String userId) async {
    final result = <int, int>{};

    for (final chatId in await getChatIds()) {
      final readCursor = await getChatMessageReadCursor(chatId, userId);

      final amount = chatMessagesTable.id.count();
      var q = (selectOnly(chatMessagesTable)..addColumns([amount]));

      q.where(
        chatMessagesTable.chatId.equals(chatId) &
            chatMessagesTable.senderId.isNotValue(userId) &
            chatMessagesTable.deletedAtRemoteUsec.isNull() &
            chatMessagesTable.createdAtRemoteUsec.isBiggerThanValue(readCursor?.timestampUsec ?? 0),
      );

      final unreadMessages = await q.getSingle().then((data) => data.read(amount) ?? 0);
      result[chatId] = unreadMessages;
    }

    return result;
  }

  // Message sync cursors

  Future<ChatMessageSyncCursorData?> getChatMessageSyncCursor(int chatId, MessageSyncCursorTypeEnum cursorType) {
    return (select(chatMessageSyncCursorTable)
          ..where((t) => t.chatId.equals(chatId) & t.cursorType.equals(cursorType.name)))
        .getSingleOrNull();
  }

  Future<int> upsertChatMessageSyncCursor(Insertable<ChatMessageSyncCursorData> chatMessageSyncCursor) {
    return into(chatMessageSyncCursorTable).insertOnConflictUpdate(chatMessageSyncCursor);
  }

  // Messages outbox

  Future<List<(ChatOutboxMessageData, List<OutboxAttachmentData>)>> getChatOutboxMessages() {
    return (select(chatOutboxMessageTable))
        .join([
          leftOuterJoin(
            outboxAttachmentTable,
            outboxAttachmentTable.chatsOutboxMessageIdKey.equalsExp(chatOutboxMessageTable.idKey),
          ),
        ])
        .get()
        .then((rows) {
          final messages = <ChatOutboxMessageData>{};
          final attachments = <OutboxAttachmentData>{};
          for (final row in rows) {
            final message = row.readTable(chatOutboxMessageTable);
            messages.add(message);

            final attachment = row.readTableOrNull(outboxAttachmentTable);
            if (attachment != null) attachments.add(attachment);
          }
          return messages.map((message) {
            return (message, attachments.where((a) => a.chatsOutboxMessageIdKey == message.idKey).toList());
          }).toList();
        });
  }

  Stream<List<(ChatOutboxMessageData, List<OutboxAttachmentData>)>> watchChatOutboxMessages() {
    return (select(chatOutboxMessageTable)
        .join([
          leftOuterJoin(
            outboxAttachmentTable,
            outboxAttachmentTable.chatsOutboxMessageIdKey.equalsExp(chatOutboxMessageTable.idKey),
          ),
        ])
        .watch()
        .map((rows) {
          final messages = <ChatOutboxMessageData>[];
          final attachments = <OutboxAttachmentData>[];
          for (final row in rows) {
            final message = row.readTable(chatOutboxMessageTable);
            if (!messages.contains(message)) messages.add(message);

            final attachment = row.readTableOrNull(outboxAttachmentTable);
            if (attachment != null) attachments.add(attachment);
          }
          return messages.map((message) {
            return (message, attachments.where((a) => a.chatsOutboxMessageIdKey == message.idKey).toList());
          }).toList();
        }));
  }

  Future upsertChatOutboxMessage((ChatOutboxMessageData, List<OutboxAttachmentData>) data) async {
    final (message, attachments) = data;
    await batch((batch) {
      batch.insertAllOnConflictUpdate(chatOutboxMessageTable, [message]);
      batch.insertAllOnConflictUpdate(outboxAttachmentTable, attachments);
    });
  }

  Future deleteChatOutboxMessage(String idKey) async {
    await batch((batch) {
      batch.deleteWhere(chatOutboxMessageTable, (t) => t.idKey.equals(idKey));
      batch.deleteWhere(outboxAttachmentTable, (t) => t.chatsOutboxMessageIdKey.equals(idKey));
    });
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

  // Read cursors outbox

  Future<ChatOutboxReadCursorData?> getChatOutboxReadCursor(int chatId) {
    return (select(chatOutboxReadCursorsTable)..where((t) => t.chatId.equals(chatId))).getSingleOrNull();
  }

  Stream<ChatOutboxReadCursorData?> watchChatOutboxReadCursor(int chatId) {
    return (select(chatOutboxReadCursorsTable)..where((t) => t.chatId.equals(chatId))).watchSingleOrNull();
  }

  Future<List<ChatOutboxReadCursorData>> getChatOutboxReadCursors() {
    return select(chatOutboxReadCursorsTable).get();
  }

  Stream<List<ChatOutboxReadCursorData>> watchChatOutboxReadCursors() {
    return select(chatOutboxReadCursorsTable).watch();
  }

  Future upsertChatOutboxReadCursor(ChatOutboxReadCursorData newCursor) async {
    return await into(chatOutboxReadCursorsTable).insert(
      newCursor,
      mode: InsertMode.insertOrReplace,
      onConflict: DoUpdate(
        (_) => newCursor,
        target: [chatOutboxReadCursorsTable.chatId],
        where: (old) => old.timestampUsec.isSmallerThanValue(newCursor.timestampUsec),
      ),
    );
  }

  Future<int> deleteChatOutboxReadCursor(int chatId) {
    return (delete(chatOutboxReadCursorsTable)..where((t) => t.chatId.equals(chatId))).go();
  }

  // Message attachments

  Future<List<OutboxAttachmentData>> getOutboxAttachmentsByMessageId(String messageId) {
    return (select(outboxAttachmentTable)..where((t) => t.chatsOutboxMessageIdKey.equals(messageId))).get();
  }

  Future<List<MessageAttachmentData>> getAttachmentsForLastMessages(int chatId, int msgLimit) {
    final q = select(messageAttachmentTable)
      ..where((t) => t.chatsMessageId.isInQuery(
            selectOnly(chatMessagesTable)
              ..addColumns([chatMessagesTable.id])
              ..where(chatMessagesTable.chatId.equals(chatId))
              ..orderBy([
                OrderingTerm.desc(chatMessagesTable.createdAtRemoteUsec),
                OrderingTerm.desc(chatMessagesTable.id),
              ])
              ..limit(msgLimit),
          ));
    return q.get();
  }

  // Service

  Future<void> wipeStaleDeletedChatMessagesData({int ttlSeconds = 60 * 60 * 24}) async {
    final staleTime = clock.now().subtract(Duration(seconds: ttlSeconds));
    await (delete(chatMessagesTable)
          ..where((t) => t.deletedAtRemoteUsec.isSmallerThanValue(staleTime.microsecondsSinceEpoch)))
        .go();
  }

  Future<void> wipeChatsData() async {
    await transaction(() async {
      await delete(chatsTable).go();
      await delete(chatMembersTable).go();
      await delete(chatMessagesTable).go();
      await delete(chatMessageSyncCursorTable).go();
      await delete(chatMessageReadCursorTable).go();
    });
  }

  Future<void> wipeOutboxMessagesData() async {
    await transaction(() async {
      await delete(chatOutboxMessageTable).go();
      await delete(chatOutboxMessageEditTable).go();
      await delete(chatOutboxMessageDeleteTable).go();
      await delete(chatOutboxReadCursorsTable).go();
    });
  }
}
