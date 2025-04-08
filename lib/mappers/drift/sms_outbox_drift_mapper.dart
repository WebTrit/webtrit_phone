import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin SmsOutboxDriftMapper {
  SmsOutboxMessageEntry smsOutboxMessageEntryFromDrift((SmsOutboxMessageData, List<OutboxAttachmentData>) data) {
    final (message, attachments) = data;

    return SmsOutboxMessageEntry(
      idKey: message.idKey,
      conversationId: message.conversationId,
      fromPhoneNumber: message.fromPhoneNumber,
      toPhoneNumber: message.toPhoneNumber,
      recepientId: message.recepientId,
      content: message.content,
      attachments: attachments.map(outboxAttachmentFromDrift).toList(),
      sendAttempts: message.sendAttempts,
      failureCode: message.failureCode,
    );
  }

  OutboxAttachment outboxAttachmentFromDrift(OutboxAttachmentData attachment) {
    return OutboxAttachment(
      id: attachment.idKey,
      pickedPath: attachment.pickedPath,
      encodedPath: attachment.encodedPath,
      uploadedPath: attachment.uploadedPath,
    );
  }

  OutboxAttachmentData outboxAttachmentToDrift(String msgId, OutboxAttachment attachment) {
    return OutboxAttachmentData(
      idKey: attachment.id,
      smsOutboxMessageIdKey: msgId,
      pickedPath: attachment.pickedPath,
      encodedPath: attachment.encodedPath,
      uploadedPath: attachment.uploadedPath,
    );
  }

  (SmsOutboxMessageData, List<OutboxAttachmentData>) smsOutboxMessageDataFromEntry(SmsOutboxMessageEntry entry) {
    final message = SmsOutboxMessageData(
      idKey: entry.idKey,
      fromPhoneNumber: entry.fromPhoneNumber,
      toPhoneNumber: entry.toPhoneNumber,
      content: entry.content,
      conversationId: entry.conversationId,
      recepientId: entry.recepientId,
      sendAttempts: entry.sendAttempts,
      failureCode: entry.failureCode,
    );

    final attachments = entry.attachments.map((attachment) {
      return outboxAttachmentToDrift(entry.idKey, attachment);
    }).toList();

    return (message, attachments);
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
