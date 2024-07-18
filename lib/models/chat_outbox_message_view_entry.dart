import 'package:equatable/equatable.dart';

class ChatOutboxMessageViewEntry extends Equatable {
  final int id;
  final String idKey;
  final int chatId;
  final int sendAttempts;

  const ChatOutboxMessageViewEntry({
    required this.id,
    required this.idKey,
    required this.chatId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [id, idKey, chatId, sendAttempts];

  @override
  bool get stringify => true;

  ChatOutboxMessageViewEntry copyWith({
    int? id,
    String? idKey,
    int? chatId,
    int? sendAttempts,
  }) {
    return ChatOutboxMessageViewEntry(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxMessageViewEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
