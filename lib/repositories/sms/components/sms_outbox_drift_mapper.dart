import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin SmsOutboxDriftMapper {
  SmsOutboxMessageEntry smsOutboxMessageEntryFromDrift(SmsOutboxMessageData data) {
    return SmsOutboxMessageEntry(
      idKey: data.idKey,
      fromPhoneNumber: data.fromPhoneNumber,
      toPhoneNumber: data.toPhoneNumber,
      content: data.content,
      conversationId: data.conversationId,
      recepientId: data.recepientId,
      sendAttempts: data.sendAttempts,
    );
  }

  SmsOutboxMessageData smsOutboxMessageDataFromEntry(SmsOutboxMessageEntry entry) {
    return SmsOutboxMessageData(
      idKey: entry.idKey,
      fromPhoneNumber: entry.fromPhoneNumber,
      toPhoneNumber: entry.toPhoneNumber,
      content: entry.content,
      conversationId: entry.conversationId,
      recepientId: entry.recepientId,
      sendAttempts: entry.sendAttempts,
    );
  }

  SmsOutboxMessageDeleteEntry smsOutboxMessageDeleteEntryFromDrift(SmsOutboxMessageDeleteData data) {
    return SmsOutboxMessageDeleteEntry(
      id: data.id,
      idKey: data.idKey,
      conversationId: data.conversationId,
      sendAttempts: data.sendAttempts,
    );
  }

  SmsOutboxMessageDeleteData smsOutboxMessageDeleteEntryToDrift(SmsOutboxMessageDeleteEntry entry) {
    return SmsOutboxMessageDeleteData(
      id: entry.id,
      idKey: entry.idKey,
      conversationId: entry.conversationId,
      sendAttempts: entry.sendAttempts,
    );
  }

  SmsOutboxReadCursorEntry outboxReadCursorEntryFromDrift(SmsOutboxReadCursorData data) {
    return SmsOutboxReadCursorEntry(
      conversationId: data.conversationId,
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
      sendAttempts: data.sendAttempts,
    );
  }

  SmsOutboxReadCursorData outboxReadCursorEntryToDrift(SmsOutboxReadCursorEntry entry) {
    return SmsOutboxReadCursorData(
      conversationId: entry.conversationId,
      timestampUsec: entry.time.microsecondsSinceEpoch,
      sendAttempts: entry.sendAttempts,
    );
  }
}
