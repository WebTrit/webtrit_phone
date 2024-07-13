import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('OutboxQueueWorker');

class OutboxQueueWorker {
  OutboxQueueWorker(this._client, this._chatsRepository, this._outboxRepository) {
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
      for (final entry in await _outboxRepository.getChatOutboxMessages()) {
        if (entry.chatId != null) await _processNewMessage(entry.chatId!, entry);
        if (entry.participantId != null) await _processNewDialogMessage(entry.participantId!, entry);
      }

      for (final entry in await _outboxRepository.getChatOutboxMessageEdits()) {
        await _processMessageEdit(entry);
      }

      for (final entry in await _outboxRepository.getChatOutboxMessageDeletes()) {
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
        final message = ChatMessage.fromMap(r.response);
        await _chatsRepository.upsertMessage(message);
        await _outboxRepository.deleteOutboxMessage(message.idKey);
        _logger.info('After isOk on new_msg entry: ${message.idKey}');
      }
      if (r.isError) throw Exception('Error processing new message');
    } catch (e) {
      _logger.severe('Error processing new message', e);
      if (message.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for message: ${message.idKey}');
        await _outboxRepository.deleteOutboxMessage(message.idKey);
      } else {
        await _outboxRepository.upsertOutboxMessage(message.incAttempt());
      }
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
        final chat = Chat.fromMap(r.response['chat']);
        final chatMessage = ChatMessage.fromMap(r.response['msg']);
        await _chatsRepository.upsertChat(chat);
        await _chatsRepository.upsertMessage(chatMessage);
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

  Future _processMessageEdit(ChatOutboxMessageEditEntry messageEdit) async {
    try {
      final channel = _client.getChatChannel(messageEdit.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {'new_content': messageEdit.newContent, 'id': messageEdit.id};
      final r = await channel.push('message:edit', payload).future;

      if (r.isOk) {
        final message = ChatMessage.fromMap(r.response);
        await _chatsRepository.upsertMessage(message);
        await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
        _logger.info('After isOk on edit_msg entry: ${messageEdit.id}');
      }
      if (r.isError) throw Exception('Error processing message edit');
    } catch (e) {
      _logger.severe('Error processing message edit', e);
      if (messageEdit.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for edit message: ${messageEdit.idKey}');
        await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
      } else {
        await _outboxRepository.upsertOutboxMessageEdit(messageEdit.incAttempts());
      }
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
        final message = ChatMessage.fromMap(r.response);
        await _chatsRepository.upsertMessage(message);
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.info('After isOk on delete_msg entry: ${message.idKey}');
      }
      if (r.isError) throw Exception('Error processing message delete');
    } catch (e) {
      _logger.severe('Error processing message delete', e);
      if (messageDelete.sendAttempts > 5) {
        _logger.severe('Send attempts exceeded for delete message: ${messageDelete.idKey}');
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
      } else {
        await _outboxRepository.upsertOutboxMessageDelete(messageDelete.incAttempts());
      }
    }
  }
}
