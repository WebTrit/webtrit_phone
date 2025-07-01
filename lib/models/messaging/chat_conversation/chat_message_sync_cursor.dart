import 'package:equatable/equatable.dart';

enum MessageSyncCursorType { oldest, newest }

class ChatMessageSyncCursor extends Equatable {
  final int chatId;
  final MessageSyncCursorType cursorType;
  final DateTime time;

  const ChatMessageSyncCursor({
    required this.chatId,
    required this.cursorType,
    required this.time,
  });

  @override
  List<Object?> get props => [chatId, cursorType, time];

  @override
  String toString() {
    return 'ChatMessageSyncCursor(chatId: $chatId, cursorType: $cursorType, time: $time)';
  }
}
