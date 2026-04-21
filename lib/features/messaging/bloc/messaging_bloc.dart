// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';
import 'package:webtrit_phone/features/messaging/services/services.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/crashlytics_utils.dart';

// TODO:
// -  maybe rename to "messaging connection bloc" and place /cubits and /bloc together
//
// -  initialize new socket client on reconnect because socket cant restart after _client.dispose()
//    so for multiple remote config changes app restart is required,
//    but for rare change (like customer paid montly for sms feature) it's fine

part 'messaging_event.dart';

part 'messaging_state.dart';

final _logger = Logger('MessagingBloc');

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  MessagingBloc(
    this._client,
    this._messagingConfig,
    this._chatsRepository,
    this._chatsOutboxRepository,
    this._smsRepository,
    this._smsOutboxRepository,
    this._sessionRepository,
  ) : super(MessagingState.initial(_sessionRepository.getCurrent().userId, _client, _messagingConfig)) {
    on<Connect>(_connect);
    on<Refresh>(_refresh);
    on<Disconnect>(_onDisconnect);
    on<_ClientConnected>(_onClientConnected);
    on<_ClientDisconnected>(_onClientDisconnected);
    on<_ClientError>(_onClientError);

    _subs.add(_client.openStream.listen((_) => add(const _ClientConnected())));
    _subs.add(_client.closeStream.listen((_) => add(const _ClientDisconnected())));
    _subs.add(_client.errorStream.listen((e) => add(_ClientError(e))));
  }

  final PhoenixSocket _client;
  final MessagingConfig _messagingConfig;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _chatsOutboxRepository;
  final SmsRepository _smsRepository;
  final SmsOutboxRepository _smsOutboxRepository;
  final SessionRepository _sessionRepository;
  final List<StreamSubscription> _subs = [];

  ChatsSyncWorker? _chatsSyncWorker;
  ChatsOutboxWorker? _chatsOutboxWorker;
  SmsSyncWorker? _smsSyncWorker;
  SmsOutboxWorker? _smsOutboxWorker;

  void _connect(Connect event, Emitter<MessagingState> emit) async {
    if (_messagingConfig.anyMessagingEnabled == false) return;

    // -
    // Uncomment section below to wipe messaging related data
    // -
    // wipeData()

    emit(state.copyWith(status: ConnectionStatus.connecting));
    _client.connect();
  }

  void _refresh(Refresh event, Emitter<MessagingState> emit) async {
    _client.dispose();
    await Future.delayed(const Duration(milliseconds: 10)); // _client.dispose() fake sync so...
    add(const Connect());
  }

  void _onClientConnected(_ClientConnected event, Emitter<MessagingState> emit) async {
    try {
      // Join channel for user specific events
      if (_client.userChannel == null) {
        final userId = _sessionRepository.getCurrent().userId;
        final userChannel = _client.createUserChannel(userId);
        final joinReq = await userChannel.join().future;
        final response = joinReq.response;

        /// Handle the workaround for core userId upgrade
        /// When the server detects that the client is using an old userId format, it responds with a "forbidden" message containing the new userId.
        /// The client then updates its session with the new userId, wipes local messaging data to prevent inconsistencies
        /// and rejoins the channel with the new userId.
        if (response is List && response[0] == 'forbidden' && response[1] is String) {
          final newUserId = response[1] as String;
          _logger.warning('UserId upgrade required, new userId: $newUserId');

          await _sessionRepository.patchSession(userId: newUserId);
          await wipeData();

          emit(state.copyWith(userId: newUserId));
          final userChannel = _client.createUserChannel(newUserId);
          await userChannel.join().future;
        }
      }

      // Init workers
      if (_messagingConfig.coreChatsSupport) {
        _chatsSyncWorker ??= ChatsSyncWorker(_client, _chatsRepository)..init();
        _chatsOutboxWorker ??= ChatsOutboxWorker(_client, _chatsRepository, _chatsOutboxRepository)..init();
      }
      if (_messagingConfig.coreSmsSupport) {
        _smsSyncWorker ??= SmsSyncWorker(_client, _smsRepository)..init();
        _smsOutboxWorker ??= SmsOutboxWorker(_client, _smsRepository, _smsOutboxRepository)..init();
      }

      emit(state.copyWith(status: ConnectionStatus.connected));
    } on Exception catch (e, s) {
      _client.dispose();
      emit(state.copyWith(status: ConnectionStatus.error, error: e));
      _logger.severe('_onClientConnected', e, s);
      CrashlyticsUtils.recordError(e, stack: s, reason: 'MessagingBloc._onClientConnected');
      // _submitNotification(DefaultErrorNotification(e));
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

  void _onDisconnect(Disconnect event, Emitter<MessagingState> emit) {
    _disposeWorkers();
    _client.dispose();
    emit(state.copyWith(status: ConnectionStatus.initial));
  }

  Future<void> wipeData() async {
    await _chatsRepository.wipeChatsData();
    await _chatsOutboxRepository.wipeOutboxData();
    await _smsRepository.wipeData();
    await _smsOutboxRepository.wipeOutboxData();
  }

  void _disposeWorkers() {
    _chatsSyncWorker?.dispose();
    _chatsSyncWorker = null;
    _chatsOutboxWorker?.dispose();
    _chatsOutboxWorker = null;
    _smsSyncWorker?.dispose();
    _smsSyncWorker = null;
    _smsOutboxWorker?.dispose();
    _smsOutboxWorker = null;
  }

  void _disposeSubscriptions() {
    _subs.forEach((sub) => sub.cancel());
    _subs.clear();
  }

  @override
  Future<void> close() {
    _disposeWorkers();
    _disposeSubscriptions();
    _client.dispose();
    return super.close();
  }
}

/// Filters out specific error notifications based on their type and code.
/// To skip notification displaying
// bool _errorNotificationFilter(Object error) {
//   if (error is MessagingSocketException) {
//     switch (error.code) {
//       case kPhxSocketClosedCode:
//         return false;
//       case kPhxChannelClosedCode:
//         return false;
//     }
//   }
//   return true;
// }
