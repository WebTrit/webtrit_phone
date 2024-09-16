import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO: extract events and commands to separate classes

final _logger = Logger('SmsOutboxWorker');

class SmsOutboxWorker {
  SmsOutboxWorker(this._client, this._smsRepository, this._outboxRepository) {
    // TODO: Remove this before pr
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final PhoenixSocket _client;
  final SmsRepository _smsRepository;
  final SmsOutboxRepository _outboxRepository;

  bool _disposed = false;

  init() {
    _logger.info('Initialising...');
    Future.doWhile(() async {
      for (final entry in await _outboxRepository.getOutboxMessages()) {
        await _processNewMessage(entry);
      }
      for (final entry in await _outboxRepository.getOutboxMessageDeletes()) {
        await _processMessageDelete(entry);
      }

      if (_disposed) return false;
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  dispose() {
    _logger.info('Disposing...');
    _disposed = true;
  }

  Future _processNewMessage(SmsOutboxMessageEntry message) async {
    final conversationId = message.conversationId;
    try {
      final PhoenixChannel? channel;

      if (conversationId != null) {
        channel = _client.getSmsConversationChannel(conversationId);
      } else {
        channel = _client.userChannel;
      }

      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {
        'content': message.content,
        'idempotency_key': message.idKey,
        'from_phone_number': message.fromPhoneNumber,
        'to_phone_number': message.toPhoneNumber,
        'recepient_id': message.recepientId,
      };
      final r = await channel.push('sms:message:new', payload).future;
      if (r.response != null) _logger.info('Response from new_msg: ${r.response}');

      if (r.isOk) {
        final conversation = SmsConversation.fromMap(r.response['conversation']);
        final message = SmsMessage.fromMap(r.response['message']);
        await _smsRepository.upsertConversation(conversation);
        await _smsRepository.upsertMessage(message);
        await _outboxRepository.deleteOutboxMessage(message.idKey);
      }
      if (r.isError) throw Exception('Error processing new dialog message');
    } catch (e) {
      _logger.severe('Error processing new dialog message, attempt: ${message.sendAttempts}', e);
      if (message.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for dialog message: ${message.idKey}');
        await _outboxRepository.deleteOutboxMessage(message.idKey);
      } else {
        await _outboxRepository.upsertOutboxMessage(message.incAttempt());
      }
    }
  }

  Future _processMessageDelete(SmsOutboxMessageDeleteEntry messageDelete) async {
    try {
      final channel = _client.getSmsConversationChannel(messageDelete.conversationId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final r = await channel.push('sms:message:delete:${messageDelete.id}', {}).future;

      if (r.isOk) {
        final message = SmsMessage.fromMap(r.response);
        await _smsRepository.upsertMessage(message);
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.info('After isOk on delete_msg entry: ${message.idKey}');
      }
      if (r.isError) throw Exception('Error processing message delete');
    } catch (e) {
      _logger.severe('Error processing message delete, attempt: ${messageDelete.sendAttempts}', e);
      if (messageDelete.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for delete message: ${messageDelete.idKey}');
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
      } else {
        await _outboxRepository.upsertOutboxMessageDelete(messageDelete.incAttempts());
      }
    }
  }
}
