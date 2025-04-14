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
