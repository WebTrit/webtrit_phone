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
  SmsSyncWorker(
    this.client,
    this.smsRepository,
    this.onError, {
    this.pageSize = 50,
    this.listThrottle = const Duration(seconds: 1),
    this.roomThrottle = const Duration(seconds: 5),
  });

  final PhoenixSocket client;
  final SmsRepository smsRepository;
  final Function(Object) onError;
  final int pageSize;
  final Duration listThrottle;
  final Duration roomThrottle;

  StreamSubscription? _conversationsSyncSub;
  final Map<int, StreamSubscription> _conversationSyncSubs = {};

  Future init() async {
    _logger.info('Initialising...');
    _closeSubs();
    _conversationsSyncSub = _conversationsSyncStream().listen(
      (e) {
        if (e is (Object, StackTrace)) {
          final (error, stackTrace) = e;
          _logger.warning('conversations sync error:', error, stackTrace);
          onError(error);
        } else {
          _logger.info('conversations sync event: $e');
        }
      },
    );
  }

  Future dispose() async {
    _logger.info('Disposing...');
    _closeSubs();
  }

  Future _conversationSubscribe(int id) async {
    _logger.info('Subscribing to conversation $id');

    PhoenixChannel? channel = client.getSmsConversationChannel(id);

    if (channel == null) {
      channel = client.createSmsConversationChannel(id);
      await channel.connect().catchError((e, s) {
        _logger.warning('Failed to connect to sms conversation $id', e, s);
        onError(e);
      });
    }

    _conversationSyncSubs.putIfAbsent(
      id,
      () => _conversationSyncStream(id, channel!).listen(
        (e) {
          if (e is (Object, StackTrace)) {
            final (error, stackTrace) = e;
            _logger.warning('conversation sync error: $id', error, stackTrace);
            onError(error);
          } else {
            _logger.info('conversation sync event: $id $e');
          }
        },
      ),
    );
  }

  Future _conversationUnsubscribe(int id) async {
    _logger.info('Unsubscribing from $id');
    _conversationSyncSubs.remove(id)?.cancel();
    await client.getSmsConversationChannel(id)?.leave().future;
  }

  Stream<dynamic> _conversationsSyncStream() async* {
    while (true) {
      try {
        // Get and wait for user channel to be ready
        final userChannel = client.userChannel;

        // Check if connection ready to use
        final connected = userChannel != null && userChannel.state == PhoenixChannelState.joined;
        if (!connected) continue;

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
        eventsIterator:
        await for (final event in eventsStream) {
          yield event;
          switch (event) {
            case SmsConversationJoin smsEvent:
              await _conversationSubscribe(smsEvent.conversationId);
            case SmsConversationLeave smsEvent:
              await _conversationUnsubscribe(smsEvent.conversationId);
              await smsRepository.deleteConversationById(smsEvent.conversationId);
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
        final newestCursor = await smsRepository.getMessageSyncCursor(id, SmsSyncCursorType.newest);

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
              conversationId: id,
              cursorType: SmsSyncCursorType.oldest,
              time: messages.last.createdAt,
            ));
            await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
              conversationId: id,
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
                conversationId: id,
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
        eventsIterator:
        await for (final event in eventsStream) {
          yield event;
          switch (event) {
            case SmsChannelInfoUpdate _:
              await smsRepository.upsertConversation(event.conversation);
            case SmsChannelMessageUpdate _:
              await smsRepository.upsertMessage(event.message);
              await smsRepository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
                conversationId: id,
                cursorType: SmsSyncCursorType.newest,
                time: event.message.updatedAt,
              ));
            case SmsChannelCursorSet _:
              await smsRepository.upsertMessageReadCursor(event.cursor);
            case SmsChannelDisconnect _:
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

  void _closeSubs() async {
    _conversationsSyncSub?.cancel();
    _closeConversationSubs();
  }

  void _closeConversationSubs() {
    _conversationSyncSubs.forEach((key, value) => value.cancel());
    _conversationSyncSubs.clear();
  }
}

const _kRetryStub = 'retry';
