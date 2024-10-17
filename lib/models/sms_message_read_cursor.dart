import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class SmsMessageReadCursor extends Equatable {
  final int conversationId;
  final String userId;
  final DateTime time;

  const SmsMessageReadCursor({
    required this.conversationId,
    required this.userId,
    required this.time,
  });

  @override
  List<Object?> get props => [conversationId, userId, time];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sms_conversation_id': conversationId,
      'user_id': userId,
      'last_read_at': time.toIso8601String,
    };
  }

  factory SmsMessageReadCursor.fromMap(Map<String, dynamic> map) {
    return SmsMessageReadCursor(
      conversationId: map['sms_conversation_id'] as int,
      userId: map['user_id'] as String,
      time: DateTime.parse(map['last_read_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmsMessageReadCursor.fromJson(String source) =>
      SmsMessageReadCursor.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension SmsMessageReadCursorListExtension<T extends SmsMessageReadCursor> on Iterable<T> {
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
