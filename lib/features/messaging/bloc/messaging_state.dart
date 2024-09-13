part of 'messaging_bloc.dart';

enum ConnectionStatus { initial, error, connecting, connected }

class MessagingState with EquatableMixin {
  const MessagingState._(this.client, this.status, this.userId, this.error);

  final PhoenixSocket client;
  final ConnectionStatus status;
  final String? userId;
  final Exception? error;

  factory MessagingState.initial(PhoenixSocket client, String? userId) {
    return MessagingState._(client, ConnectionStatus.initial, userId, null);
  }

  MessagingState copyWith({ConnectionStatus? status, String? userId, Exception? error}) {
    return MessagingState._(client, status ?? this.status, userId ?? this.userId, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, userId, status];
}
