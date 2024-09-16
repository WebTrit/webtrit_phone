// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';
import 'package:webtrit_phone/features/messaging/services/services.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: add logger

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  MessagingBloc(
    this._prefs,
    this._client,
    this._chatsRepository,
    this._chatsOutboxRepository,
    this._smsRepository,
    this._smsOutboxRepository,
  ) : super(MessagingState.initial(_client, _prefs.getChatUserId())) {
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

  final AppPreferences _prefs;
  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _chatsOutboxRepository;
  final SmsRepository _smsRepository;
  final SmsOutboxRepository _smsOutboxRepository;
  ChatsSyncWorker? _chatsSyncWorker;
  ChatsOutboxWorker? _chatsOutboxWorker;
  SmsSyncWorker? _smsSyncWorker;
  SmsOutboxWorker? _smsOutboxWorker;

  void _connect(Connect event, Emitter<MessagingState> emit) async {
    emit(state.copyWith(status: ConnectionStatus.connecting));
    // _chatsRepository.wipeChatsData();
    // _outboxRepository.wipeOutboxData();
    _client.connect();
  }

  void _refresh(Refresh event, Emitter<MessagingState> emit) async {
    if (_client.isConnected) _client.dispose();
    await Future.delayed(const Duration(milliseconds: 10)); // _client.dispose() fake sync so...
    add(const Connect());
  }

  void _onClientConnected(_ClientConnected event, Emitter<MessagingState> emit) async {
    try {
      if (_client.userChannel == null) {
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
        if (EnvironmentConfig.CHAT_FEATURE_ENABLE) {
          _chatsSyncWorker ??= ChatsSyncWorker(_client, _chatsRepository)..init();
          _chatsOutboxWorker ??= ChatsOutboxWorker(_client, _chatsRepository, _chatsOutboxRepository)..init();
        }
        if (EnvironmentConfig.SMS_FEATURE_ENABLE) {
          _smsSyncWorker ??= SmsSyncWorker(_client, _smsRepository)..init();
          _smsOutboxWorker ??= SmsOutboxWorker(_client, _smsRepository, _smsOutboxRepository)..init();
        }
      }
      emit(state.copyWith(status: ConnectionStatus.connected));
    } on Exception catch (e) {
      _client.dispose();
      emit(state.copyWith(status: ConnectionStatus.error, error: e));
    }
  }

  void _onClientDisconnected(_ClientDisconnected event, Emitter<MessagingState> emit) async {
    emit(state.copyWith(status: ConnectionStatus.connecting));
  }

  void _onClientError(_ClientError event, Emitter<MessagingState> emit) {
    emit(state.copyWith(status: ConnectionStatus.error, error: Exception(event.error)));
  }

  @override
  Future<void> close() {
    _chatsSyncWorker?.dispose();
    _chatsOutboxWorker?.dispose();
    _smsSyncWorker?.dispose();
    _smsOutboxWorker?.dispose();
    _client.dispose();
    return super.close();
  }
}
