import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/sms_events.dart';
import 'components/sms_drift_mapper.dart';

class SmsRepository with SmsDriftMapper {
  SmsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  SmsDao get _smsDao => _appDatabase.smsDao;

  final StreamController<SmsEvent> _eventBus = StreamController.broadcast();
  Stream<SmsEvent> get eventBus => _eventBus.stream;
  _addEvent(SmsEvent event) => _eventBus.add(event);

  Future<SmsConversation?> getConversation(int conversationId) async {
    final conversationData = await _smsDao.getConversationById(conversationId);
    if (conversationData == null) return null;
    return conversationFromDrift(conversationData);
  }

  Future<List<SmsConversation>> getConversations() async {
    final conversationsData = await _smsDao.getAllConversations();
    return conversationsData.map(conversationFromDrift).toList();
  }

  Future<List<(SmsConversation, SmsMessage?)>> getConversationsWithLastMessages() async {
    final conversationsData = await _smsDao.getConversationsWithLastMessage();
    return conversationsData.map((data) => conversationWithLastMessageFromDrift(data)).toList();
  }

  Future<List<int>> getConversationIds() async {
    return _smsDao.getConversationIds();
  }

  Future<SmsConversation?> findConversationByPhoneNumber(String phoneNumber) async {
    final conversationData = await _smsDao.findConversationByPhoneNumber(phoneNumber);
    return conversationData != null ? conversationFromDrift(conversationData) : null;
  }

  Future<SmsConversation?> findConversationBetweenNumbers(String firstNumber, String secondNumber) async {
    final conversationData = await _smsDao.findConversationBetweenNumbers(firstNumber, secondNumber);
    return conversationData != null ? conversationFromDrift(conversationData) : null;
  }

  Future<void> upsertConversation(SmsConversation conversation) async {
    final conversationData = conversationToDrift(conversation);
    _smsDao.upsertConversation(conversationData);
    _addEvent(SmsConversationUpdate(conversation));
  }

  Future<void> deleteConversationById(int conversationId) async {
    await _smsDao.deleteConversationById(conversationId);
    _addEvent(SmsConversationRemove(conversationId));
  }

  Future<SmsMessage?> getMessageById(int messageId) async {
    final messageData = await _smsDao.getMessageById(messageId);
    return messageData != null ? messageFromDrift(messageData) : null;
  }

  Future<List<SmsMessage>> getMessageHistory(int conversationId,
      {DateTime? from, DateTime? to, int limit = 100}) async {
    final messagesData = await _smsDao.getMessageHistory(conversationId, from: from, to: to, limit: limit);
    return messagesData.map(messageFromDrift).toList();
  }

  Future<void> upsertMessage(SmsMessage message, {bool silent = false}) async {
    await _smsDao.upsertMessage(messageToDrift(message));
    if (!silent) _addEvent(SmsMessageUpdate(message));
  }

  Future<void> upsertMessages(Iterable<SmsMessage> messages, {bool silent = false}) async {
    await _smsDao.upsertMessages(messages.map(messageToDrift));
    if (!silent) {
      for (final message in messages) {
        _addEvent(SmsMessageUpdate(message));
      }
    }
  }

  Future<SmsMessageSyncCursor?> getMessageSyncCursor(int conversationId, SmsSyncCursorType cursorType) async {
    final type = messageSyncCursorTypeEnumToDrift(cursorType);
    final data = await _smsDao.getSyncCursor(conversationId, type);
    if (data != null) return messageSyncCursorFromDrift(data);
    return null;
  }

  Future<void> upsertSmsMessageSyncCursor(SmsMessageSyncCursor cursor) async {
    final data = messageSyncCursorToDrift(cursor);
    await _smsDao.upsertSyncCursor(data);
  }

  Future<List<String>> getUserSmsNumbers() async {
    final data = await _smsDao.getUserSmsNumbers();
    return data.map((e) => e.phoneNumber).toList();
  }

  Stream<List<String>> watchUserSmsNumbers() {
    return _smsDao.watchUserSmsNumbers().map((event) => event.map((e) => e.phoneNumber).toList());
  }

  Future<void> upsertUserSmsNumbers(List<String> numbers) async {
    final data = numbers.map((e) => UserSmsNumberData(phoneNumber: e)).toList();
    await _smsDao.upsertUserSmsNumbers(data);
  }

  Future<SmsMessageReadCursor?> getMessageReadCursor(int conversationId, String userId) async {
    final data = await _smsDao.getSmsMessageReadCursor(conversationId, userId);
    if (data != null) return messageReadCursorFromDrift(data);
    return null;
  }

  Stream<List<SmsMessageReadCursor>> watchMessageReadCursors(int conversationId) {
    return _smsDao
        .watchSmsMessageReadCursors(conversationId)
        .map((data) => data.map(messageReadCursorFromDrift).toList());
  }

  Future<void> upsertMessageReadCursor(SmsMessageReadCursor cursor) async {
    final data = SmsMessageReadCursorData(
      conversationId: cursor.conversationId,
      userId: cursor.userId,
      timestampUsec: cursor.time.microsecondsSinceEpoch,
    );

    final inserted = await _smsDao.upsertSmsMessageReadCursor(data);
    if (inserted != null) _addEvent(SmsReadCursorUpdate(cursor));
  }

  Future<Map<int, int>> unreadedCountPerConversation(String userId) {
    return _smsDao.unreadedCountPerConversation(userId);
  }

  Future<void> wipeData() async {
    await _smsDao.wipeData();
  }
}
