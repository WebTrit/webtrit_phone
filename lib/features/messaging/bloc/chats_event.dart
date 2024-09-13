part of 'chats_bloc.dart';

abstract class ChatsEvent {
  const ChatsEvent();
}

class Connect extends ChatsEvent {
  const Connect();
}

class Refresh extends ChatsEvent {
  const Refresh();
}

class _ClientConnected extends ChatsEvent {
  const _ClientConnected();
}

class _ClientDisconnected extends ChatsEvent {
  const _ClientDisconnected();
}

class _ClientError extends ChatsEvent {
  const _ClientError(this.error);

  final Object error;
}
