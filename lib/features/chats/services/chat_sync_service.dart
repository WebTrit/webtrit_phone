import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/chats/chats.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatsSyncService');

class ChatsSyncService {
  ChatsSyncService(this.client, this.localChatRepository) {
    // TODO: Remove this before pr
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final PhoenixSocket client;
  final LocalChatRepository localChatRepository;

  StreamSubscription? _chatlistSyncSub;
  Map<int, StreamSubscription> messagesSyncSubs = {};

  void init() async {
    dispose();
    await Future.microtask(() {});
    _logger.info('Initialising');

    final activeChatIds = await localChatRepository.getActiveChatIds();
    for (final chatId in activeChatIds) {
      messagesSyncSubs[chatId] = _subscribeToMessages(chatId);
    }
    _logger.info('Init active chat ids: $activeChatIds');

    _chatlistSyncSub = _chatlistSyncStream().listen((chat) {
      _logger.info('Chat update event: $chat');
      _upsertMessageSubscription(chat);
    });
  }

  _upsertMessageSubscription(Chat chat) {
    final activeMember = chat.members.isActiveMember(client.userId!);
    final activeChat = chat.deletedAt == null;
    final shouldSubscribe = activeMember && activeChat;

    if (shouldSubscribe) {
      messagesSyncSubs.putIfAbsent(chat.id, () => _subscribeToMessages(chat.id));
    } else {
      _removeMessageSubscription(chat.id);
    }

    _logger.info('Message subscription updated: chatId=${chat.id}, activeMember=$activeMember, activeChat=$activeChat');
  }

  StreamSubscription _subscribeToMessages(int chatId) {
    final channel = client.createChatChannel(chatId);
    final messagesStream = _messagesSyncStream(chatId, channel);
    return messagesStream.listen((msg) => _logger.info('Message update event: $msg'));
  }

  _removeMessageSubscription(int chatId) {
    messagesSyncSubs.remove(chatId)?.cancel();
    client.removeChatChannel(chatId);
  }

  Stream<Chat> _chatlistSyncStream() async* {
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
          final req = await userChannel.push('chat:list', {}).future;
          final chatList = (req.response['data'] as List).map((e) => Chat.fromMap(e)).toList();

          // Yield fetched chats
          for (final chat in chatList) {
            await localChatRepository.upsertChat(chat);
            yield chat;
          }
        } else {
          // Fetch chat list updates
          while (true) {
            final req = await userChannel
                .push('chat:list', {'updated_after': lastUpdate!.toUtc().toIso8601String(), 'limit': 100}).future;
            final chatList = (req.response['data'] as List).map((e) => Chat.fromMap(e)).toList();

            // If no more chats, break the loop
            if (chatList.isEmpty) {
              break;
            }

            // Yield fetched chats
            for (final chat in chatList) {
              await localChatRepository.upsertChat(chat);
              yield chat;
            }

            // Update last update time
            lastUpdate = chatList.last.updatedAt;
          }
        }

        // Yield buffered updates
        bufferSub.cancel();
        for (final chat in updatesBuffer) {
          await localChatRepository.upsertChat(chat);
          yield chat;
        }

        // Listen for realtime updates
        // On disconnect break the loop to force reconnect
        await for (final msg in userChannel.messages) {
          if (msg.event.value == 'chat_update') {
            final chat = Chat.fromMap(msg.payload as Map<String, dynamic>);
            await localChatRepository.upsertChat(chat);
            yield chat;
          }
          if (msg.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e) {
        _logger.severe('_chatlistSyncStream error:', e);
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Stream<ChatMessage> _messagesSyncStream(int chatId, PhoenixChannel channel) async* {
    while (true) {
      try {
        if (channel.state != PhoenixChannelState.joined) throw Exception('Messages channel $chatId readynt');

        // Buffer updates that may come in a gap between fetching the list and subscribing
        List<ChatMessage> updatesBuffer = [];
        late final StreamSubscription bufferSub;
        bufferSub = channel.messages.where((msg) => msg.event.value == 'message_update').listen((msg) {
          final chat = ChatMessage.fromMap(msg.payload as Map<String, dynamic>);
          updatesBuffer.add(chat);
        });

        // Get last local update time for sync from
        // If no update time, fetch last bunch of messages
        DateTime? lastUpdate = await localChatRepository.lastChatMessageUpdatedAt(chatId);

        if (lastUpdate == null) {
          // Fetch last 100 messages for initial state
          final payload = {'limit': 100};
          final req = await channel.push('message:history', payload).future;
          final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

          // Yield fetched chats
          for (final msg in messages) {
            await localChatRepository.insertMessage(msg);
            yield msg;
          }
        } else {
          // Fetch message updates
          while (true) {
            final payload = {'updated_after': lastUpdate!.toUtc().toIso8601String(), 'limit': 100};
            final req = await channel.push('message:updates', payload).future;
            final messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();

            // If no more chats, break the loop
            if (messages.isEmpty) {
              break;
            }

            // Yield fetched chats
            for (final msg in messages) {
              await localChatRepository.upsertMessageUpdate(msg);
              yield msg;
            }

            // Update last update time
            lastUpdate = messages.last.updatedAt;
          }
        }

        // Yield buffered updates
        bufferSub.cancel();
        for (final msg in updatesBuffer) {
          await localChatRepository.upsertMessageUpdate(msg);
          yield msg;
        }

        // Listen for realtime updates
        // On disconnect break the loop to force reconnect
        await for (final msg in channel.messages) {
          if (msg.event.value == 'message_update') {
            final chatMsg = ChatMessage.fromMap(msg.payload as Map<String, dynamic>);
            await localChatRepository.upsertMessageUpdate(chatMsg);
            yield chatMsg;
          }
          if (msg.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e) {
        _logger.severe('_messagesSyncStream error:', e);
      } finally {
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  void dispose() {
    _chatlistSyncSub?.cancel();
    for (var key in messagesSyncSubs.keys) {
      messagesSyncSubs.remove(key)?.cancel();
    }
  }
}
