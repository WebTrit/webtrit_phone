import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/chat/components/chats_event.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('OutboxQueueService');

class OutboxQueueService {
  OutboxQueueService(this._client, this._localChatRepository) {
    // TODO: Remove this before pr
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final PhoenixSocket _client;
  final LocalChatRepository _localChatRepository;

  bool _disposed = false;

  init() {
    _logger.info('Initializing outbox queue service');
    _processOutboxQueue();
  }

  _processOutboxQueue() async {
    try {
      final entries = await _localChatRepository.getChatQueueEntries();
      final channel = _client.userChannel;
      if (channel != null && channel.state == PhoenixChannelState.joined) {
        for (final entry in entries) {
          _logger.info('Processing outbox queue entry: $entry');

          if (entry.type == ChatQueueEntryType.create) {
            if (entry.chatId != null) {
              final r = await channel.push('new_msg', {
                'chat_id': entry.chatId,
                'content': entry.content,
                'id_key': entry.idKey,
              }).future;

              if (r.response != null) {
                _logger.info('Response from new_msg: ${r.response}');
              }

              if (r.isOk) {
                await _localChatRepository.eventBus
                    .whereType<ChatMessageUpdate>()
                    .firstWhere((event) => event.message.idKey == entry.idKey);
                await _localChatRepository.deleteChatQueueEntry(entry.id);
                _logger.info('After isOk on new_msg entry: ${entry.idKey}');
              }
              if (r.isError) {
                await _localChatRepository.deleteChatQueueEntry(entry.id);
                _logger.info('After isError on new_msg entry: ${entry.idKey}');
              }
            }

            if (entry.participantId != null) {
              final r = await channel.push('new_dialog_msg', {
                'to_id': entry.participantId,
                'content': entry.content,
                'id_key': entry.idKey,
              }).future;

              if (r.isOk) {
                await _localChatRepository.eventBus
                    .whereType<ChatMessageUpdate>()
                    .firstWhere((event) => event.message.idKey == entry.idKey);
                await _localChatRepository.deleteChatQueueEntry(entry.id);
                _logger.info('After isOk on new_dialog_msg entry: ${entry.idKey}');
              }
              if (r.isError) {
                await _localChatRepository.deleteChatQueueEntry(entry.id);
                _logger.info('After isError on new_dialog_msg entry: ${entry.idKey}');
              }
            }
          }
        }
      }
    } catch (e) {
      _logger.severe('Failed to process outbox queue: $e');
    }
    if (_disposed) return;
    await Future.delayed(const Duration(seconds: 1));
    _processOutboxQueue();
  }

  dispose() {
    _disposed = true;
  }
}
