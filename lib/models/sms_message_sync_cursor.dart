import 'package:equatable/equatable.dart';

enum SmsSyncCursorType { oldest, newest }

class SmsMessageSyncCursor extends Equatable {
  final int conversationId;
  final SmsSyncCursorType cursorType;
  final DateTime time;

  const SmsMessageSyncCursor({
    required this.conversationId,
    required this.cursorType,
    required this.time,
  });

  @override
  List<Object?> get props => [conversationId, cursorType, time];

  @override
  bool get stringify => true;
}
