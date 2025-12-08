import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SmsOutboxWorker');

/// A worker class responsible for handling the outbox of sms messages.
///
/// This class manages the sending of messages that are queued in the outbox,
/// ensuring that they are delivered to their intended recipients. It handles
/// retries and error management to ensure reliable message delivery.
class SmsOutboxWorker {
  SmsOutboxWorker(this._client, this._smsRepository, this._outboxRepository, this._onError);

  final PhoenixSocket _client;
  final SmsRepository _smsRepository;
  final SmsOutboxRepository _outboxRepository;
  final Function(Object) _onError;

  bool _disposed = false;

  void init() {
    _logger.info('Initialising...');

    /// Continuously processes messages, edits, deletes, and read cursors from the outbox repository
    /// until the worker is disposed. The loop runs every second.
    Future.doWhile(() async {
      if (_disposed) return false;

      final messages = await _outboxRepository.getOutboxMessages();
      await Future.forEach(messages, (entry) => _processNewMessage(entry));

      final deletes = await _outboxRepository.getOutboxMessageDeletes();
      await Future.forEach(deletes, (entry) => _processMessageDelete(entry));

      final cursors = await _outboxRepository.getOutboxReadCursors();
      await Future.forEach(cursors, (entry) => _processReadCursor(entry));

      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  void dispose() {
    _logger.info('Disposing...');
    _disposed = true;
  }

  /// Processes a new SMS outbox message entry.
  ///
  /// This method handles the processing of a new message entry in the SMS outbox.
  ///
  /// [entry] The SMS outbox message entry to be processed.
  ///
  /// Returns a [Future] that completes when the processing is done.
  Future _processNewMessage(SmsOutboxMessageEntry entry) async {
    try {
      final PhoenixChannel? channel;
      // Check if it's message for existed or for virtual dialog with designated participant
      if (entry.conversationId != null) {
        channel = _client.getSmsConversationChannel(entry.conversationId!);
      } else {
        // Check if dialog already created, if so use it
        // Can happen when user wrote many messages to the same new participant being offline
        // and after first message the dialog was created rest of the messages can go to the new dialog
        final chatId = await _smsRepository.findConversationBetweenNumbers(entry.fromPhoneNumber, entry.toPhoneNumber);
        chatId != null ? channel = _client.getSmsConversationChannel(chatId.id) : channel = _client.userChannel;
      }
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final (message, conversation) = await channel.newSmsMessage(entry);
      if (conversation != null) await _smsRepository.upsertConversation(conversation);
      await _smsRepository.upsertMessage(message);
      await _outboxRepository.deleteOutboxMessage(entry.idKey);
      _logger.info('Processed new message: ${message.id}');
    } catch (e, s) {
      _logger.severe('Error processing new dialog message, attempt: ${entry.sendAttempts}', e, s);
      if (entry.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxMessage(entry.idKey);
        _logger.warning('Send attempts exceeded for dialog message: ${entry.idKey}');
        _onError(e);
      } else {
        await _outboxRepository.upsertOutboxMessage(entry.incAttempt());
      }
    }
  }

  /// Processes the deletion of an SMS outbox message.
  ///
  /// This method handles the logic required to delete a message from the SMS outbox.
  ///
  /// [messageDelete] The entry containing the details of the message to be deleted.
  ///
  /// Returns a [Future] that completes when the message deletion process is finished.
  Future _processMessageDelete(SmsOutboxMessageDeleteEntry messageDelete) async {
    try {
      final channel = _client.getSmsConversationChannel(messageDelete.conversationId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final message = await channel.deleteSmsMessage(messageDelete);
      await _smsRepository.upsertMessage(message);
      await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
      _logger.info('Processed delete message: ${message.id}');
    } catch (e, s) {
      _logger.severe('Error processing message delete, attempt: ${messageDelete.sendAttempts}', e, s);
      if (messageDelete.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.warning('Send attempts exceeded for delete message: ${messageDelete.idKey}');
        _onError(e);
      } else {
        await _outboxRepository.upsertOutboxMessageDelete(messageDelete.incAttempts());
      }
    }
  }

  /// Processes the given read cursor entry from the SMS outbox.
  ///
  /// This method handles the logic for processing an entry in the SMS outbox
  /// read cursor. It performs necessary actions based on the state and content
  /// of the read cursor entry.
  ///
  /// [readCursor] The entry from the SMS outbox read cursor to be processed.
  ///
  /// Returns a [Future] that completes when the processing is done.
  Future _processReadCursor(SmsOutboxReadCursorEntry readCursor) async {
    try {
      final channel = _client.getSmsConversationChannel(readCursor.conversationId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final cursor = await channel.setSmsReadCursor(readCursor);
      await _smsRepository.upsertMessageReadCursor(cursor);
      await _outboxRepository.deleteOutboxReadCursor(readCursor.conversationId);
      _logger.info('Processed read cursor: ${cursor.conversationId}');
    } catch (e, s) {
      _logger.severe('Error processing read cursor, attempt: ${readCursor.sendAttempts}', e, s);
      if (readCursor.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxReadCursor(readCursor.conversationId);
        _logger.warning('Send attempts exceeded for read cursor: ${readCursor.conversationId}');
        _onError(e);
      } else {
        await _outboxRepository.upsertOutboxReadCursor(readCursor.incAttempts());
      }
    }
  }
}
