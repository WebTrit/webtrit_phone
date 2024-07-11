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
      ];

  @override
  bool get stringify => true;
}
