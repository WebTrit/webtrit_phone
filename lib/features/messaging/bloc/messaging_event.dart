part of 'messaging_bloc.dart';

sealed class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object?> get props => [];
}

class Connect extends MessagingEvent {
  const Connect();
}

class Refresh extends MessagingEvent {
  const Refresh();
}

class Disconnect extends MessagingEvent {
  const Disconnect();
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

  @override
  List<Object?> get props => [error];
}
