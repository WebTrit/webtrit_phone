import 'dart:convert';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ChatsOutboxDriftMapper {
  ChatOutboxMessageEntry outboxMessageEntryFromDrift(ChatOutboxMessageData data) {
    return ChatOutboxMessageEntry(
      idKey: data.idKey,
      chatId: data.chatId,
      participantId: data.participantId,
      replyToId: data.replyToId,
      forwardFromId: data.forwardFromId,
      authorId: data.authorId,
      content: data.content,
      attachments: (jsonDecode(data.attachmentsJson) as List).map((e) => OutgoingAttachment.fromMap(e)).toList(),
      sendAttempts: data.sendAttempts,
      failureCode: data.failureCode,
    );
  }

  ChatOutboxMessageData outboxMessageEntryToDrift(ChatOutboxMessageEntry entry) {
    return ChatOutboxMessageData(
      idKey: entry.idKey,
      chatId: entry.chatId,
      participantId: entry.participantId,
      replyToId: entry.replyToId,
      forwardFromId: entry.forwardFromId,
      authorId: entry.authorId,
      content: entry.content,
      attachmentsJson: jsonEncode(entry.attachments.map((e) => e.toMap()).toList()),
      sendAttempts: entry.sendAttempts,
      failureCode: entry.failureCode,
    );
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
