part of 'chats_bloc.dart';

enum ChatsStatus { initial, error, connecting, connected }

class ChatsState with EquatableMixin {
  const ChatsState._(this.client, this.status, this.userId, this.error);

  final PhoenixSocket client;
  final ChatsStatus status;
  final String? userId;
  final Exception? error;

  factory ChatsState.initial(PhoenixSocket client, String? userId) {
    return ChatsState._(client, ChatsStatus.initial, userId, null);
  }

  ChatsState copyWith({ChatsStatus? status, String? userId, Exception? error}) {
    return ChatsState._(client, status ?? this.status, userId ?? this.userId, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, userId, status];
}
