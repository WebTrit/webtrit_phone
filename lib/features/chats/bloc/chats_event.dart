part of 'chats_bloc.dart';

abstract class ChatsEvent {
  const ChatsEvent();
}

class Connect extends ChatsEvent {
  const Connect();
}
