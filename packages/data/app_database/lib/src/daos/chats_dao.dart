import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'chats_dao.g.dart';

typedef ConversationDataWithLastMessage = (SmsConversationData conversation, SmsMessageData? lastMsg);

class ChatDataWithMembers {
  ChatDataWithMembers(this.chatData, this.members);

  final ChatData chatData;
  final List<ChatMemberData> members;
}

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

  Future<List<(ChatDataWithMembers chatdata, ChatMessageData? lastMsg)>> getAllChatsWithMembersAndLastMessage() async {
    final chatsData = await getAllChatsWithMembers();
    final result = <(ChatDataWithMembers chatdata, ChatMessageData? lastMsg)>[];

    for (final chatData in chatsData) {
      final lastMsgs = await getMessageHistory(chatData.chatData.id, limit: 1, skipDeleted: true);
      result.add((chatData, lastMsgs.firstOrNull));
    }

    return result;
  }

  Future<ChatDataWithMembers?> getChatWithMembers(int chatId) {
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
      return ChatDataWithMembers(chatData, members);
    });
  }

  Future upsertChatWithMembers(ChatDataWithMembers data) async {
    // Todo: replace with batch
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

  Future<ChatMessageData?> getMessageById(int id) {
    return (select(chatMessagesTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<ChatMessageData>> getMessageHistory(
    int chatId, {
    DateTime? from,
    DateTime? to,
    required int limit,
    skipDeleted = false,
  }) async {
    final q = select(chatMessagesTable);
    q.where((t) => t.chatId.equals(chatId));
    if (skipDeleted) q.where((t) => t.deletedAtRemoteUsec.isNull());
    if (from != null) q.where((t) => t.createdAtRemoteUsec.isSmallerThanValue(from.microsecondsSinceEpoch));
    if (to != null) q.where((t) => t.createdAtRemoteUsec.isBiggerOrEqualValue(to.microsecondsSinceEpoch));
    q.orderBy([(t) => OrderingTerm.desc(t.createdAtRemoteUsec), (t) => OrderingTerm.desc(t.id)]);
    q.limit(limit);
    return q.get();
  }

  Future<int?> upsertChatMessage(ChatMessageData chatMessage) async {
    return into(chatMessagesTable).insertOnConflictUpdate(chatMessage);
  }

  Future upsertChatMessages(Iterable<ChatMessageData> chatMessages) async {
    await batch((batch) => batch.insertAllOnConflictUpdate(chatMessagesTable, chatMessages));
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
    final userReadCursors = await (select(chatMessageReadCursorTable)..where((t) => t.userId.equals(userId))).get();
    Map<int, int> result = {};
    for (final cursor in userReadCursors) {
      final amount = chatMessagesTable.id.count();
      var q = (selectOnly(chatMessagesTable)..addColumns([amount]));
      q.where(
        chatMessagesTable.chatId.equals(cursor.chatId) &
            chatMessagesTable.senderId.isNotValue(userId) &
            chatMessagesTable.deletedAtRemoteUsec.isNull() &
            chatMessagesTable.createdAtRemoteUsec.isBiggerThanValue(cursor.timestampUsec),
      );
      final unreadMessages = await q.getSingle().then((data) => data.read(amount) ?? 0);
      result[cursor.chatId] = unreadMessages;
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
