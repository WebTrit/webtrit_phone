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

    _updatesSub = _updatesSyncStream().listen((chat) {
      localChatRepository.upsertChat(chat);
      emit(state.copyWith(chats: state.chats.mergeWith(chat)));
    });
  }

  Stream<Chat> _updatesSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;
        if (userChannel == null) throw Exception('No user channel yet');
        if (userChannel.state != PhoenixChannelState.joined) throw Exception('User channel readynt');

        // Buffer updates that may come in a gap between fetching the list and subscribing
        List<Chat> updatesBuffer = [];
        late final StreamSubscription bufferSub;
        bufferSub = userChannel.messages.where((msg) => msg.event.value == 'chat_update').listen((msg) {
          final chat = Chat.fromMap(msg.payload as Map<String, dynamic>);
          updatesBuffer.add(chat);
        });

        // Get last local update time for sync from
        // If no update time, fetch all chats
        DateTime? lastUpdate = await localChatRepository.getLastChatUpdate();

        if (lastUpdate == null) {
          // Fetch initial chat list state
          final req = await userChannel.push('chat_list_get', {}).future;
          final chatList = (req.response['data'] as List).map((e) => Chat.fromMap(e)).toList();

          // Yield fetched chats
          for (final chat in chatList) {
            yield chat;
          }
        } else {
          // Fetch chat list updates
          while (true) {
            final req = await userChannel.push('chat_list_updates', {
              'updates_from': lastUpdate!.microsecondsSinceEpoch,
              'limit': 200,
            }).future;
            final chatList = (req.response['data'] as List).map((e) => Chat.fromMap(e)).toList();

            // If no more chats, break the loop
            if (chatList.isEmpty) {
              break;
            }

            // Yield fetched chats
            for (final chat in chatList) {
              yield chat;
            }

            // Update last update time
            lastUpdate = chatList.last.updatedAt;
          }
        }

        // Yield buffered updates
        bufferSub.cancel();
        for (final chat in updatesBuffer) {
          yield chat;
        }

        // Listen for realtime updates
        // On disconnect break the loop to force reconnect
        await for (final msg in userChannel.messages) {
          if (msg.event.value == 'chat_update') {
            final chat = Chat.fromMap(msg.payload as Map<String, dynamic>);
            yield chat;
          }
          if (msg.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e) {
        _logger.severe('_syncAndSubscribeAsyncGen error:', e);
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Future<void> close() {
    _updatesSub?.cancel();
    return super.close();
  }
}
