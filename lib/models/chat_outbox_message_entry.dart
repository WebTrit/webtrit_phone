import 'package:equatable/equatable.dart';

class ChatOutboxMessageEntry extends Equatable {
  final String idKey;
  final String content;
  final List<String>? attachments;
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
    this.attachments,
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
  bool get stringify => true;

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
