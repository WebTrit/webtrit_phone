part of 'messaging_bloc.dart';

enum ConnectionStatus { initial, error, connecting, connected }

class MessagingState with EquatableMixin {
  const MessagingState._(this.userId, this.client, this.status, this.messagingConfig, this.error);

  final String userId;
  final PhoenixSocket client;
  final ConnectionStatus status;
  final MessagingConfig messagingConfig;
  final Exception? error;

  factory MessagingState.initial(String userId, PhoenixSocket client, MessagingConfig messagingConfig) {
    return MessagingState._(userId, client, ConnectionStatus.initial, messagingConfig, null);
  }

  MessagingState copyWith({
    String? userId,
    PhoenixSocket? client,
    ConnectionStatus? status,
    MessagingConfig? messagingConfig,
    Exception? error,
  }) {
    return MessagingState._(
      userId ?? this.userId,
      client ?? this.client,
      status ?? this.status,
      messagingConfig ?? this.messagingConfig,
      error,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [userId, client, status, messagingConfig, error];
}
