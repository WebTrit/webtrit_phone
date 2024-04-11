part of 'chats_bloc.dart';

enum ChatsStatus { initial, error, connecting, connected }

class ChatsState with EquatableMixin {
  const ChatsState._(this.client, this.status);

  final StreamChatClient client;
  final ChatsStatus status;

  factory ChatsState.initial(String apiKey) => ChatsState._(StreamChatClient(apiKey), ChatsStatus.initial);

  ChatsState copyWith({StreamChatClient? client, ChatsStatus? status}) {
    return ChatsState._(client ?? this.client, status ?? this.status);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, status];
}
