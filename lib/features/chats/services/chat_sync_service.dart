import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/chats/chats.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatsSyncService');

class ChatsSyncService {
  ChatsSyncService(this.client, this.chatsRepository) {
    // TODO: Remove this before pr
    _logger.onRecord.listen((record) {
      // ignore: avoid_print
      print('\x1B[33mcht: ${record.message}\x1B[0m');
    });
  }

  final PhoenixSocket client;
  final ChatsRepository chatsRepository;

  StreamSubscription? _chatlistSyncSub;
  Map<int, StreamSubscription> chatRoomSyncSubs = {};

  void init() async {
    _logger.info('Initialising...');
    _closeSubs();
    _chatlistSyncSub = _chatlistSyncStream().listen((e) => _logger.info('_chatlistSyncStream event: $e'));
  }

  void dispose() {
    _logger.info('Disposing...');
    _closeSubs();
  }

  _chatRoomSubscribe(int chatId) {
    _logger.info('Subscribing to chat $chatId');
    chatRoomSyncSubs.putIfAbsent(
      chatId,
      () => _chatRoomSyncStream(chatId).listen((e) => _logger.info('_chatRoomSyncStream event: $e')),
    );
  }

  _chatRoomUnsubscribe(int chatId) {
    _logger.info('Unsubscribing from chat $chatId');
    chatRoomSyncSubs.remove(chatId)?.cancel();
    client.getChatChannel(chatId)?.leave();
  }

  Stream<dynamic> _chatlistSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;
        if (userChannel == null) throw Exception('No user channel yet');
        if (userChannel.state != PhoenixChannelState.joined) throw Exception('User channel not ready yet');

        // Get current user chat ids
        final currentChatIds = await chatsRepository.getChatIds();

        // // Buffer updates that may come in a gap between fetching the actual list
        final eventsStream = userChannel.messages.transform(StreamBuffer());

        // Fetch actual user chat ids
        final req = await userChannel.push('chat:user_chat_ids', {}).future;
        final actualChatIds = req.response.cast<int>();

        // Process removed chats
        for (final chatId in currentChatIds) {
          if (!actualChatIds.contains(chatId)) {
            _chatRoomUnsubscribe(chatId);
            await chatsRepository.deleteChatById(chatId);
            yield {'event': 'removed', chatId: chatId};
          }
        }

        // Process actual chats
        for (final chatId in actualChatIds) {
          _chatRoomSubscribe(chatId);
          yield {'event': 'actual', chatId: chatId};
        }

        // Process buffered and listen for future realtime updates
        await for (final e in eventsStream) {
          if (e.event.value == 'chat_membership_join') {
            final chatId = e.payload!['chat_id'];
            _chatRoomSubscribe(chatId);
            yield {'event': 'joined', chatId: chatId};
          }

          if (e.event.value == 'chat_membership_leave') {
            final chatId = e.payload!['chat_id'];
            _chatRoomUnsubscribe(chatId);
            await chatsRepository.deleteChatById(chatId);
            yield {'event': 'leaved', chatId: chatId};
          }

          // On disconnect break the loop to force reconnect
          if (e.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e, _) {
        // _logger.severe('_chatlistSyncStream error:', e,s);
        yield {'event': 'error', 'error': e};
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Stream<dynamic> _chatRoomSyncStream(int chatId) async* {
    while (true) {
      try {
        PhoenixChannel? channel = client.getChatChannel(chatId);
        if (channel == null) {
          channel = client.createChatChannel(chatId);
          await channel.join().future;
        }

        _logger.info('Chat channel state: $chatId ${channel.state}');
        if (channel.state != PhoenixChannelState.joined) throw Exception('Chat channel not ready yet');

        // Buffer updates that may come in a gap between fetching and subscribing
        final eventsStream = channel.messages.transform(StreamBuffer());

        // Fetch chat info
        final req = await channel.push('chat:info', {}).future;
        final chat = Chat.fromMap(req.response as Map<String, dynamic>);
        await chatsRepository.upsertChat(chat);
        _logger.info('Chat info: $chat');
        yield chat;

        // Get last update time for sync messages from
        DateTime? lastUpdate = await chatsRepository.lastChatMessageUpdatedAt(chatId);

        // If no last update, fetch history of last 100 messages for initial state
        if (lastUpdate == null) {
          final payload = {'limit': 100};
          final req = await channel.push('message:history', payload).future;
          final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

          // Process fetched messages
          for (final msg in messages) {
            await chatsRepository.insertMessage(msg);
            yield msg;
          }
        }

        // Fetch message updates since last update using pagination
        // eg. new messages, edited, deleted, viewed, etc.
        if (lastUpdate != null) {
          while (true) {
            final payload = {'updated_after': lastUpdate!.toUtc().toIso8601String(), 'limit': 100};
            final req = await channel.push('message:updates', payload).future;
            final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

            // If no more messages, break the pagination loop
            if (messages.isEmpty) {
              break;
            }

            // Process fetched messages
            for (final msg in messages) {
              await chatsRepository.upsertMessageUpdate(msg);
              yield msg;
            }

            // Update last update time
            lastUpdate = messages.last.updatedAt;
          }
        }

        // Process buffered and listen for future realtime updates
        await for (final e in eventsStream) {
          _logger.info('Chat channel event $chatId: $e');

          if (e.event.value == 'chat_info_update') {
            final chat = Chat.fromMap(e.payload as Map<String, dynamic>);
            await chatsRepository.upsertChat(chat);
            yield chat;
          }

          if (e.event.value == 'message_update') {
            final chatMsg = ChatMessage.fromMap(e.payload as Map<String, dynamic>);
            await chatsRepository.upsertMessageUpdate(chatMsg);
            yield chatMsg;
          }

          // TODO: read cursor update

          // On disconnect break the loop to force reconnect
          if (e.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e, _) {
        // _logger.severe('_chatRoomSyncStream error: $chatId', e, s);
        yield {'event': 'error', 'error': e};
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  void _closeSubs() {
    _chatlistSyncSub?.cancel();
    for (var key in chatRoomSyncSubs.keys) {
      chatRoomSyncSubs.remove(key)?.cancel();
    }
  }
}

/// A [StreamTransformer] that captures events from the source [Stream] and
/// hold events inside [StreamController] until the sink [Stream] being listened.
class StreamBuffer<T> extends StreamTransformerBase<T, T> {
  StreamBuffer();

  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();

    final StreamSubscription(:cancel, :pause, :resume) = stream.listen(
      controller.add,
      onError: controller.addError,
      onDone: controller.close,
    );

    controller.onCancel = cancel;
    controller.onPause = pause;
    controller.onResume = resume;

    return controller.stream;
  }
}
