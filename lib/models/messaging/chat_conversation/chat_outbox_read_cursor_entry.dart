import 'package:equatable/equatable.dart';

class ChatOutboxReadCursorEntry extends Equatable {
  final int chatId;
  final DateTime time;
  final int sendAttempts;

  const ChatOutboxReadCursorEntry({required this.chatId, required this.time, this.sendAttempts = 0});

  ChatOutboxReadCursorEntry copyWith({int? chatId, DateTime? time, int? sendAttempts}) {
    return ChatOutboxReadCursorEntry(
      chatId: chatId ?? this.chatId,
      time: time ?? this.time,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxReadCursorEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }

  @override
  List<Object> get props => [chatId, time, sendAttempts];

  @override
  String toString() {
    return 'ChatOutboxReadCursorEntry(chatId: $chatId, time: $time, sendAttempts: $sendAttempts)';
  }
}
