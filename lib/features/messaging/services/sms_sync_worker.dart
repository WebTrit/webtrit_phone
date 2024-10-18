import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('SmsSyncWorker');

/// A worker class responsible for synchronizing SMS messages.
///
/// The `SmsSyncWorker` class handles the process of syncing SMS messages
/// between the local storage and a remote server. It ensures that all
/// messages are up-to-date and consistent across different platforms.
///
/// This class may include methods for initiating the sync process,
/// handling conflicts, and managing the state of the synchronization.
///
/// Example usage:
///
/// ```dart
/// final smsSyncWorker = SmsSyncWorker();
/// smsSyncWorker.init();
/// ```
class SmsSyncWorker {
  SmsSyncWorker(this.client, this.smsRepository, {this.pageSize = 50});

  final PhoenixSocket client;
  final SmsRepository smsRepository;
  final int pageSize;

  StreamSubscription? _conversationlistSyncSub;
  final Map<int, StreamSubscription> _conversationSyncSubs = {};

  Future init() async {
    _logger.info('Initialising...');
    await _closeSubs();
    _conversationlistSyncSub =
        _conversationlistSyncStream().listen((e) => _logger.info('_conversationlistSyncStream event: $e'));
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
    _conversationSyncSubs.remove(conversationId)?.cancel();
    await client.getSmsConversationChannel(conversationId)?.leave().future;
  }

  Stream<dynamic> _conversationlistSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;
        if (userChannel == null) throw Exception('No user channel yet');
        if (userChannel.state != PhoenixChannelState.joined) throw Exception('User channel not ready yet');

        // Fetch user phone numbers
        final smsNumbers = await userChannel.smsPhoneNumbers;
        await smsRepository.upsertUserSmsNumbers(smsNumbers);

        // Buffer updates that may come in a gap between fetching the actual list
        final eventsStream = userChannel.userEvents.transform(BufferTransformer());

        // Get current ids
        final currentIds = await smsRepository.getConversationIds();

        // Fetch and process actual user sms conversations
        final actualIds = await userChannel.smsConversationsIds;
        await Future.forEach(actualIds, (id) => _conversationSubscribe(id));
        final removeIds = currentIds.where((id) => !actualIds.contains(id));
        await Future.forEach(removeIds, (id) async {
          await _conversationUnsubscribe(id);
          await smsRepository.deleteConversationById(id);
        });
        yield {'actualIds': actualIds, 'removeIds': removeIds};

        // Process buffered and listen for future events
        await for (final event in eventsStream) {
          switch (event) {
            case SmsConversationJoin smsEvent:
              await _conversationSubscribe(smsEvent.conversationId);
            case SmsConversationLeave smsEvent:
              await _conversationUnsubscribe(smsEvent.conversationId);
              await smsRepository.deleteConversationById(smsEvent.conversationId);
            case UserChannelDisconnect _:
              throw Exception('disconnect');
            default:
          }

          yield event;
        }
      } catch (e, _) {
        yield e;
      } finally {
        _conversationSyncSubs.forEach((key, value) => value.cancel());
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
        final eventsStream = channel.smsEvents.transform(BufferTransformer());

        // Fetch sms conversation data
        final conversation = await channel.smsConversation;
        await smsRepository.upsertConversation(conversation);
        yield conversation;

        // Fetch read cursors
        final cursors = await channel.smsCursors;
        await Future.forEach(cursors, (cursor) => smsRepository.upsertMessageReadCursor(cursor));
        yield cursors;

        // Get last update time for sync messages from
        final newestCursor = await smsRepository.getMessageSyncCursor(conversationId, SmsSyncCursorType.newest);

        // If no last update, fetch history of last [pageSize] messages for initial state
        if (newestCursor == null) {
          final messages = await channel.smsMessageHistory(pageSize);
          yield 'Initial messages: ${messages.length}';

          if (messages.isNotEmpty) {
            // Process fetched messages
            await smsRepository.upsertMessages(messages.reversed);

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
            final messages = await channel.smsMessageUpdates(pagingCursor.time, pageSize);
            yield 'New messages: ${messages.length}';

            // If no more messages, break the pagination loop
            if (messages.isNotEmpty) {
              // Process fetched messages
              await smsRepository.upsertMessages(messages);

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
            // that means no need to fetch more messages using next iteration
            if (messages.length < pageSize) break;
          }
        }

        // Process buffered and listen for future events
        await for (final event in eventsStream) {
          switch (event) {
            case SmsChannelInfoUpdate e:
              await smsRepository.upsertConversation(e.conversation);
            case SmsChannelMessageUpdate e:
              await smsRepository.upsertMessage(e.message);
              await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
                conversationId: conversationId,
                cursorType: SmsSyncCursorType.newest,
                time: e.message.updatedAt,
              ));
            case SmsChannelCursorSet e:
              await smsRepository.upsertMessageReadCursor(e.cursor);
            case SmsChannelDisconnect _:
              throw Exception('disconnect');
            default:
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
    _conversationlistSyncSub?.cancel();
    _conversationSyncSubs.forEach((key, value) => value.cancel());
    _conversationSyncSubs.clear();
  }
}
