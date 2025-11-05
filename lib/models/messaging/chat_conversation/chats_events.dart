import 'package:equatable/equatable.dart';

import 'chats.dart';

sealed class ChatsEvent {
  int get chatId;

  const ChatsEvent();
}

class ChatUpdate extends ChatsEvent with EquatableMixin {
  const ChatUpdate(this.chat);
  final Chat chat;

  @override
  int get chatId => chat.id;

  @override
  List<Object?> get props => [chat];

  @override
  bool get stringify => true;
}

class ChatRemove extends ChatsEvent with EquatableMixin {
  const ChatRemove(this.chatId);

  @override
  final int chatId;

  @override
  List<Object?> get props => [chatId];

  @override
  bool get stringify => true;
}

class ChatMessageUpdate extends ChatsEvent with EquatableMixin {
  const ChatMessageUpdate(this.message);
  final ChatMessage message;

  @override
  int get chatId => message.chatId;

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class ChatReadCursorUpdate extends ChatsEvent with EquatableMixin {
  const ChatReadCursorUpdate(this.cursor);
  final ChatMessageReadCursor cursor;

  @override
  int get chatId => cursor.chatId;

  @override
  List<Object?> get props => [cursor];

  @override
  bool get stringify => true;
}
