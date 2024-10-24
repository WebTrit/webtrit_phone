part of 'messaging_bloc.dart';

enum ConnectionStatus { initial, error, connecting, connected }

class MessagingState with EquatableMixin {
  const MessagingState._(this.client, this.status, this.error);

  final PhoenixSocket client;
  final ConnectionStatus status;
  final Exception? error;

  factory MessagingState.initial(PhoenixSocket client) {
    return MessagingState._(client, ConnectionStatus.initial, null);
  }

  MessagingState copyWith({ConnectionStatus? status, Exception? error}) {
    return MessagingState._(client, status ?? this.status, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, status];
}
