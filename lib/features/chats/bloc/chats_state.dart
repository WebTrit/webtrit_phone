part of 'chats_bloc.dart';

enum ChatsStatus { initial, error, connecting, connected }

class ChatsState with EquatableMixin {
  const ChatsState._(this.client, this.status, this.error);

  final ChatsClient client;
  final ChatsStatus status;
  final Exception? error;

  factory ChatsState.initial(ChatsClient client) => ChatsState._(client, ChatsStatus.initial, null);

  ChatsState copyWith({ChatsStatus? status, Exception? error}) {
    return ChatsState._(client, status ?? this.status, error);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [client, status];
}

// TODO: move to data

enum ChatsClientState { connecting, connected, error }

abstract interface class ChatsClient {
  Future connect();
  Future disconnect();
  Stream<ChatsClientState> get connectionStateStream;
}

class ChatsClientMockImpl implements ChatsClient {
  @override
  Future connect() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future disconnect() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Stream<ChatsClientState> get connectionStateStream async* {
    yield ChatsClientState.connecting;
    await Future.delayed(const Duration(seconds: 1));
    yield ChatsClientState.connected;
  }
}
