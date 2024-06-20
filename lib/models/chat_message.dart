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
      'sender_id': senderId,
      'chat_id': chatId,
      'reply_to_id': replyToId,
      'forwarded_from_id': forwardFromId,
      'author_id': authorId,
      'via_sms': viaSms,
      'sms_out_state': smsOutState?.name,
      'sms_number': smsNumber,
      'content': content,
      'edited_at': editedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int,
      senderId: map['sender_id'] as String,
      chatId: map['chat_id'] as int,
      replyToId: map['reply_to_id'] != null ? map['reply_to_id'] as int : null,
      forwardFromId: map['forwarded_from_id'] != null ? map['forwarded_from_id'] as int : null,
      authorId: map['author_id'] != null ? map['author_id'] as String : null,
      viaSms: map['via_sms'] as bool,
      smsOutState: map['sms_out_state'] != null ? SmsOutState.values.byName(map['sms_out_state'] as String) : null,
      smsNumber: map['sms_number'] != null ? map['sms_number'] as String : null,
      content: map['content'] as String,
      editedAt: map['edited_at'] != null ? DateTime.parse(map['edited_at'] as String) : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum SmsOutState { sending, error, delivered }

extension MessagesListExtension<T extends ChatMessage> on List<T> {
  T findById(int id) => firstWhere((element) => element.id == id);

  List<T> mergeWith(T message) {
    final newList = List<T>.from(this);

    final index = newList.indexWhere((element) => element.id == message.id);
    if (index == -1) {
      newList.add(message);
    } else {
      newList[index] = message;
    }
    return newList;
  }

  /// Merge the real-time message update with the list of messages
  /// If the message is an update, it will replace the old message in the list
  /// If the message is an update for a message that is not included in the list, it will be skipped
  /// If the message is a new message, it will be added to the head of the list
  /// The list should me sorted by [ChatMessage.createdAt] in descending order
  List<T> mergeUpdateWith(T message) {
    final newList = List<T>.from(this);
    bool isUpdate = message.updatedAt.isAfter(message.createdAt);

    final index = newList.indexWhere((element) => element.id == message.id);
    if (index == -1) {
      // Skip for message update that are not included in the list
      if (isUpdate) return newList;
      return [message, ...newList];
    } else {
      // Update the message in the list
      newList[index] = message;
    }
    return newList;
  }
}
