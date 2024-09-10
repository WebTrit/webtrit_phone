import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/chats_outbox_drift_mapper.dart';

class ChatsOutboxRepository with ChatsOutboxDriftMapper {
  ChatsOutboxRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ChatsDao get _chatsDao => _appDatabase.chatsDao;

  Future<List<ChatOutboxMessageEntry>> getChatOutboxMessages() async {
    final entriesData = await _chatsDao.getChatOutboxMessages();
    return entriesData.map(outboxMessageEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageEntry>> watchChatOutboxMessages() {
    return _chatsDao.watchChatOutboxMessages().map((entriesData) {
      return entriesData.map(outboxMessageEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessage(ChatOutboxMessageEntry entry) {
    final entryData = outboxMessageEntryToDrift(entry);
    return _chatsDao.upsertChatOutboxMessage(entryData);
  }

  Future<int> deleteOutboxMessage(String idKey) {
    return _chatsDao.deleteChatOutboxMessage(idKey);
  }

  Future<List<ChatOutboxMessageEditEntry>> getChatOutboxMessageEdits() async {
    final entriesData = await _chatsDao.getChatOutboxMessageEdits();
    return entriesData.map(outboxMessageEditEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageEditEntry>> watchChatOutboxMessageEdits() {
    return _chatsDao.watchChatOutboxMessageEdits().map((entriesData) {
      return entriesData.map(outboxMessageEditEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageEdit(ChatOutboxMessageEditEntry entry) {
    final entryData = outboxMessageEditEntryToDrift(entry);
    return _chatsDao.upsertChatOutboxMessageEdit(entryData);
  }

  Future<int> deleteOutboxMessageEdit(int id) {
    return _chatsDao.deleteChatOutboxMessageEdit(id);
  }

  Future<List<ChatOutboxMessageDeleteEntry>> getChatOutboxMessageDeletes() async {
    final entriesData = await _chatsDao.getChatOutboxMessageDeletes();
    return entriesData.map(outboxMessageDeleteEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxMessageDeleteEntry>> watchChatOutboxMessageDeletes() {
    return _chatsDao.watchChatOutboxMessageDeletes().map((entriesData) {
      return entriesData.map(outboxMessageDeleteEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageDelete(ChatOutboxMessageDeleteEntry entry) {
    final entryData = outboxMessageDeleteEntryToDrift(entry);
    return _chatsDao.upsertChatOutboxMessageDelete(entryData);
  }

  Future<int> deleteOutboxMessageDelete(int id) {
    return _chatsDao.deleteChatOutboxMessageDelete(id);
  }

  Future<ChatOutboxReadCursorEntry?> getOutboxReadCursor(int chatId) {
    return _chatsDao
        .getChatOutboxReadCursor(chatId)
        .then((data) => data != null ? outboxReadCursorEntryFromDrift(data) : null);
  }

  Stream<ChatOutboxReadCursorEntry?> watchOutboxReadCursor(int chatId) {
    return _chatsDao
        .watchChatOutboxReadCursor(chatId)
        .map((data) => data != null ? outboxReadCursorEntryFromDrift(data) : null);
  }

  Future<List<ChatOutboxReadCursorEntry>> getOutboxReadCursors() async {
    final entriesData = await _chatsDao.getChatOutboxReadCursors();
    return entriesData.map(outboxReadCursorEntryFromDrift).toList();
  }

  Stream<List<ChatOutboxReadCursorEntry>> watchOutboxReadCursors() {
    return _chatsDao.watchChatOutboxReadCursors().map((entriesData) {
      return entriesData.map(outboxReadCursorEntryFromDrift).toList();
    });
  }

  Future upsertOutboxReadCursor(ChatOutboxReadCursorEntry entry) {
    final entryData = outboxReadCursorEntryToDrift(entry);
    return _chatsDao.upsertChatOutboxReadCursor(entryData);
  }

  Future<int> deleteOutboxReadCursor(int chatId) {
    return _chatsDao.deleteChatOutboxReadCursor(chatId);
  }

  Future<void> wipeOutboxData() async {
    await _chatsDao.wipeOutboxMessagesData();
  }
}
