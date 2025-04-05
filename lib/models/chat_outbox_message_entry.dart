import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/outbox_attachment.dart';

class ChatOutboxMessageEntry extends Equatable {
  final String idKey;
  final String content;
  final List<OutboxAttachment> attachments;
  final int? chatId;
  final String? participantId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final int sendAttempts;
  final String? failureCode;

  const ChatOutboxMessageEntry({
    required this.idKey,
    required this.content,
    this.attachments = const [],
    this.chatId,
    this.participantId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    this.sendAttempts = 0,
    this.failureCode,
  });

  @override
  List<Object?> get props => [
        idKey,
        content,
        attachments,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        sendAttempts,
        failureCode,
      ];

  @override
  String toString() {
    return 'ChatOutboxMessageEntry{idKey: $idKey, content: $content, attachments: $attachments, chatId: $chatId, participantId: $participantId, replyToId: $replyToId, forwardFromId: $forwardFromId, authorId: $authorId, sendAttempts: $sendAttempts, failureCode: $failureCode}';
  }

  ChatOutboxMessageEntry copyWith({
    String? idKey,
    String? content,
    List<OutboxAttachment>? attachments,
    int? chatId,
    String? participantId,
    int? replyToId,
    int? forwardFromId,
    String? authorId,
    int? sendAttempts,
    String? failureCode,
  }) {
    return ChatOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
      failureCode: failureCode ?? this.failureCode,
    );
  }

  ChatOutboxMessageEntry incAttempt() {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: sendAttempts + 1,
      failureCode: failureCode,
    );
  }

  ChatOutboxMessageEntry setFailureCode(String code) {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: sendAttempts,
      failureCode: code,
    );
  }

  ChatOutboxMessageEntry resetFailure() {
    return ChatOutboxMessageEntry(
      idKey: idKey,
      content: content,
      attachments: attachments,
      chatId: chatId,
      participantId: participantId,
      replyToId: replyToId,
      forwardFromId: forwardFromId,
      authorId: authorId,
      sendAttempts: 0,
      failureCode: null,
    );
  }
}
