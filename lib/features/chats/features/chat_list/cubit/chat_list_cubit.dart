import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/features/chats/chats.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_list_state.dart';

final _logger = Logger('ChatListCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit({
    required this.client,
    required this.localChatRepository,
  }) : super(ChatListState.initial()) {
    _init();
  }

  final PhoenixSocket client;
  final LocalChatRepository localChatRepository;
  StreamSubscription? _updatesSub;

  void _init() async {
    _logger.info('Initialising');

    final localChatList = await localChatRepository.getChats();
    emit(ChatListState(chats: localChatList, initialising: false));

    final lastUpdate = localChatList.fold<int?>(null, (acc, chat) {
      final epoh = chat.updatedAt.microsecondsSinceEpoch;
      return (epoh > (acc ?? 0)) ? epoh : acc;
    });

    _syncAndSubscribeRetryable(lastUpdate);
  }

  _syncAndSubscribeRetryable(int? lastUpdate, {int attempt = 1}) async {
    if (isClosed) return;
    try {
      await _syncAndSubscribe(lastUpdate);
    } on Exception catch (e) {
      _logger.severe('Failed to sync and subscribe', e);
      int delaySec = 1;
      if (attempt > 3) delaySec = 5;
      Future.delayed(Duration(seconds: delaySec), () => _syncAndSubscribeRetryable(lastUpdate));
    }
  }

  Future _syncAndSubscribe(int? lastUpdate) async {
    // TODO: buffer events during initial sync
    final userChannel = client.userChannel;

    Map<String, dynamic> syncRequest = {};
    if (lastUpdate != null) syncRequest['since'] = lastUpdate;
    final req = await userChannel.push('chat_list_get', syncRequest).future;
    final response = req.response;

    if (response['data'] is List) {
      final chatList = (response['data'] as List).map((e) => Chat.fromMap(e)).toList();
      for (final chat in chatList) {
        await localChatRepository.upsertChat(chat);
        emit(state.copyWith(chats: state.chats.mergeWith(chat)));
      }
    }
    _updatesSub?.cancel();
    _updatesSub = userChannel.messages.listen((msg) {
      if (msg.event.value == 'chat_update') {
        final chat = Chat.fromMap(msg.payload as Map<String, dynamic>);
        localChatRepository.upsertChat(chat);
        emit(state.copyWith(chats: state.chats.mergeWith(chat)));
      }
    });
  }

  @override
  Future<void> close() {
    _updatesSub?.cancel();
    return super.close();
  }
}
