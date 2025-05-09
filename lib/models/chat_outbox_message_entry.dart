import 'package:equatable/equatable.dart';

class ChatOutboxMessageEntry extends Equatable {
  final String idKey;
  final String content;
  final int? chatId;
  final String? participantId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final int sendAttempts;

  const ChatOutboxMessageEntry({
    required this.idKey,
    required this.content,
    this.chatId,
    this.participantId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [
        idKey,
        content,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        sendAttempts,
      ];

  @override
  bool get stringify => true;

  ChatOutboxMessageEntry copyWith({
    String? idKey,
    int? chatId,
    String? content,
    String? participantId,
    int? replyToId,
    int? forwardFromId,
    String? authorId,
    int? sendAttempts,
  }) {
    return ChatOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      content: content ?? this.content,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxMessageEntry incAttempt() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
