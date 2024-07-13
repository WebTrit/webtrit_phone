// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatOutboxMessageEditEntry extends Equatable {
  final int id;
  final String idKey;
  final int chatId;
  final String newContent;
  final int sendAttempts;

  const ChatOutboxMessageEditEntry({
    required this.id,
    required this.idKey,
    required this.chatId,
    required this.newContent,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [id, idKey, chatId, newContent, sendAttempts];

  @override
  bool get stringify => true;

  ChatOutboxMessageEditEntry copyWith({
    int? id,
    String? idKey,
    int? chatId,
    String? newContent,
    int? sendAttempts,
  }) {
    return ChatOutboxMessageEditEntry(
      id: id ?? this.id,
      idKey: idKey ?? this.idKey,
      chatId: chatId ?? this.chatId,
      newContent: newContent ?? this.newContent,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  ChatOutboxMessageEditEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }
}
