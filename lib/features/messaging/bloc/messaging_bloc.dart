import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';
import 'package:webtrit_phone/features/messaging/services/services.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: maybe rename to "messaging connection bloc" and place /cubits and /bloc together

part 'messaging_event.dart';
part 'messaging_state.dart';

final _logger = Logger('MessagingBloc');

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  MessagingBloc(
    this._userId,
    this._client,
    this._chatsRepository,
    this._chatsOutboxRepository,
    this._smsRepository,
    this._smsOutboxRepository,
    this._submitNotification,
  ) : super(MessagingState.initial(_client)) {
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
  final String _userId;
  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _chatsOutboxRepository;
  final SmsRepository _smsRepository;
  final SmsOutboxRepository _smsOutboxRepository;
  final Function(Notification) _submitNotification;

  ChatsSyncWorker? _chatsSyncWorker;
  ChatsOutboxWorker? _chatsOutboxWorker;
  SmsSyncWorker? _smsSyncWorker;
  SmsOutboxWorker? _smsOutboxWorker;

  void _connect(Connect event, Emitter<MessagingState> emit) async {
    emit(state.copyWith(status: ConnectionStatus.connecting));
    // -
    // Uncomment section below to wipe messaging related data
    // -
    // _chatsRepository.wipeChatsData();
    // _chatsOutboxRepository.wipeOutboxData();
    // _smsRepository.wipeData();
    // _smsOutboxRepository.wipeOutboxData();
    _client.connect();
  }

  void _refresh(Refresh event, Emitter<MessagingState> emit) async {
    if (_client.isConnected) _client.dispose();
    await Future.delayed(const Duration(milliseconds: 10)); // _client.dispose() fake sync so...
    add(const Connect());
  }

  void _onClientConnected(_ClientConnected event, Emitter<MessagingState> emit) async {
    try {
      // Join channel for user specific events
      if (_client.userChannel == null) {
        final userChannel = _client.createUserChannel(_userId);
        await userChannel.join().future;
      }

      // Init workers
      if (EnvironmentConfig.CHAT_FEATURE_ENABLE) {
        _chatsSyncWorker ??= ChatsSyncWorker(_client, _chatsRepository, _submitNotification)..init();
        _chatsOutboxWorker ??= ChatsOutboxWorker(_client, _chatsRepository, _chatsOutboxRepository, _submitNotification)
          ..init();
      }
      if (EnvironmentConfig.SMS_FEATURE_ENABLE) {
        _smsSyncWorker ??= SmsSyncWorker(_client, _smsRepository, _submitNotification)..init();
        _smsOutboxWorker ??= SmsOutboxWorker(_client, _smsRepository, _smsOutboxRepository, _submitNotification)
          ..init();
      }

      emit(state.copyWith(status: ConnectionStatus.connected));
    } on Exception catch (e, s) {
      _client.dispose();
      emit(state.copyWith(status: ConnectionStatus.error, error: e));
      _logger.warning('_onClientConnected', e, s);
      _submitNotification(DefaultErrorNotification(e));
    }
  }

  void _onClientDisconnected(_ClientDisconnected event, Emitter<MessagingState> emit) async {
    emit(state.copyWith(status: ConnectionStatus.connecting));
    _logger.warning('_onClientDisconnected');
  }

  void _onClientError(_ClientError event, Emitter<MessagingState> emit) {
    emit(state.copyWith(status: ConnectionStatus.error, error: Exception(event.error)));
    _logger.warning('_onClientError', event.error);
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
