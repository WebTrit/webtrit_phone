import 'package:equatable/equatable.dart';

class ChatOutboxMessageDeleteEntry extends Equatable {
  final int id;
  final String idKey;
  final int chatId;

  const ChatOutboxMessageDeleteEntry({
    required this.id,
    required this.idKey,
    required this.chatId,
  });

  @override
  List<Object?> get props => [id, idKey, chatId];

  @override
  bool get stringify => true;
}
