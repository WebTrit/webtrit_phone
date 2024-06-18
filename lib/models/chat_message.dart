import 'dart:convert';
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'chatId': chatId,
      'replyToId': replyToId,
      'forwardFromId': forwardFromId,
      'authorId': authorId,
      'viaSms': viaSms,
      'smsOutState': smsOutState?.name,
      'smsNumber': smsNumber,
      'content': content,
      'editedAt': editedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int,
      senderId: map['senderId'] as String,
      chatId: map['chatId'] as int,
      replyToId: map['replyToId'] != null ? map['replyToId'] as int : null,
      forwardFromId: map['forwardFromId'] != null ? map['forwardFromId'] as int : null,
      authorId: map['authorId'] != null ? map['authorId'] as String : null,
      viaSms: map['viaSms'] as bool,
      smsOutState: map['smsOutState'] != null ? SmsOutState.values.byName(map['smsOutState'] as String) : null,
      smsNumber: map['smsNumber'] != null ? map['smsNumber'] as String : null,
      content: map['content'] as String,
      editedAt: map['editedAt'] != null ? DateTime.parse(map['editedAt'] as String) : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      deletedAt: map['deletedAt'] != null ? DateTime.parse(map['deletedAt'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum SmsOutState { sending, error, delivered }
