part of 'chats_bloc.dart';

enum ChatsStatus { initial, error, connecting, connected }

class ChatsState with EquatableMixin {
  const ChatsState._(this.client, this.status, this.error);

  final StreamChatClient client;
  final ChatsStatus status;
  final Exception? error;

  factory ChatsState.initial(String apiKey) => ChatsState._(StreamChatClient(apiKey), ChatsStatus.initial, null);

  ChatsState copyWith({ChatsStatus? status, Exception? error}) {
    return ChatsState._(client, status ?? this.status, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, status];
}
