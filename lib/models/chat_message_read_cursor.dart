import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class ChatMessageReadCursor extends Equatable {
  final int chatId;
  final String userId;
  final DateTime time;

  const ChatMessageReadCursor({
    required this.chatId,
    required this.userId,
    required this.time,
  });

  @override
  List<Object?> get props => [chatId, userId, time];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chat_id': chatId,
      'user_id': userId,
      'last_read_at': time.toIso8601String,
    };
  }

  factory ChatMessageReadCursor.fromMap(Map<String, dynamic> map) {
    return ChatMessageReadCursor(
      chatId: map['chat_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageReadCursor.fromJson(String source) =>
      ChatMessageReadCursor.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ChatMessageReadCursorListExtension<T extends ChatMessageReadCursor> on Iterable<T> {
  DateTime? participantsReadedUntil(String userId) {
    return fold<DateTime?>(null, (max, cursor) {
      if (cursor.userId == userId) return max;
      if (max == null) return cursor.time;
      return cursor.time.isAfter(max) ? cursor.time : max;
    });
  }

  DateTime? userReadedUntil(String userId) {
    return firstWhereOrNull((cursor) => cursor.userId == userId)?.time;
  }
}
