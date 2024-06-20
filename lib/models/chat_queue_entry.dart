import 'package:equatable/equatable.dart';

class ChatQueueEntry extends Equatable {
  final int id;
  final String idKey;
  final ChatQueueEntryType type;
  final int? chatId;
  final String? participantId;
  final int? messageId;
  final int? replyToId;
  final int? forwardTo;
  final bool viaSms;
  final String? smsNumber;
  final String content;
  final DateTime? insertedAt;
  final DateTime? updatedAt;

  const ChatQueueEntry({
    required this.id,
    required this.idKey,
    required this.type,
    required this.chatId,
    required this.participantId,
    required this.messageId,
    required this.replyToId,
    required this.forwardTo,
    required this.viaSms,
    required this.smsNumber,
    required this.content,
    required this.insertedAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        idKey,
        type,
        chatId,
        messageId,
        participantId,
        replyToId,
        forwardTo,
        viaSms,
        smsNumber,
        content,
        insertedAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}

enum ChatQueueEntryType { create, edit, delete }
