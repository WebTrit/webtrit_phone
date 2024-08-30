// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:webtrit_phone/extensions/iterable.dart';

import 'package:webtrit_phone/features/chats/chats.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: implelemnt skip since for chat info
// TODO: extract events and commands to separate classes

final _logger = Logger('ChatsSyncWorker');

class ChatsSyncWorker {
  ChatsSyncWorker(
    this.client,
    this.chatsRepository, {
    this.pageSize = 50,
    this.pushTimeout = const Duration(seconds: 10),
  }) {
    // TODO: Remove this before pr
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final PhoenixSocket client;
  final ChatsRepository chatsRepository;
  final int pageSize;
  final Duration pushTimeout;

  StreamSubscription? _chatlistSyncSub;
  final Map<int, StreamSubscription> _chatRoomSyncSubs = {};

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
    _chatRoomSyncSubs.putIfAbsent(
      chatId,
      () => _chatRoomSyncStream(chatId).listen((e) => _logger.info('_chatRoomSyncStream event: $e')),
    );
  }

  _chatRoomUnsubscribe(int chatId) {
    _logger.info('Unsubscribing from chat $chatId');
    _chatRoomSyncSubs.remove(chatId)?.cancel();
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
        final req = await userChannel.push('chat:user_chat_ids', {}, pushTimeout).future;
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
            final chatId = int.parse(e.payload!['chat_id'].toString());
            _chatRoomSubscribe(chatId);
            yield {'event': 'joined', chatId: chatId};
          }

          if (e.event.value == 'chat_membership_leave') {
            final chatId = int.parse(e.payload!['chat_id'].toString());
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
        yield e;
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
        yield {'event': 'retry'}; // Do not remove this yield, it's important for break on close stream
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
        final req = await channel.push('chat:info', {}, pushTimeout).future;
        final chat = Chat.fromMap(req.response as Map<String, dynamic>);
        await chatsRepository.upsertChat(chat);
        _logger.info('Chat info: $chat');
        yield chat;

        // Get last update time for sync messages from
        final newestCursor = await chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.newest);

        // If no last update, fetch history of last 100 messages for initial state
        if (newestCursor == null) {
          final payload = {'limit': pageSize};
          final req = await channel.push('message:history', payload, pushTimeout).future;
          final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

          if (messages.isNotEmpty) {
            // Process fetched messages
            for (final msg in messages.reversed) {
              await chatsRepository.upsertMessage(msg);
              yield msg;
            }

            // set initial cursors
            // Pay attention, the history is fetched in reverse order
            await chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
              chatId: chatId,
              cursorType: MessageSyncCursorType.oldest,
              time: messages.last.createdAt,
            ));
            await chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
              chatId: chatId,
              cursorType: MessageSyncCursorType.newest,
              time: messages.first.updatedAt,
            ));
          }
        }

        // Fetch message updates since last update using pagination
        // eg. new messages, edited, deleted, viewed, etc.
        if (newestCursor != null) {
          var pagingCursor = newestCursor;
          while (true) {
            final payload = {'updated_after': pagingCursor.time.toUtc().toIso8601String(), 'limit': pageSize};
            final req = await channel.push('message:updates', payload, pushTimeout).future;
            final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

            // If no more messages, break the pagination loop
            if (messages.isNotEmpty) {
              // Process fetched messages
              for (final msg in messages) {
                await chatsRepository.upsertMessage(msg);
                yield msg;
              }

              // Update local newest cursor to continue pagination
              pagingCursor = ChatMessageSyncCursor(
                chatId: chatId,
                cursorType: MessageSyncCursorType.newest,
                time: messages.last.updatedAt,
              );

              // Set the newest cursor
              await chatsRepository.upsertChatMessageSyncCursor(pagingCursor);
            }
            // Break pagination loop if results less than limit
            if (messages.length < pageSize) break;
          }
        }

        // Process buffered and listen for future realtime updates
        await for (final e in eventsStream) {
          _logger.info('Chat channel event $chatId: $e');

          if (e.event.value == 'chat_info_update') {
            final userId = client.userId!;
            final chat = Chat.fromMap(e.payload as Map<String, dynamic>);

            // Skip upsert for event where user is leaved from chat
            if (chat.members.firstWhereOrNull((m) => m.userId == userId) != null) {
              await chatsRepository.upsertChat(chat);
            }

            yield chat;
          }

          if (e.event.value == 'message_update') {
            final chatMsg = ChatMessage.fromMap(e.payload as Map<String, dynamic>);
            await chatsRepository.upsertMessage(chatMsg);
            await chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
              chatId: chatId,
              cursorType: MessageSyncCursorType.newest,
              time: chatMsg.updatedAt,
            ));
            yield chatMsg;
          }

          if (e.event.value == 'messages_viewed') {
            final messageIds = (e.payload!['message_ids'] as List).cast<int>();
            final viewedAt = DateTime.parse(e.payload!['viewed_at'] as String);
            await chatsRepository.updateViews(messageIds, viewedAt);
            await chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
              chatId: chatId,
              cursorType: MessageSyncCursorType.newest,
              time: viewedAt,
            ));
          }

          // On disconnect break the loop to force reconnect
          if (e.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e, _) {
        yield e;
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
        yield {'event': 'retry'}; // Do not remove this yield, it's important for break on close stream
      }
    }
  }

  void _closeSubs() {
    _chatlistSyncSub?.cancel();
    _chatRoomSyncSubs.values.forEach((sub) => sub.cancel());
    _chatRoomSyncSubs.clear();
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
