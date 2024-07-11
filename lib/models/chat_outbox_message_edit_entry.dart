import 'package:equatable/equatable.dart';

class ChatOutboxMessageEditEntry extends Equatable {
  final int id;
  final String idKey;
  final int chatId;
  final String newContent;

  const ChatOutboxMessageEditEntry({
    required this.id,
    required this.idKey,
    required this.chatId,
    required this.newContent,
  });

  @override
  List<Object?> get props => [id, idKey, chatId, newContent];

  @override
  bool get stringify => true;
}
