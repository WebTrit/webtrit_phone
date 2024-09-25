// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatOutboxMessageDeleteEntry extends Equatable {
  final int id;
  final String idKey;
  final int chatId;
  final int sendAttempts;

  const ChatOutboxMessageDeleteEntry({
    required this.id,
    required this.idKey,
    required this.chatId,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [id, idKey, chatId, sendAttempts];

  @override
  bool get stringify => true;

  ChatOutboxMessageDeleteEntry copyWith({
    int? id,
    String? idKey,
    int? chatId,
    int? sendAttempts,
  }) {
    return ChatOutboxMessageDeleteEntry(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxMessageDeleteEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
