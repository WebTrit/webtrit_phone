// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_element, unused_field

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin ChatsOutboxDriftMapper {
  ChatOutboxMessageEntry chatOutboxMessageEntryFromDrift(ChatOutboxMessageData data) {
    return ChatOutboxMessageEntry(
      idKey: data.idKey,
      chatId: data.chatId,
      participantId: data.participantId,
      replyToId: data.replyToId,
      forwardFromId: data.forwardFromId,
      authorId: data.authorId,
      viaSms: data.viaSms,
      smsNumber: data.smsNumber,
      content: data.content,
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxMessageData chatOutboxMessageDataFromChatOutboxMessageEntry(ChatOutboxMessageEntry entry) {
    return ChatOutboxMessageData(
      idKey: entry.idKey,
      chatId: entry.chatId,
      participantId: entry.participantId,
      replyToId: entry.replyToId,
      forwardFromId: entry.forwardFromId,
      authorId: entry.authorId,
      viaSms: entry.viaSms,
      smsNumber: entry.smsNumber,
      content: entry.content,
      sendAttempts: entry.sendAttempts,
    );
  }

  ChatOutboxMessageEditEntry chatOutboxMessageEditEntryFromDrift(ChatOutboxMessageEditData data) {
    return ChatOutboxMessageEditEntry(
      id: data.id,
      idKey: data.idKey,
      chatId: data.chatId,
      newContent: data.newContent,
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxMessageEditData chatOutboxMessageEditDataFromChatOutboxMessageEditEntry(ChatOutboxMessageEditEntry entry) {
    return ChatOutboxMessageEditData(
      id: entry.id,
      idKey: entry.idKey,
      chatId: entry.chatId,
      newContent: entry.newContent,
      sendAttempts: entry.sendAttempts,
    );
  }

  ChatOutboxMessageDeleteEntry chatOutboxMessageDeleteEntryFromDrift(ChatOutboxMessageDeleteData data) {
    return ChatOutboxMessageDeleteEntry(
      id: data.id,
      idKey: data.idKey,
      chatId: data.chatId,
      sendAttempts: data.sendAttempts,
    );
  }

  ChatOutboxMessageDeleteData chatOutboxMessageDeleteDataFromChatOutboxMessageDeleteEntry(
      ChatOutboxMessageDeleteEntry entry) {
    return ChatOutboxMessageDeleteData(
      id: entry.id,
      idKey: entry.idKey,
      chatId: entry.chatId,
      sendAttempts: entry.sendAttempts,
    );
  }
}
