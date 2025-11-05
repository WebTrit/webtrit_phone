import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/extensions/iterable.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('ChatsSyncWorker');

/// A worker class responsible for synchronizing chat data.
///
/// The `ChatsSyncWorker` class handles the synchronization of chat messages
/// and related data between the local storage and the remote server. This
/// ensures that the chat data is up-to-date and consistent across different
/// devices and sessions.
///
/// This class may include methods for:
/// - Fetching new messages from the server.
/// - Sending unsent messages to the server.
/// - Resolving conflicts between local and remote data.
/// - Handling network errors and retries.
///
/// Usage:
/// ```dart
/// final syncWorker = ChatsSyncWorker();
/// syncWorker.init();
/// ```
class ChatsSyncWorker {
  ChatsSyncWorker(
    this.client,
    this.chatsRepository,
    this.onError, {
    this.pageSize = 50,
    this.listThrottle = const Duration(seconds: 1),
    this.roomThrottle = const Duration(seconds: 5),
  });

  final PhoenixSocket client;
  final ChatsRepository chatsRepository;
  final Function(Object) onError;
  final int pageSize;
  final Duration listThrottle;
  final Duration roomThrottle;

  StreamSubscription? _conversationsSyncSub;
  final Map<int, StreamSubscription> _conversationSyncSubs = {};

  Future init() async {
    _logger.fine('Initialising...');
    _closeSubs();
    _conversationsSyncSub = _conversationsSyncStream().listen((e) {
      if (e is (Object, StackTrace)) {
        final (error, stackTrace) = e;
        _logger.warning('conversations sync error:', error, stackTrace);
        onError(error);
      } else {
        _logger.fine('conversations sync event: $e');
      }
    });
  }

  Future dispose() async {
    _logger.fine('Disposing...');
    _closeSubs();
  }

  Future _conversationSubscribe(int id) async {
    _logger.fine('Subscribing to conversation $id');

    PhoenixChannel? channel = client.getChatChannel(id);

    if (channel == null) {
      channel = client.createChatChannel(id);
      await channel.connect().catchError((e, s) {
        _logger.warning('Failed to connect to chat conversation $id', e, s);
        onError(e);
      });
    }

    _conversationSyncSubs.putIfAbsent(
      id,
      () => _conversationSyncStream(id, channel!).listen((e) {
        if (e is (Object, StackTrace)) {
          final (error, stackTrace) = e;
          _logger.warning('conversation sync error: $id', error, stackTrace);
          onError(error);
        } else {
          _logger.fine('conversation sync event: $id $e');
        }
      }),
    );
  }

  Future _conversationUnsubscribe(int id) async {
    _logger.fine('Unsubscribing from $id');
    _conversationSyncSubs.remove(id)?.cancel();
    await client.getChatChannel(id)?.leave().future;
  }

  Stream<dynamic> _conversationsSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;

        // Check if connection ready to use
        final connected = userChannel != null && userChannel.state == PhoenixChannelState.joined;
        if (!connected) continue;

        // Buffer updates that may come in a gap between fetching the actual list
        final eventsStream = userChannel.userEvents.transform(BufferTransformer());

        // Get current user chat ids
        final currentChatIds = await chatsRepository.getChatIds();

        // Fetch and process actual user chat conversations
        final actualIds = await userChannel.chatConversationsIds;
        await Future.forEach(actualIds, (id) => _conversationSubscribe(id));
        final removeIds = currentChatIds.where((id) => !actualIds.contains(id));
        await Future.forEach(removeIds, (id) async {
          await _conversationUnsubscribe(id);
          await chatsRepository.deleteChatById(id);
        });
        yield {'actualIds': actualIds, 'removeIds': removeIds};

        // Process buffered and listen for future events
        eventsIterator:
        await for (final event in eventsStream) {
          yield event;
          switch (event) {
            case ChatConversationJoin _:
              await _conversationSubscribe(event.chatId);
            case ChatConversationLeave _:
              await _conversationUnsubscribe(event.chatId);
              await chatsRepository.deleteChatById(event.chatId);
            case UserChannelDisconnect _:
              break eventsIterator;
            default:
          }
        }
      } catch (e, s) {
        yield (e, s);
      } finally {
        _closeConversationSubs();
        yield await Future.delayed(listThrottle, () => _kRetryStub);
      }
    }
  }

  Stream<dynamic> _conversationSyncStream(int id, PhoenixChannel channel) async* {
    while (true) {
      try {
        // Check if connection ready to use
        final connected = (channel.state == PhoenixChannelState.joined);
        if (!connected) continue;

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
        final newestCursor = await chatsRepository.getChatMessageSyncCursor(id, MessageSyncCursorType.newest);

        /// If no last update, fetch history of last [pageSize] messages for initial state
        if (newestCursor == null) {
          final messages = await channel.chatMessagHistory(pageSize);
          yield 'Initial messages: ${messages.length}';

          if (messages.isNotEmpty) {
            // Process fetched messages
            await chatsRepository.upsertMessages(messages.reversed);

            // set initial cursors
            // Pay attention, the history is fetched in reverse order
            await chatsRepository.upsertChatMessageSyncCursor(
              ChatMessageSyncCursor(
                chatId: id,
                cursorType: MessageSyncCursorType.oldest,
                time: messages.last.createdAt,
              ),
            );
            await chatsRepository.upsertChatMessageSyncCursor(
              ChatMessageSyncCursor(
                chatId: id,
                cursorType: MessageSyncCursorType.newest,
                time: messages.first.updatedAt,
              ),
            );
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
                chatId: id,
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
        eventsIterator:
        await for (final event in eventsStream) {
          yield event;
          switch (event) {
            case ChatChannelInfoUpdate _:
              // Skip upsert for event where user is leaved from chat
              final shouldSkip = event.chat.members.firstWhereOrNull((m) => m.userId == client.userId) == null;
              if (!shouldSkip) await chatsRepository.upsertChat(event.chat);
            case ChatChannelMessageUpdate _:
              await chatsRepository.upsertMessage(event.message);
              final cursor = ChatMessageSyncCursor(
                chatId: id,
                cursorType: MessageSyncCursorType.newest,
                time: event.message.updatedAt,
              );
              await chatsRepository.upsertChatMessageSyncCursor(cursor);
            case ChatChannelCursorSet _:
              await chatsRepository.upsertChatMessageReadCursor(event.cursor);
            case ChatChannelDisconnect _:
              break eventsIterator;
            default:
          }
        }
      } catch (e, s) {
        yield (e, s);
      } finally {
        yield await Future.delayed(roomThrottle, () => _kRetryStub);
      }
    }
  }

  void _closeSubs() {
    _conversationsSyncSub?.cancel();
    _closeConversationSubs();
  }

  void _closeConversationSubs() {
    _conversationSyncSubs.forEach((key, value) => value.cancel());
    _conversationSyncSubs.clear();
  }
}

const _kRetryStub = 'retry';
