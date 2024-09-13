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
        'conversation_id': message.conversationId,
      };
      final r = await channel.push('sms:message:new', payload).future;

      if (r.response != null) {
        _logger.info('Response from new_msg: ${r.response}');
      }

      if (r.isOk) {
        final chat = SmsConversation.fromMap(r.response['chat']);
        final chatMessage = SmsMessage.fromMap(r.response['msg']);
        await _smsRepository.upsertConversation(chat);
        await _smsRepository.upsertMessage(chatMessage);
        await _outboxRepository.deleteOutboxMessage(message.idKey);
      }
      if (r.isError) throw Exception('Error processing new dialog message');
    } catch (e) {
      _logger.severe('Error processing new dialog message', e);
      if (message.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for dialog message: ${message.idKey}');
        await _outboxRepository.deleteOutboxMessage(message.idKey);
      } else {
        await _outboxRepository.upsertOutboxMessage(message.incAttempt());
      }
    }
  }
}
