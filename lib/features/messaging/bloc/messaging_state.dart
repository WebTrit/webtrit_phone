part of 'messaging_bloc.dart';

enum ConnectionStatus { initial, error, connecting, connected }

class MessagingState with EquatableMixin {
  const MessagingState._(this.client, this.status, this.messagingConfig, this.error);

  final PhoenixSocket client;
  final ConnectionStatus status;
  final MessagingConfig messagingConfig;
  final Exception? error;

  factory MessagingState.initial(PhoenixSocket client, MessagingConfig messagingConfig) {
    return MessagingState._(client, ConnectionStatus.initial, messagingConfig, null);
  }

  MessagingState copyWith({ConnectionStatus? status, MessagingConfig? messagingConfig, Exception? error}) {
    return MessagingState._(client, status ?? this.status, messagingConfig ?? this.messagingConfig, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, status];
}
