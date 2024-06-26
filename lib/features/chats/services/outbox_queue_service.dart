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
    Future.doWhile(() async {
      final entries = await _localChatRepository.getChatQueueEntries();

      for (final entry in entries) {
        _logger.info('Processing outbox queue entry: $entry');

        if (entry.type == ChatQueueEntryType.create) {
          if (entry.chatId != null) {
            await _processNewMessage(entry.chatId!, entry.content, entry.idKey, entry.id);
          }
          if (entry.participantId != null) {
            await _processNewDialogMessage(entry.participantId!, entry.content, entry.idKey, entry.id);
          }
        }
      }
      if (_disposed) return false;
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  dispose() {
    _disposed = true;
  }

  Future _processNewMessage(int chatId, String content, String idKey, int entryId) async {
    try {
      final channel = _client.getChatChannel(chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {'content': content, 'id_key': idKey};
      final r = await channel.push('message:new', payload).future;

      if (r.response != null) {
        _logger.info('Response from new_msg: ${r.response}');
      }

      if (r.isOk) {
        await _localChatRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == idKey)
            .timeout(const Duration(seconds: 5));
        await _localChatRepository.deleteChatQueueEntry(entryId);
        _logger.info('After isOk on new_msg entry: $idKey');
      }
      if (r.isError) {
        await _localChatRepository.deleteChatQueueEntry(entryId);
        _logger.info('After isError on new_msg entry: $idKey');
      }
    } catch (e) {
      _logger.severe('Error processing new message', e);
      await _localChatRepository.deleteChatQueueEntry(entryId);
    }
  }

  Future _processNewDialogMessage(String participantId, content, idKey, int entryId) async {
    try {
      final channel = _client.userChannel;
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      var payload = {'recipient': participantId, 'first_message_content': content, 'id_key': idKey};
      final r = await channel.push('chat:create_dialog', payload).future;

      if (r.isOk) {
        await _localChatRepository.eventBus
            .whereType<ChatMessageUpdate>()
            .firstWhere((event) => event.message.idKey == idKey)
            .timeout(const Duration(seconds: 5));
        await _localChatRepository.deleteChatQueueEntry(entryId);
        _logger.info('After isOk on new_dialog_msg entry: $idKey');
      }
      if (r.isError) {
        await _localChatRepository.deleteChatQueueEntry(entryId);
        _logger.info('After isError on new_dialog_msg entry: $idKey');
      }
    } catch (e) {
      _logger.severe('Error processing new dialog message', e);
      await _localChatRepository.deleteChatQueueEntry(entryId);
    }
  }
}
