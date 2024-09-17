import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/sms_outbox_drift_mapper.dart';

class SmsOutboxRepository with SmsOutboxDriftMapper {
  SmsOutboxRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  SmsDao get _smsDao => _appDatabase.smsDao;

  Future<List<SmsOutboxMessageEntry>> getOutboxMessages() async {
    final entriesData = await _smsDao.getOutboxMessages();
    return entriesData.map(smsOutboxMessageEntryFromDrift).toList();
  }

  Stream<List<SmsOutboxMessageEntry>> watchOutboxMessages() {
    return _smsDao.watchOutboxMessages().map((entriesData) {
      return entriesData.map(smsOutboxMessageEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessage(SmsOutboxMessageEntry entry) {
    final entryData = smsOutboxMessageDataFromEntry(entry);
    return _smsDao.upsertOutboxMessage(entryData);
  }

  Future<int> deleteOutboxMessage(String idKey) {
    return _smsDao.deleteOutboxMessage(idKey);
  }

  Future<List<SmsOutboxMessageDeleteEntry>> getOutboxMessageDeletes() async {
    final entriesData = await _smsDao.getOutboxMessageDeletes();
    return entriesData.map(smsOutboxMessageDeleteEntryFromDrift).toList();
  }

  Stream<List<SmsOutboxMessageDeleteEntry>> watchOutboxMessageDeletes() {
    return _smsDao.watchOutboxMessageDeletes().map((entriesData) {
      return entriesData.map(smsOutboxMessageDeleteEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessageDelete(SmsOutboxMessageDeleteEntry entry) {
    final entryData = smsOutboxMessageDeleteEntryToDrift(entry);
    return _smsDao.upsertOutboxMessageDelete(entryData);
  }

  Future<int> deleteOutboxMessageDelete(int id) {
    return _smsDao.deleteOutboxMessageDelete(id);
  }

  Future<SmsOutboxReadCursorEntry?> getOutboxReadCursor(int conversationId) async {
    final data = await _smsDao.getSmsOutboxReadCursor(conversationId);
    return data != null ? outboxReadCursorEntryFromDrift(data) : null;
  }

  Stream<SmsOutboxReadCursorEntry?> watchOutboxReadCursor(int conversationId) {
    return _smsDao.watchSmsOutboxReadCursor(conversationId).map((data) {
      return data != null ? outboxReadCursorEntryFromDrift(data) : null;
    });
  }

  Future<List<SmsOutboxReadCursorEntry>> getOutboxReadCursors() async {
    final entriesData = await _smsDao.getSmsOutboxReadCursors();
    return entriesData.map(outboxReadCursorEntryFromDrift).toList();
  }

  Stream<List<SmsOutboxReadCursorEntry>> watchOutboxReadCursors() {
    return _smsDao.watchSmsOutboxReadCursors().map((entriesData) {
      return entriesData.map(outboxReadCursorEntryFromDrift).toList();
    });
  }

  Future upsertOutboxReadCursor(SmsOutboxReadCursorEntry entry) {
    final entryData = outboxReadCursorEntryToDrift(entry);
    return _smsDao.upsertSmsOutboxReadCursor(entryData);
  }

  Future<int> deleteOutboxReadCursor(int conversationId) {
    return _smsDao.deleteSmsOutboxReadCursor(conversationId);
  }

  Future<void> wipeOutboxData() async {
    await _smsDao.wipeOutboxData();
  }
}
