import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('OutboxQueueService');

class OutboxQueueService {
  OutboxQueueService(
    this._client,
    this._chatsRepository,
    this._outboxRepository,
  ) {
    // TODO: Remove this before pr
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;

  bool _disposed = false;

  init() {
    _logger.info('Initializing outbox queue service');
    Future.doWhile(() async {
      final messageEntries = await _outboxRepository.getChatOutboxMessages();

      for (final entry in messageEntries) {
        if (entry.chatId != null) {
          await _processNewMessage(entry.chatId!, entry);
        }
        if (entry.participantId != null) {
          await _processNewDialogMessage(entry.participantId!, entry);
        }
      }

      final messageEditEntries = await _outboxRepository.getChatOutboxMessageEdits();

      for (final entry in messageEditEntries) {
        await _processMessageEdit(entry);
      }

      final messageDeleteEntries = await _outboxRepository.getChatOutboxMessageDeletes();

      for (final entry in messageDeleteEntries) {
        await _processMessageDelete(entry);
      }

      if (_disposed) return false;
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  dispose() {
    _disposed = true;
  }

  Future _processNewMessage(int chatId, ChatOutboxMessageEntry message) async {
    try {
      final channel = _client.getChatChannel(chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {
        'content': message.content,
        'id_key': message.idKey,
        'reply_to_id': message.replyToId,
        'forwarded_from_id': message.forwardFromId,
        'author_id': message.authorId,
        'via_sms': message.viaSms,
        'sms_number': message.smsNumber,
      };
      final r = await channel.push('message:new', payload).future;

      if (r.response != null) {
        _logger.info('Response from new_msg: ${r.response}');
      }

      if (r.isOk) {
        await _chatsRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == message.idKey)
            .timeout(const Duration(seconds: 5));
        await _outboxRepository.deleteOutboxMessage(message.idKey);
        _logger.info('After isOk on new_msg entry: $message.idKey');
      }
      if (r.isError) {
        await _outboxRepository.deleteOutboxMessage(message.idKey);
        _logger.info('After isError on new_msg entry: $message.idKey');
      }
    } catch (e) {
      _logger.severe('Error processing new message', e);
      await _outboxRepository.deleteOutboxMessage(message.idKey);
    }
  }

  Future _processNewDialogMessage(String participantId, ChatOutboxMessageEntry message) async {
    try {
      final channel = _client.userChannel;
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {
        'recipient': participantId,
        'first_message_content': message.content,
        'id_key': message.idKey,
        'reply_to_id': message.replyToId,
        'forwarded_from_id': message.forwardFromId,
        'author_id': message.authorId,
        'via_sms': message.viaSms,
        'sms_number': message.smsNumber,
      };
      final r = await channel.push('chat:create_dialog', payload).future;

      if (r.isOk) {
        await _chatsRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == message.idKey)
            .timeout(const Duration(seconds: 5));
        await _outboxRepository.deleteOutboxMessage(message.idKey);
        _logger.info('After isOk on new_dialog_msg entry: $message.idKey');
      }
      if (r.isError) {
        await _outboxRepository.deleteOutboxMessage(message.idKey);
        _logger.info('After isError on new_dialog_msg entry: $message.idKey');
      }
    } catch (e) {
      _logger.severe('Error processing new dialog message', e);
      await _outboxRepository.deleteOutboxMessage(message.idKey);
    }
  }

  Future _processMessageEdit(ChatOutboxMessageEditEntry messageEdit) async {
    try {
      final channel = _client.getChatChannel(messageEdit.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {'new_content': messageEdit.newContent, 'id': messageEdit.id};
      final r = await channel.push('message:edit', payload).future;

      if (r.isOk) {
        await _chatsRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == messageEdit.idKey)
            .timeout(const Duration(seconds: 5));
        await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
        _logger.info('After isOk on edit_msg entry: ${messageEdit.id}');
      }
      if (r.isError) {
        await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
        _logger.info('After isError on edit_msg entry: ${messageEdit.id}');
      }
    } catch (e) {
      _logger.severe('Error processing message edit', e);
      await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
    }
  }

  Future _processMessageDelete(ChatOutboxMessageDeleteEntry messageDelete) async {
    try {
      final channel = _client.getChatChannel(messageDelete.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {'id': messageDelete.id};
      final r = await channel.push('message:delete', payload).future;

      if (r.isOk) {
        await _chatsRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == messageDelete.idKey)
            .timeout(const Duration(seconds: 5));
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.info('After isOk on delete_msg entry: ${messageDelete.id}');
      }
      if (r.isError) {
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.info('After isError on delete_msg entry: ${messageDelete.id}');
      }
    } catch (e) {
      _logger.severe('Error processing message delete', e);
      await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
    }
  }
}
