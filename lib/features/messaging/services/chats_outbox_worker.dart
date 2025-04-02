import 'dart:async';

import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:uuid/uuid.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/mediafile_utils.dart';

final _logger = Logger('ChatsOutboxWorker');

/// A worker class responsible for handling the outbox of chat messages.
///
/// This class manages the sending of messages that are queued in the outbox,
/// ensuring that they are delivered to their intended recipients. It handles
/// retries and error management to ensure reliable message delivery.
class ChatsOutboxWorker {
  ChatsOutboxWorker(this._client, this._chatsRepository, this._outboxRepository, this._submitNotification);

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;
  final Function(Notification) _submitNotification;

  bool _disposed = false;

  init() {
    _logger.info('Initialising...');

    /// Continuously processes messages, edits, deletes, and read cursors from the outbox repository
    /// until the worker is disposed. The loop runs every second.
    Future.doWhile(() async {
      final messages = await _outboxRepository.getChatOutboxMessages();
      await Future.forEach(messages, (entry) => _processNewMessage(entry));

      final edits = await _outboxRepository.getChatOutboxMessageEdits();
      await Future.forEach(edits, (entry) => _processMessageEdit(entry));

      final deletes = await _outboxRepository.getChatOutboxMessageDeletes();
      await Future.forEach(deletes, (entry) => _processMessageDelete(entry));

      final cursors = await _outboxRepository.getOutboxReadCursors();
      await Future.forEach(cursors, (entry) => _processReadCursor(entry));

      if (_disposed) return false;
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  dispose() {
    _logger.info('Disposing...');
    _disposed = true;
  }

  /// Processes a new message from the chat outbox.
  ///
  /// This method handles the logic for processing a new message entry
  /// from the chat outbox. It performs necessary actions to ensure the
  /// message is properly handled and sent.
  ///
  /// [outboxEntry] The entry of the message in the chat outbox that needs to be processed.
  ///
  /// Returns a [Future] that completes when the message processing is done.
  Future _processNewMessage(ChatOutboxMessageEntry outboxEntry) async {
    try {
      final PhoenixChannel? channel;
      // Check if it's message for existed chat or for virtual dialog with designated participant
      if (outboxEntry.chatId != null) {
        channel = _client.getChatChannel(outboxEntry.chatId!);
      } else {
        // Check if dialog with participant already created, if so use it
        // Can happen when user wrore many messages to the same new participant being offline
        // and after first message the dialog was created rest of the messages can go to the new dialog
        final chatId = await _chatsRepository.findDialogId(outboxEntry.participantId!);
        chatId != null ? channel = _client.getChatChannel(chatId) : channel = _client.userChannel;
      }

      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      List<OutgoingAttachment> attachments = outboxEntry.attachments;
      bool attachmentsLocked = false;
      Future<void> aquireAttLock() async {
        await Future.doWhile(() async {
          if (attachmentsLocked == false) {
            attachmentsLocked = true;
            return false;
          }
          await Future.delayed(const Duration(milliseconds: 100));
          return true;
        });
      }

      final jobs = attachments.map((att) async {
        final pickedPath = att.pickedPath;
        final fileName = pickedPath.fileName;
        final fileExtension = pickedPath.fileExtension;
        String? encodedPath = att.encodedPath;
        MediaFileMetadata? metadata = att.metadata;
        String? uploadId = att.uploadId;

        _logger.info('Started processing $fileName.$fileExtension');

        if (pickedPath.isImagePath && !pickedPath.isGifImagePath && encodedPath == null) {
          _logger.info('Encoding image: $fileName.$fileExtension');

          final encodedPath = await encodeImage(pickedPath, EncodePreset.chat);
          if (encodedPath == null) throw Exception('Failed to encode image: $pickedPath');

          await aquireAttLock();
          final newAttachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(encodedPath: encodedPath);
          }).toList();

          final updatedMessage = outboxEntry.copyWith(attachments: newAttachments);
          await _outboxRepository.upsertOutboxMessage(updatedMessage);
          attachments = newAttachments;
          attachmentsLocked = false;
          _logger.info('Encoded image: $encodedPath');
        }
        if (pickedPath.isVideoPath && encodedPath == null) {
          _logger.info('Encoding video: $fileName.$fileExtension');

          encodedPath = await encodeVideo(pickedPath, EncodePreset.chat);
          if (encodedPath == null) throw Exception('Failed to encode video: $pickedPath');

          aquireAttLock();
          final newAttachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(encodedPath: encodedPath);
          }).toList();

          final updatedMessage = outboxEntry.copyWith(attachments: newAttachments);
          await _outboxRepository.upsertOutboxMessage(updatedMessage);
          attachments = newAttachments;
          attachmentsLocked = false;
          _logger.info('Encoded video: $encodedPath');
        }

        if (metadata == null) {
          metadata = await createMediaFileMetadata(path: encodedPath ?? pickedPath);
          await aquireAttLock();
          final newAttachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(metadata: metadata);
          }).toList();
          final updatedMessage = outboxEntry.copyWith(attachments: newAttachments);
          await _outboxRepository.upsertOutboxMessage(updatedMessage);
          attachments = newAttachments;
          attachmentsLocked = false;
          _logger.info('Created metadata: $metadata');
        }

        if (uploadId == null) {
          _logger.info('Starting upload $fileName.$fileExtension');
          await Future.delayed(const Duration(seconds: 1));
          uploadId = const Uuid().v4();

          await aquireAttLock();
          final newAttachments = attachments.map((e) {
            if (e.pickedPath != pickedPath) return e;
            return e.copyWith(uploadId: uploadId);
          }).toList();
          final updatedMessage = outboxEntry.copyWith(attachments: newAttachments);
          await _outboxRepository.upsertOutboxMessage(updatedMessage);
          attachments = newAttachments;
          attachmentsLocked = false;
          _logger.info('Uploaded file id: $uploadId');
        }

        _logger.info('Finished processing $fileName.$fileExtension');
      });

      await Future.wait(jobs);

      // final (message, chat) = await channel.newChatMessage(outboxEntry);
      // if (chat != null) await _chatsRepository.upsertChat(chat);
      // await _chatsRepository.upsertMessage(message);
      // await _outboxRepository.deleteOutboxMessage(outboxEntry.idKey);
      // _logger.info('Processed new message: ${message.id}');
    } catch (e, s) {
      _logger.severe('Error processing new message, attempt: ${outboxEntry.sendAttempts}', e, s);
      if (outboxEntry.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxMessage(outboxEntry.idKey);
        _logger.warning('Send attempts exceeded for message: ${outboxEntry.idKey}');
        _submitNotification(DefaultErrorNotification(e));
      } else {
        await _outboxRepository.upsertOutboxMessage(outboxEntry.incAttempt());
      }
    }
  }

  /// Processes the message edit entry.
  ///
  /// This method handles the editing of a message in the chat outbox.
  ///
  /// [messageEdit] The entry containing the details of the message to be edited.
  ///
  /// Returns a [Future] that completes when the message edit process is finished.
  Future _processMessageEdit(ChatOutboxMessageEditEntry messageEdit) async {
    try {
      final channel = _client.getChatChannel(messageEdit.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final message = await channel.editChatMessage(messageEdit);
      await _chatsRepository.upsertMessage(message);
      await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
      _logger.info('Processed edit message: ${message.id}');
    } catch (e, s) {
      _logger.severe('Error processing message edit, attempt: ${messageEdit.sendAttempts}', e, s);
      if (messageEdit.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxMessageEdit(messageEdit.id);
        _logger.warning('Send attempts exceeded for edit message: ${messageEdit.idKey}');
        _submitNotification(DefaultErrorNotification(e));
      } else {
        await _outboxRepository.upsertOutboxMessageEdit(messageEdit.incAttempts());
      }
    }
  }

  /// Processes the deletion of a chat message.
  ///
  /// This method handles the deletion of a chat message from the outbox.
  ///
  /// [messageDelete] The entry representing the chat message to be deleted.
  ///
  /// Returns a [Future] that completes when the message deletion process is finished.
  Future _processMessageDelete(ChatOutboxMessageDeleteEntry messageDelete) async {
    try {
      final channel = _client.getChatChannel(messageDelete.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final message = await channel.deleteChatMessage(messageDelete);
      await _chatsRepository.upsertMessage(message);
      await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
      _logger.info('Processed delete message: ${message.id}');
    } catch (e, s) {
      _logger.severe('Error processing message delete, attempt: ${messageDelete.sendAttempts}', e, s);
      if (messageDelete.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxMessageDelete(messageDelete.id);
        _logger.severe('Send attempts exceeded for delete message: ${messageDelete.idKey}');
        _submitNotification(DefaultErrorNotification(e));
      } else {
        await _outboxRepository.upsertOutboxMessageDelete(messageDelete.incAttempts());
      }
    }
  }

  /// Processes the read cursor entry for the chat outbox.
  ///
  /// This method handles the logic for processing a read cursor entry,
  /// which is used to track the read status of messages in the chat outbox.
  ///
  /// [readCursor] The read cursor entry to be processed.
  ///
  /// Returns a [Future] that completes when the processing is done.
  Future _processReadCursor(ChatOutboxReadCursorEntry readCursor) async {
    try {
      final channel = _client.getChatChannel(readCursor.chatId);
      if (channel == null) return;
      if (channel.state != PhoenixChannelState.joined) return;

      final cursor = await channel.setChatReadCursor(readCursor);
      await _chatsRepository.upsertChatMessageReadCursor(cursor);
      await _outboxRepository.deleteOutboxReadCursor(readCursor.chatId);
      _logger.info('Processed read cursor: ${readCursor.chatId}');
    } catch (e, s) {
      _logger.severe('Error processing read cursor, attempt: ${readCursor.sendAttempts}', e, s);
      if (readCursor.sendAttempts > 5) {
        await _outboxRepository.deleteOutboxReadCursor(readCursor.chatId);
        _logger.warning('Send attempts exceeded for read cursor: ${readCursor.chatId}');
        _submitNotification(DefaultErrorNotification(e));
      } else {
        await _outboxRepository.upsertOutboxReadCursor(readCursor.incAttempts());
      }
    }
  }
}
