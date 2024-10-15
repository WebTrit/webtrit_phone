import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('ChatsSyncWorker');

class ChatsSyncWorker {
  ChatsSyncWorker(this.client, this.chatsRepository, {this.pageSize = 50});

  final PhoenixSocket client;
  final ChatsRepository chatsRepository;
  final int pageSize;

  StreamSubscription? _chatlistSyncSub;
  final Map<int, StreamSubscription> _chatRoomSyncSubs = {};

  Future init() async {
    _logger.info('Initialising...');
    await _closeSubs();
    _chatlistSyncSub = _chatlistSyncStream().listen((e) => _logger.info('_chatlistSyncStream event: $e'));
  }

  Future dispose() async {
    _logger.info('Disposing...');
    await _closeSubs();
  }

  Future _chatRoomSubscribe(int chatId) async {
    _logger.info('Subscribing to chat $chatId');
    PhoenixChannel? channel = client.getChatChannel(chatId);
    if (channel == null) {
      channel = client.createChatChannel(chatId);
      await channel.join().future;
    }

    _chatRoomSyncSubs.putIfAbsent(
      chatId,
      () => _chatRoomSyncStream(chatId, channel!)
          .listen((e) => _logger.info('_chatRoomSyncStream chat: $chatId event: $e')),
    );
  }

  Future _chatRoomUnsubscribe(int chatId) async {
    _logger.info('Unsubscribing from chat $chatId');
    _chatRoomSyncSubs.remove(chatId)?.cancel();
    await client.getChatChannel(chatId)?.leave().future;
  }

  Stream<dynamic> _chatlistSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;
        if (userChannel == null) throw Exception('No user channel yet');
        if (userChannel.state != PhoenixChannelState.joined) throw Exception('User channel not ready yet');

        // Buffer updates that may come in a gap between fetching the actual list
        final eventsStream = userChannel.userEvents.transform(BufferTransformer());

        // Get current user chat ids
        final currentChatIds = await chatsRepository.getChatIds();

        // Fetch and process actual user chat conversations
        final actualIds = await userChannel.chatConversationsIds;
        await Future.forEach(actualIds, (id) => _chatRoomSubscribe(id));
        final removeIds = currentChatIds.where((id) => !actualIds.contains(id));
        await Future.forEach(removeIds, (id) async {
          await _chatRoomUnsubscribe(id);
          await chatsRepository.deleteChatById(id);
        });
        yield {'actualIds': actualIds, 'removeIds': removeIds};

        // Process buffered and listen for future events
        await for (final event in eventsStream) {
          switch (event) {
            case ChatConversationJoin chatEvent:
              await _chatRoomSubscribe(chatEvent.chatId);
            case ChatConversationLeave chatEvent:
              await _chatRoomUnsubscribe(chatEvent.chatId);
              await chatsRepository.deleteChatById(chatEvent.chatId);
            case UserChannelDisconnect _:
              throw Exception('disconnect');
            default:
          }

          yield event;
        }
      } catch (e, _) {
        yield e;
      } finally {
        _chatRoomSyncSubs.forEach((key, value) => value.cancel());
        _chatRoomSyncSubs.clear();
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
        yield {'event': 'retry'}; // Do not remove this yield, it's important for break on close stream
      }
    }
  }

  Stream<dynamic> _chatRoomSyncStream(int chatId, PhoenixChannel channel) async* {
    while (true) {
      try {
        _logger.info('Chat channel state: $chatId ${channel.state}');
        if (channel.state != PhoenixChannelState.joined) throw Exception('Chat channel not ready yet');

        // Buffer updates that may come in a gap between fetching and subscribing
        final eventsStream = channel.chatEvents.transform(BufferTransformer());

        // Fetch chat conversation data
        final conversation = await channel.chatConversation;
        await chatsRepository.upsertChat(conversation);
        yield conversation;

        // Fetch read cursors
        final cursors = await channel.chatCursors;
        await Future.forEach(cursors, (cursor) => chatsRepository.upsertChatMessageReadCursor(cursor));
        yield cursors;

        // Get last update time for sync messages from
        final newestCursor = await chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.newest);

        /// If no last update, fetch history of last [pageSize] messages for initial state
        if (newestCursor == null) {
          final messages = await channel.chatMessagHistory(pageSize);
          yield 'Initial messages: ${messages.length}';

          if (messages.isNotEmpty) {
            // Process fetched messages
            await chatsRepository.upsertMessages(messages.reversed);

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
            final messages = await channel.chatMessageUpdates(pagingCursor.time, pageSize);
            yield 'New messages: ${messages.length}';

            // If no more messages, break the pagination loop
            if (messages.isNotEmpty) {
              // Process fetched messages
              await chatsRepository.upsertMessages(messages);

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
            // that means no need to fetch more messages using next iteration
            if (messages.length < pageSize) break;
          }
        }

        // Process buffered and listen for future events
        await for (final event in eventsStream) {
          switch (event) {
            case ChatChannelInfoUpdate e:
              // Skip upsert for event where user is leaved from chat
              final shouldSkip = e.chat.members.firstWhereOrNull((m) => m.userId == client.userId) == null;
              if (!shouldSkip) await chatsRepository.upsertChat(e.chat);
            case ChatChannelMessageUpdate e:
              await chatsRepository.upsertMessage(e.message);
              final cursor = ChatMessageSyncCursor(
                chatId: chatId,
                cursorType: MessageSyncCursorType.newest,
                time: e.message.updatedAt,
              );
              await chatsRepository.upsertChatMessageSyncCursor(cursor);
            case ChatChannelCursorSet e:
              await chatsRepository.upsertChatMessageReadCursor(e.cursor);
            case ChatChannelDisconnect _:
              throw Exception('disconnect');
            case ChatChannelUnknown _:
          }

          yield event;
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

  Future<void> _closeSubs() async {
    _chatlistSyncSub?.cancel();
    _chatRoomSyncSubs.forEach((key, value) => value.cancel());
    _chatRoomSyncSubs.clear();
  }
}
