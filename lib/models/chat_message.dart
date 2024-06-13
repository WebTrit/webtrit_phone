import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final int id;
  final String senderId;
  final int chatId;
  final int? replyToId;
  final int? forwardFromId;
  final String? authorId;
  final bool viaSms;
  final SmsOutState? smsOutState;
  final String? smsNumber;
  final String content;
  final DateTime? editedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.chatId,
    required this.replyToId,
    required this.forwardFromId,
    required this.authorId,
    required this.viaSms,
    required this.smsOutState,
    required this.smsNumber,
    required this.content,
    required this.editedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        chatId,
        replyToId,
        forwardFromId,
        authorId,
        viaSms,
        smsOutState,
        smsNumber,
        content,
        editedAt,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  @override
  bool get stringify => true;
}

enum SmsOutState { sending, error, delivered }
