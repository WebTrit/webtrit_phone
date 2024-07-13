// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatOutboxMessageEntry extends Equatable {
  final String idKey;
  final int? chatId;
  final String? participantId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final bool viaSms;
  final String? smsNumber;
  final String content;
  final int sendAttempts;

  const ChatOutboxMessageEntry({
    required this.idKey,
    this.chatId,
    this.participantId,
    this.replyToId,
    this.forwardFromId,
    this.authorId,
    this.viaSms = false,
    this.smsNumber,
    required this.content,
    this.sendAttempts = 0,
  }) : assert(
          (participantId != null && chatId == null) || (chatId != null && participantId == null),
          'Either chatId or participantId must be set',
        );

  @override
  List<Object?> get props => [
        idKey,
        chatId,
        participantId,
        replyToId,
        forwardFromId,
        authorId,
        viaSms,
        smsNumber,
        content,
        sendAttempts,
      ];

  @override
  bool get stringify => true;

  ChatOutboxMessageEntry copyWith({
    String? idKey,
    int? chatId,
    String? participantId,
    int? replyToId,
    int? forwardFromId,
    String? authorId,
    bool? viaSms,
    String? smsNumber,
    String? content,
    int? sendAttempts,
  }) {
    return ChatOutboxMessageEntry(
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      participantId: participantId ?? this.participantId,
      replyToId: replyToId ?? this.replyToId,
      forwardFromId: forwardFromId ?? this.forwardFromId,
      authorId: authorId ?? this.authorId,
      viaSms: viaSms ?? this.viaSms,
      smsNumber: smsNumber ?? this.smsNumber,
      content: content ?? this.content,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxMessageEntry incAttempt() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
