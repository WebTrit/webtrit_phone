part of 'messaging_bloc.dart';

abstract class MessagingEvent {
  const MessagingEvent();
}

class Connect extends MessagingEvent {
  const Connect();
}

class Refresh extends MessagingEvent {
  const Refresh();
}

class _ClientConnected extends MessagingEvent {
  const _ClientConnected();
}

class _ClientDisconnected extends MessagingEvent {
  const _ClientDisconnected();
}

class _ClientError extends MessagingEvent {
  const _ClientError(this.error);

  final Object error;
}
