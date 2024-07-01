import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/models/models.dart';

sealed class ChatsEvent {
  const ChatsEvent();
}

class ChatUpdate extends ChatsEvent with EquatableMixin {
  const ChatUpdate(this.chat);
  final Chat chat;

  @override
  List<Object> get props => [chat];

  @override
  bool get stringify => true;
}

class ChatRemove extends ChatsEvent with EquatableMixin {
  const ChatRemove(this.chatId);
  final int chatId;

  @override
  List<Object> get props => [chatId];

  @override
  bool get stringify => true;
}

class ChatMessageUpdate extends ChatsEvent with EquatableMixin {
  const ChatMessageUpdate(this.message);
  final ChatMessage message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}
