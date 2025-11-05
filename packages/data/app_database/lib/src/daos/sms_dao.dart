import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'sms_dao.g.dart';

@DriftAccessor(tables: [
  SmsConversationsTable,
  SmsMessagesTable,
  SmsMessageSyncCursorTable,
  SmsMessageReadCursorTable,
  SmsOutboxMessagesTable,
  SmsOutboxMessageDeleteTable,
  SmsOutboxReadCursorsTable,
  UserSmsNumbersTable,
])
class SmsDao extends DatabaseAccessor<AppDatabase> with _$SmsDaoMixin {
  SmsDao(super.db);

  // Conversations

  Future<SmsConversationData?> getConversationById(int id) {
    return (select(smsConversationsTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<SmsConversationData>> getAllConversations() {
    return select(smsConversationsTable).get();
  }

  Future<List<int>> getConversationIds() {
    final q = customSelect('SELECT id FROM sms_conversations');
    return q
        .get()
        .then((rows) => rows.map((row) => row.data['id'] as int).toList());
  }

  Future<List<ConversationDataWithLastMessage>>
      getConversationsWithLastMessage() async {
    final conversations = await getAllConversations();
    final result = <ConversationDataWithLastMessage>[];

    for (final conversation in conversations) {
      final lastMsgs =
          await getMessageHistory(conversation.id, limit: 1, skipDeleted: true);
      result.add((conversation, lastMsgs.firstOrNull));
    }

    return result;
  }

  Future<SmsConversationData?> findConversationByPhoneNumber(
      String phoneNumber) {
    return (select(smsConversationsTable)
          ..where((t) =>
              t.firstPhoneNumber.equals(phoneNumber) |
              t.secondPhoneNumber.equals(phoneNumber)))
        .getSingleOrNull();
  }

  Future<SmsConversationData?> findConversationBetweenNumbers(
      String firstNumber, String secondNumber) {
    return (select(smsConversationsTable)
          ..where((t) =>
              t.firstPhoneNumber.isIn([firstNumber, secondNumber]) &
              t.secondPhoneNumber.isIn([firstNumber, secondNumber])))
        .getSingleOrNull();
  }

  Future<int> upsertConversation(
      Insertable<SmsConversationData> smsConversation) {
    return into(smsConversationsTable).insertOnConflictUpdate(smsConversation);
  }

  Future<int> deleteConversationById(int id) {
    return (delete(smsConversationsTable)..where((t) => t.id.equals(id))).go();
  }

  // Messages

  Future<SmsMessageData?> getMessageById(int id) {
    return (select(smsMessagesTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<SmsMessageData>> getMessageHistory(
    int conversationId, {
    DateTime? from,
    DateTime? to,
    required int limit,
    skipDeleted = false,
  }) async {
    final q = select(smsMessagesTable);
    q.where((t) => t.conversationId.equals(conversationId));
    if (skipDeleted) q.where((t) => t.deletedAtRemoteUsec.isNull());
    if (from != null)
      q.where((t) => t.createdAtRemoteUsec
          .isSmallerThanValue(from.microsecondsSinceEpoch));
    if (to != null)
      q.where((t) => t.createdAtRemoteUsec
          .isBiggerOrEqualValue(to.microsecondsSinceEpoch));
    q.orderBy([
      (t) => OrderingTerm.desc(t.createdAtRemoteUsec),
      (t) => OrderingTerm.desc(t.id)
    ]);
    q.limit(limit);
    return q.get();
  }

  Future<int?> upsertMessage(SmsMessageData smsMessage) async {
    return into(smsMessagesTable).insertOnConflictUpdate(smsMessage);
  }

  Future upsertMessages(Iterable<SmsMessageData> smsMessages) async {
    await batch((batch) =>
        batch.insertAllOnConflictUpdate(smsMessagesTable, smsMessages));
  }

  // Message read cursors

  Future<SmsMessageReadCursorData?> upsertSmsMessageReadCursor(
      SmsMessageReadCursorData smsMessageReadCursor) {
    return into(smsMessageReadCursorTable).insertReturningOrNull(
      smsMessageReadCursor,
      mode: InsertMode.insertOrReplace,
      onConflict: DoUpdate(
        (_) => smsMessageReadCursor,
        target: [
          smsMessageReadCursorTable.conversationId,
          smsMessageReadCursorTable.userId
        ],
        where: (old) => old.timestampUsec
            .isSmallerOrEqualValue(smsMessageReadCursor.timestampUsec),
      ),
    );
  }

  Future<SmsMessageReadCursorData?> getSmsMessageReadCursor(
      int conversationId, String userId) async {
    return (select(smsMessageReadCursorTable)
          ..where((t) =>
              t.conversationId.equals(conversationId) &
              t.userId.equals(userId)))
        .getSingleOrNull();
  }

  Stream<List<SmsMessageReadCursorData>> watchSmsMessageReadCursors(
      int conversationId) {
    return (select(smsMessageReadCursorTable)
          ..where((t) => t.conversationId.equals(conversationId)))
        .watch();
  }

  Future<Map<int, int>> unreadedCountPerConversation(String userId) async {
    final userNumbers =
        (await getUserSmsNumbers()).map((e) => e.phoneNumber).toList();
    final result = <int, int>{};

    for (final conversationId in await getConversationIds()) {
      final readCursor = await getSmsMessageReadCursor(conversationId, userId);

      final amount = smsMessagesTable.id.count();
      final q = (selectOnly(smsMessagesTable)..addColumns([amount]));

      q.where(
        smsMessagesTable.conversationId.equals(conversationId) &
            smsMessagesTable.fromPhoneNumber.isNotIn(userNumbers) &
            smsMessagesTable.deletedAtRemoteUsec.isNull() &
            smsMessagesTable.createdAtRemoteUsec
                .isBiggerThanValue(readCursor?.timestampUsec ?? 0),
      );

      final unreadMessages =
          await q.getSingle().then((data) => data.read(amount) ?? 0);
      result[conversationId] = unreadMessages;
    }

    return result;
  }

  // Sync cursors

  Future<SmsMessageSyncCursorData?> getSyncCursor(
      int conversationId, SmsSyncCursorTypeEnum cursorType) {
    return (select(smsMessageSyncCursorTable)
          ..where((t) =>
              t.conversationId.equals(conversationId) &
              t.cursorType.equals(cursorType.name)))
        .getSingleOrNull();
  }

  Future<int> upsertSyncCursor(
      Insertable<SmsMessageSyncCursorData> smsMessageSyncCursor) {
    return into(smsMessageSyncCursorTable)
        .insertOnConflictUpdate(smsMessageSyncCursor);
  }

  // Outbox messages

  Future<List<SmsOutboxMessageData>> getOutboxMessages() {
    return select(smsOutboxMessagesTable).get();
  }

  Stream<List<SmsOutboxMessageData>> watchOutboxMessages() {
    return select(smsOutboxMessagesTable).watch();
  }

  Future<int> upsertOutboxMessage(
      Insertable<SmsOutboxMessageData> smsOutboxMessage) {
    return into(smsOutboxMessagesTable)
        .insertOnConflictUpdate(smsOutboxMessage);
  }

  Future<int> deleteOutboxMessage(String idKey) {
    return (delete(smsOutboxMessagesTable)..where((t) => t.idKey.equals(idKey)))
        .go();
  }

  // Outbox message deletes

  Future<List<SmsOutboxMessageDeleteData>> getOutboxMessageDeletes() {
    return select(smsOutboxMessageDeleteTable).get();
  }

  Stream<List<SmsOutboxMessageDeleteData>> watchOutboxMessageDeletes() {
    return select(smsOutboxMessageDeleteTable).watch();
  }

  Future<int> upsertOutboxMessageDelete(
      Insertable<SmsOutboxMessageDeleteData> smsOutboxMessageDelete) {
    return into(smsOutboxMessageDeleteTable)
        .insertOnConflictUpdate(smsOutboxMessageDelete);
  }

  Future<int> deleteOutboxMessageDelete(int id) {
    return (delete(smsOutboxMessageDeleteTable)..where((t) => t.id.equals(id)))
        .go();
  }

  // Read cursors outbox

  Future<SmsOutboxReadCursorData?> getSmsOutboxReadCursor(int conversationId) {
    return (select(smsOutboxReadCursorsTable)
          ..where((t) => t.conversationId.equals(conversationId)))
        .getSingleOrNull();
  }

  Stream<SmsOutboxReadCursorData?> watchSmsOutboxReadCursor(
      int conversationId) {
    return (select(smsOutboxReadCursorsTable)
          ..where((t) => t.conversationId.equals(conversationId)))
        .watchSingleOrNull();
  }

  Future<List<SmsOutboxReadCursorData>> getSmsOutboxReadCursors() {
    return select(smsOutboxReadCursorsTable).get();
  }

  Stream<List<SmsOutboxReadCursorData>> watchSmsOutboxReadCursors() {
    return select(smsOutboxReadCursorsTable).watch();
  }

  Future upsertSmsOutboxReadCursor(SmsOutboxReadCursorData newCursor) async {
    return await into(smsOutboxReadCursorsTable).insert(
      newCursor,
      mode: InsertMode.insertOrReplace,
      onConflict: DoUpdate(
        (_) => newCursor,
        target: [smsOutboxReadCursorsTable.conversationId],
        where: (old) =>
            old.timestampUsec.isSmallerThanValue(newCursor.timestampUsec),
      ),
    );
  }

  Future<int> deleteSmsOutboxReadCursor(int conversationId) {
    return (delete(smsOutboxReadCursorsTable)
          ..where((t) => t.conversationId.equals(conversationId)))
        .go();
  }

  // User sms numbers

  Future<List<UserSmsNumberData>> getUserSmsNumbers() {
    return select(userSmsNumbersTable).get();
  }

  Stream<List<UserSmsNumberData>> watchUserSmsNumbers() {
    return select(userSmsNumbersTable).watch();
  }

  Future upsertUserSmsNumbers(
      Iterable<UserSmsNumberData> userSmsNumbers) async {
    return batch((batch) {
      batch.deleteWhere(
          userSmsNumbersTable,
          (t) =>
              t.phoneNumber.isNotIn(userSmsNumbers.map((e) => e.phoneNumber)));
      batch.insertAllOnConflictUpdate(userSmsNumbersTable, userSmsNumbers);
    });
  }

  Future<void> wipeData() async {
    await transaction(() async {
      await delete(smsConversationsTable).go();
      await delete(smsMessagesTable).go();
      await delete(smsOutboxMessagesTable).go();
      await delete(smsMessageSyncCursorTable).go();
      await delete(smsMessageReadCursorTable).go();
    });
  }

  Future<void> wipeOutboxData() async {
    await transaction(() async {
      await delete(smsOutboxMessagesTable).go();
      await delete(smsOutboxMessageDeleteTable).go();
      await delete(smsOutboxReadCursorsTable).go();
    });
  }
}
