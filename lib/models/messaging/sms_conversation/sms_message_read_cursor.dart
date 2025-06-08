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
  String toString() {
    return 'SmsMessageReadCursor(conversationId: $conversationId, userId: $userId, time: $time)';
  }
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
