// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc({required PhoenixSocket client}) : super(ChatsState.initial(client)) {
    on<Connect>(_connect);
    on<Refresh>(_refresh);
    on<_ClientConnected>(_onClientConnected);
    on<_ClientDisconnected>(_onClientDisconnected);
    on<_ClientError>(_onClientError);

    client.openStream.listen((d) {
      if (!isClosed) add(const _ClientConnected());
    });
    client.closeStream.listen((d) {
      if (!isClosed) add(const _ClientDisconnected());
    });
    client.errorStream.listen((e) {
      if (!isClosed) add(_ClientError(e));
    });
  }

  PhoenixSocket get client => state.client;

  void _connect(Connect event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(status: ChatsStatus.connecting));
    client.connect();
  }

  void _refresh(Refresh event, Emitter<ChatsState> emit) async {
    if (client.isConnected) client.close();
    add(const Connect());
  }

  void _onClientConnected(_ClientConnected event, Emitter<ChatsState> emit) async {
    try {
      if (!client.channels.containsKey('chat:auth')) {
        // Auth process using channel connect payload
        // Can be eliminated by retrieving user_id during main auth flow
        final authChannel = client.addChannel(topic: 'chat:auth');
        final authChannelJoinResponse = await authChannel.join().future;
        final userId = authChannelJoinResponse.response['user_id'];

        // Join channel for user specific events
        final userChannel = client.addChannel(topic: 'chat:user:$userId');
        await userChannel.join().future;
        userChannel.push('greeting', {'message': 'Hello, world!'});
      }
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      client.close();
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  void _onClientDisconnected(_ClientDisconnected event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(status: ChatsStatus.connecting));
  }

  void _onClientError(_ClientError event, Emitter<ChatsState> emit) {
    emit(state.copyWith(status: ChatsStatus.error, error: Exception(event.error)));
  }
}
