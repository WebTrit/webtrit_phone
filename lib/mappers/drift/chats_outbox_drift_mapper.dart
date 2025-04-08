import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ChatsOutboxDriftMapper {
  ChatOutboxMessageEntry outboxMessageEntryFromDrift(
    (ChatOutboxMessageData, List<OutboxAttachmentData>) data,
  ) {
    final (message, attachments) = data;
    return ChatOutboxMessageEntry(
      idKey: message.idKey,
      chatId: message.chatId,
      participantId: message.participantId,
      replyToId: message.replyToId,
      forwardFromId: message.forwardFromId,
      authorId: message.authorId,
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
      chatsOutboxMessageIdKey: msgId,
      pickedPath: attachment.pickedPath,
      encodedPath: attachment.encodedPath,
      uploadedPath: attachment.uploadedPath,
    );
  }

  (ChatOutboxMessageData, List<OutboxAttachmentData>) outboxMessageEntryToDrift(ChatOutboxMessageEntry entry) {
    final message = ChatOutboxMessageData(
      idKey: entry.idKey,
      chatId: entry.chatId,
      participantId: entry.participantId,
      replyToId: entry.replyToId,
      forwardFromId: entry.forwardFromId,
      authorId: entry.authorId,
      content: entry.content,
      sendAttempts: entry.sendAttempts,
      failureCode: entry.failureCode,
    );

    final attachments = entry.attachments.map((attachment) {
      return outboxAttachmentToDrift(entry.idKey, attachment);
    }).toList();

    return (message, attachments);
  }

  ChatOutboxMessageEditEntry outboxMessageEditEntryFromDrift(ChatOutboxMessageEditData data) {
    return ChatOutboxMessageEditEntry(
      id: data.id,
      idKey: data.idKey,
      chatId: data.chatId,
      newContent: data.newContent,
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxMessageEditData outboxMessageEditEntryToDrift(ChatOutboxMessageEditEntry entry) {
    return ChatOutboxMessageEditData(
      id: entry.id,
      idKey: entry.idKey,
      chatId: entry.chatId,
      newContent: entry.newContent,
      sendAttempts: entry.sendAttempts,
    );
  }

  ChatOutboxMessageDeleteEntry outboxMessageDeleteEntryFromDrift(ChatOutboxMessageDeleteData data) {
    return ChatOutboxMessageDeleteEntry(
      id: data.id,
      idKey: data.idKey,
      chatId: data.chatId,
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxMessageDeleteData outboxMessageDeleteEntryToDrift(ChatOutboxMessageDeleteEntry entry) {
    return ChatOutboxMessageDeleteData(
      id: entry.id,
      idKey: entry.idKey,
      chatId: entry.chatId,
      sendAttempts: entry.sendAttempts,
    );
  }

  ChatOutboxReadCursorEntry outboxReadCursorEntryFromDrift(ChatOutboxReadCursorData data) {
    return ChatOutboxReadCursorEntry(
      chatId: data.chatId,
      time: DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec),
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxReadCursorData outboxReadCursorEntryToDrift(ChatOutboxReadCursorEntry entry) {
    return ChatOutboxReadCursorData(
      chatId: entry.chatId,
      timestampUsec: entry.time.microsecondsSinceEpoch,
      sendAttempts: entry.sendAttempts,
    );
  }
}
