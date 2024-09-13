import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

// TODO: extract events and commands to separate classes

final _logger = Logger('SmsSyncWorker');

class SmsSyncWorker {
  SmsSyncWorker(
    this.client,
    this.smsRepository, {
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
  final SmsRepository smsRepository;
  final int pageSize;
  final Duration pushTimeout;

  StreamSubscription? _conversationlistSyncSub;
  final Map<int, StreamSubscription> _conversationSyncSubs = {};

  Future init() async {
    _logger.info('Initialising...');
    await _closeSubs();
    _conversationlistSyncSub =
        _conversationlistSyncStream().listen((e) => _logger.info('_chatlistSyncStream event: $e'));
  }

  Future dispose() async {
    _logger.info('Disposing...');
    await _closeSubs();
  }

  Future _conversationSubscribe(int conversationId) async {
    _logger.info('Subscribing to chat $conversationId');
    PhoenixChannel? channel = client.getSmsConversationChannel(conversationId);
    if (channel == null) {
      channel = client.createSmsConversationChannel(conversationId);
      await channel.join().future;
    }
    _conversationSyncSubs.putIfAbsent(
      conversationId,
      () => _conversationSyncStream(conversationId, channel!)
          .listen((e) => _logger.info('_conversationSyncStream id: $conversationId event: $e')),
    );
  }

  Future _conversationUnsubscribe(int conversationId) async {
    _logger.info('Unsubscribing from chat $conversationId');
    await _conversationSyncSubs.remove(conversationId)?.cancel();
    client.getSmsConversationChannel(conversationId)?.leave();
  }

  Stream<dynamic> _conversationlistSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;
        if (userChannel == null) throw Exception('No user channel yet');
        if (userChannel.state != PhoenixChannelState.joined) throw Exception('User channel not ready yet');

        // Get current ids
        final currentIds = await smsRepository.getConversationIds();

        // Buffer updates that may come in a gap between fetching the actual list
        final eventsStream = userChannel.messages.transform(BufferTransformer());

        // Fetch actual user chat ids
        final req = await userChannel.push('sms:conversation:get_ids', {}, pushTimeout).future;
        final actualChatIds = req.response.cast<int>();

        // Process removed chats
        for (final conversationId in currentIds) {
          if (!actualChatIds.contains(conversationId)) {
            await _conversationUnsubscribe(conversationId);
            await smsRepository.deleteConversationById(conversationId);
            yield {'event': 'removed', conversationId: conversationId};
          }
        }

        // Process actual chats
        for (final conversationId in actualChatIds) {
          await _conversationSubscribe(conversationId);
          yield {'event': 'actual', conversationId: conversationId};
        }

        // Process buffered and listen for future realtime updates
        await for (final e in eventsStream) {
          if (e.event.value == 'sms_conversation_join') {
            final conversationId = int.parse(e.payload!['conversation_id'].toString());
            await _conversationSubscribe(conversationId);
            yield {'event': 'joined', conversationId: conversationId};
          }

          if (e.event.value == 'sms_conversation_leave') {
            final conversationId = int.parse(e.payload!['conversation_id'].toString());
            await _conversationUnsubscribe(conversationId);
            await smsRepository.deleteConversationById(conversationId);
            yield {'event': 'leaved', conversationId: conversationId};
          }

          // On disconnect break the loop to force reconnect
          if (e.event.value == 'phx_error') {
            throw Exception('Phoenix disconnect');
          }
        }
      } catch (e, _) {
        yield e;
      } finally {
        for (var sub in _conversationSyncSubs.values) {
          await sub.cancel();
        }
        _conversationSyncSubs.clear();
        // Wait a sec before retrying
        await Future.delayed(const Duration(seconds: 1));
        yield {'event': 'retry'}; // Do not remove this yield, it's important for break on close stream
      }
    }
  }

  Stream<dynamic> _conversationSyncStream(int conversationId, PhoenixChannel channel) async* {
    while (true) {
      try {
        _logger.info('Sms channel state: $conversationId ${channel.state}');
        if (channel.state != PhoenixChannelState.joined) throw Exception('Chat channel not ready yet');

        // Buffer updates that may come in a gap between fetching and subscribing
        final eventsStream = channel.messages.transform(BufferTransformer());

        // Fetch chat info
        final infoReq = await channel.push('sms:conversation:get', {}, pushTimeout).future;
        final conversation = SmsConversation.fromMap(infoReq.response as Map<String, dynamic>);
        await smsRepository.upsertConversation(conversation);
        yield conversation;

        // Get last update time for sync messages from
        final newestCursor = await smsRepository.getMessageSyncCursor(conversationId, SmsSyncCursorType.newest);

        // If no last update, fetch history of last 100 messages for initial state
        if (newestCursor == null) {
          final payload = {'limit': pageSize};
          final req = await channel.push('sms:message:history', payload, pushTimeout).future;
          final messages = (req.response['data'] as List).map((e) => SmsMessage.fromMap(e)).toList();

          if (messages.isNotEmpty) {
            // Process fetched messages
            for (final msg in messages.reversed) {
              await smsRepository.upsertMessage(msg);
              yield msg;
            }

            // set initial cursors
            // Pay attention, the history is fetched in reverse order
            await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
              conversationId: conversationId,
              cursorType: SmsSyncCursorType.oldest,
              time: messages.last.createdAt,
            ));
            await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
              conversationId: conversationId,
              cursorType: SmsSyncCursorType.newest,
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
            final req = await channel.push('sms:message:updates', payload, pushTimeout).future;
            final messages = (req.response['data'] as List).map((e) => SmsMessage.fromMap(e)).toList();

            // If no more messages, break the pagination loop
            if (messages.isNotEmpty) {
              // Process fetched messages
              for (final msg in messages) {
                await smsRepository.upsertMessage(msg);
                yield msg;
              }

              // Update local newest cursor to continue pagination
              pagingCursor = SmsMessageSyncCursor(
                conversationId: conversationId,
                cursorType: SmsSyncCursorType.newest,
                time: messages.last.updatedAt,
              );

              // Set the newest cursor
              await smsRepository.upsertSmsMessageSyncCursor(pagingCursor);
            }
            // Break pagination loop if results less than limit
            if (messages.length < pageSize) break;
          }
        }

        // Process buffered and listen for future realtime updates
        await for (final e in eventsStream) {
          if (e.event.value == 'conversation_info_update') {
            final conversation = SmsConversation.fromMap(e.payload as Map<String, dynamic>);
            await smsRepository.upsertConversation(conversation);

            yield conversation;
          }

          if (e.event.value == 'message_update') {
            final chatMsg = SmsMessage.fromMap(e.payload as Map<String, dynamic>);
            await smsRepository.upsertMessage(chatMsg);
            await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
              conversationId: conversationId,
              cursorType: SmsSyncCursorType.newest,
              time: chatMsg.updatedAt,
            ));
            yield chatMsg;
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

  Future<void> _closeSubs() async {
    _conversationlistSyncSub?.cancel();
    for (var sub in _conversationSyncSubs.values) {
      await sub.cancel();
    }
    _conversationSyncSubs.clear();
  }
}
