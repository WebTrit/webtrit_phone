// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/chats/services/services.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(
    this._client,
    this._chatsRepository,
    this._outboxRepository,
    this._prefs,
  ) : super(ChatsState.initial(_client, _prefs.getChatUserId())) {
    on<Connect>(_connect);
    on<Refresh>(_refresh);
    on<_ClientConnected>(_onClientConnected);
    on<_ClientDisconnected>(_onClientDisconnected);
    on<_ClientError>(_onClientError);

    _client.openStream.listen((_) {
      if (!isClosed) add(const _ClientConnected());
    });
    _client.closeStream.listen((_) {
      if (!isClosed) add(const _ClientDisconnected());
    });
    _client.errorStream.listen((e) {
      if (!isClosed) add(_ClientError(e));
    });
  }

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;
  final AppPreferences _prefs;
  ChatsSyncWorker? _chatsSyncWorker;
  ChatsOutboxWorker? _chatsOutboxWorker;

  void _connect(Connect event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(status: ChatsStatus.connecting));
    // _chatsRepository.wipeChatsData();
    // _outboxRepository.wipeOutboxData();
    _client.connect();
  }

  void _refresh(Refresh event, Emitter<ChatsState> emit) async {
    if (_client.isConnected) _client.close();
    add(const Connect());
  }

  void _onClientConnected(_ClientConnected event, Emitter<ChatsState> emit) async {
    try {
      if (!_client.channels.containsKey('chat:me')) {
        // Auth process using channel connect payload
        // Can be eliminated by retrieving user_id during main auth flow
        final authChannel = _client.addChannel(topic: 'chat:me');
        final authChannelJoinResponse = await authChannel.join().future;
        final userId = authChannelJoinResponse.response['user_id'];

        // Persists user_id for future use especially after app restart in offline mode
        // so user_id is important for distinguishing dialog participants, message author, etc.
        // dont forget to cleanup on logout
        _prefs.setChatUserId(userId);
        emit(state.copyWith(userId: userId));

        // Join channel for user specific events
        final userChannel = _client.addChannel(topic: 'chat:user:$userId');
        await userChannel.join().future;

        // Init workers
        _chatsSyncWorker ??= ChatsSyncWorker(_client, _chatsRepository)..init();
        _chatsOutboxWorker ??= ChatsOutboxWorker(_client, _chatsRepository, _outboxRepository)..init();
      }
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      _client.close();
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  void _onClientDisconnected(_ClientDisconnected event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(status: ChatsStatus.connecting));
  }

  void _onClientError(_ClientError event, Emitter<ChatsState> emit) {
    emit(state.copyWith(status: ChatsStatus.error, error: Exception(event.error)));
  }

  @override
  Future<void> close() {
    _chatsSyncWorker?.dispose();
    _chatsOutboxWorker?.dispose();
    _client.dispose();
    return super.close();
  }
}
