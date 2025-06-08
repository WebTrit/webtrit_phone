// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/mappers/phoenix/phoenix.dart';
import 'package:webtrit_phone/models/models.dart';

// TODO(Vlad):
// - create separate "MessagingClient" and all nessacery entities(channels, states, transactions)
//   to abstract away from PhoenixSocket completely
// - pure reconnection support see [messaging_bloc.dart] todo

PhoenixSocket createMessagingSocket(String coreUrl, String token, String tenantId) {
  String baseUrl = coreUrl;
  baseUrl = baseUrl.replaceFirst('http://', 'ws://');
  baseUrl = baseUrl.replaceFirst('https://', 'wss://');
  baseUrl = baseUrl.replaceFirst(RegExp(r'/$'), '');

  String finalUrl = '$baseUrl/messaging/v1/websocket';

  final socketOpts = PhoenixSocketOptions(params: {'token': token, 'tenant_id': tenantId});
  return PhoenixSocket(finalUrl, socketOptions: socketOpts);
}

extension PhoenixSocketExt on PhoenixSocket {
  /// Create user channel by [userId] and connect, if already exists returns it
  PhoenixChannel createUserChannel(String userId) => addChannel(topic: 'chat:user:$userId');

  /// Get user channel if exists
  PhoenixChannel? get userChannel => channels.values.firstWhereOrNull((c) => c.topic.startsWith('chat:user:'));

  /// Get user id from connected user channel topic
  String? get userId => userChannel?.topic.split(':').last;

  /// Create channel by [chatId], if already exists returns it
  PhoenixChannel createChatChannel(int chatId) => addChannel(topic: 'chat:$chatId');

  /// Create sms conversation channel by [conversationId], if already exists returns it
  PhoenixChannel createSmsConversationChannel(int conversationId) => addChannel(topic: 'chat:sms:$conversationId');

  /// Get chat channel by [chatId] if exists
  PhoenixChannel? getChatChannel(int chatId) => channels.values.firstWhereOrNull((c) => c.topic == 'chat:$chatId');

  /// Get sms conversation channel by [conversationId] if exists
  PhoenixChannel? getSmsConversationChannel(int conversationId) =>
      channels.values.firstWhereOrNull((c) => c.topic == 'chat:sms:$conversationId');

  static PhoenixSocket createMessagingSocket() {
    final socket = PhoenixSocket('ws://localhost:4000/socket/websocket');
    socket.connect();
    return socket;
  }
}

extension PhoenixChannelExt on PhoenixChannel {
  /// A stream of inbound [Message]s objects from the channel.
  Stream<Message> get incomingMessages => messages.where((m) => m.isReply == false);

  /// A stream of [UserChannelEvent] objects derived from the user channel.
  ///
  /// Returns a [Stream] of [UserChannelEvent] objects.
  Stream<UserChannelEvent> get userEvents => incomingMessages.map((m) => UserChannelEvent.fromMessage(m));

  /// A stream of [ChatChannelEvent]s derived from the chat conversation channel.
  ///
  /// Returns a [Stream] of [ChatChannelEvent] objects.
  Stream<ChatChannelEvent> get chatEvents => incomingMessages.map((m) => ChatChannelEvent.fromMessage(m));

  /// A stream of [SmsChannelEvent]s derived from the sms conversation channel.
  ///
  /// Returns a [Stream] of [SmsChannelEvent] objects.
  Stream<SmsChannelEvent> get smsEvents => incomingMessages.map((m) => SmsChannelEvent.fromMessage(m));

  /// Attempts to connect to the Phoenix socket channel asynchronously.
  /// It will wait until the connection is successfully established or an error occurs.
  ///
  /// Returns a [Future] that completes when the connection is established.
  /// Throws a [MessagingSocketException] if the connection fails.
  Future connect() async {
    try {
      final req = await join().future;
      if (req.isError) throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat conversation ids',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously retrieves a list of chat conversation IDs for the user.
  ///
  /// This method returns a [Future] that completes with an [Iterable] of integers,
  /// representing the IDs of chat conversations.
  ///
  /// Example usage:
  /// ```dart
  /// final conversationIds = await chatConversationsIds;
  /// ```
  Future<Iterable<int>> get chatConversationsIds async {
    try {
      final req = await push('chat:get_all', {}).future;
      final response = req.response;

      if (req.isOk && response is Iterable) {
        return response.cast<int>();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat conversation ids',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously retrieves a list of SMS conversation IDs for the user.
  ///
  /// This method returns a [Future] that completes with an [Iterable] of
  /// integers representing the IDs of SMS conversations.
  Future<Iterable<int>> get smsConversationsIds async {
    try {
      final req = await push('sms:conversation:get_all', {}).future;
      final response = req.response;

      if (req.isOk && response is Iterable) {
        return response.cast<int>();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat conversation ids',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously retrieves a list of phone numbers associated with user.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [String] phone numbers.
  Future<Iterable<String>> get smsPhoneNumbers async {
    try {
      final req = await push('user:get_info', {}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        final smsNumbers = (response['sms_phone_numbers'] as Iterable).cast<String>();
        return smsNumbers.map((e) => e.e164Phone).nonNulls;
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat conversation ids',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously retrieves the chat conversation.
  ///
  /// This getter returns a [Future] that completes with a [Chat] object
  /// representing the chat conversation.
  Future<Chat> get chatConversation async {
    try {
      final req = await push('chat:get', {}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return ChatPhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat conversation',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// A getter that asynchronously retrieves an [SmsConversation].
  ///
  /// This method returns a [Future] that completes with an [SmsConversation].
  /// It can be used to fetch the conversation details for SMS messaging.
  Future<SmsConversation> get smsConversation async {
    try {
      final req = await push('sms:conversation:get', {}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return SmsConversationPhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching sms conversation',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously retrieves an iterable collection of chat message read cursors.
  ///
  /// This getter fetches the read cursors for chat messages, which can be used
  /// to determine the read status of messages in a chat.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [ChatMessageReadCursor] objects.
  Future<Iterable<ChatMessageReadCursor>> get chatCursors async {
    try {
      final req = await push('chat:cursor:get', {}).future;
      final response = req.response;

      if (req.isOk && response is Iterable) {
        return response.map((e) => ChatMessageReadCursorPhxMapper.fromMap(e));
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat cursors',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// A getter that asynchronously retrieves an iterable collection of
  /// [SmsMessageReadCursor] objects.
  ///
  /// This getter is used to obtain the current read cursors for SMS messages.
  /// It returns a [Future] that completes with an [Iterable] of
  /// [SmsMessageReadCursor] instances.
  Future<Iterable<SmsMessageReadCursor>> get smsCursors async {
    try {
      final req = await push('sms:conversation:cursor:get', {}).future;
      final response = req.response;

      if (req.isOk && response is Iterable) {
        return response.map((e) => SmsMessageReadCursorPhxMapper.fromMap(e));
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching sms cursors',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Retrieves a chat message by its ID.
  ///
  /// This method fetches a chat message from the server using the provided
  /// [messageId]. It returns a [ChatMessage] object if the message is found,
  /// or `null` if the message does not exist.
  ///
  /// [messageId]: The unique identifier of the chat message to be retrieved.
  ///
  /// Returns a [Future] that completes with the [ChatMessage] object if found,
  /// or `null` if the message does not exist.
  Future<ChatMessage?> getChatMessage(int messageId) async {
    try {
      final req = await push('message:get:$messageId', {}).future;
      return req.isOk ? ChatMessagePhxMapper.fromMap(req.response as Map<String, dynamic>) : null;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat message $messageId',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Retrieves the chat message history.
  ///
  /// This method fetches a list of chat messages with a specified limit. Optionally,
  /// messages created before a certain date can be included.
  ///
  /// [limit] The maximum number of chat messages to retrieve.
  /// [createdBefore] An optional parameter to specify the date before which messages
  /// should be retrieved. If provided, it will be converted to UTC and formatted as an ISO 8601 string.
  ///
  /// Returns a [Future] that resolves to a list of [ChatMessage] objects.
  Future<List<ChatMessage>> chatMessagHistory(int limit, {DateTime? createdBefore}) async {
    try {
      Map<String, dynamic> payload = {'limit': limit};
      if (createdBefore != null) payload['created_before'] = createdBefore.toUtc().toIso8601String();

      final req = await push('message:history', payload).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return (req.response['data'] as Iterable).map((e) => ChatMessagePhxMapper.fromMap(e)).toList();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat message history $limit $createdBefore',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Retrieves the SMS message history.
  ///
  /// This method fetches a list of SMS messages with a specified limit. Optionally,
  /// messages can be filtered to include only those created before a certain date.
  ///
  /// [limit] The maximum number of SMS messages to retrieve.
  /// [createdBefore] An optional parameter to filter messages created before this date.
  ///
  /// Returns a [Future] that resolves to a list of [SmsMessage] objects.
  Future<List<SmsMessage>> smsMessageHistory(int limit, {DateTime? createdBefore}) async {
    try {
      Map<String, dynamic> payload = {'limit': limit};
      if (createdBefore != null) payload['created_before'] = createdBefore.toUtc().toIso8601String();

      final req = await push('sms:message:history', payload).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return (req.response['data'] as Iterable).map((e) => SmsMessagePhxMapper.fromMap(e)).toList();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching sms message history $limit $createdBefore',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Fetches a list of chat messages that have been updated after a specified date in reverse order.
  ///
  /// This method retrieves chat messages that have been updated after the given
  /// [updatedAfter] date and limits the number of messages returned to the specified [limit].
  ///
  /// [updatedAfter]: The date after which the chat messages should have been updated.
  /// [limit]: The maximum number of chat messages to retrieve.
  ///
  /// Returns a [Future] that completes with a list of [ChatMessage] objects.
  Future<List<ChatMessage>> chatMessageUpdates(DateTime updatedAfter, int limit) async {
    try {
      final payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
      final req = await push('message:updates', payload).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return (req.response['data'] as Iterable).map((e) => ChatMessagePhxMapper.fromMap(e)).toList();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching chat message updates $updatedAfter $limit',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Fetches a list of SMS messages that have been updated after a specified date in reverse order.
  ///
  /// This method retrieves SMS messages that have been updated after the given
  /// [updatedAfter] date. The number of messages retrieved is limited by the
  /// [limit] parameter.
  ///
  /// [updatedAfter]: The date after which the SMS messages were updated.
  /// [limit]: The maximum number of SMS messages to retrieve.
  ///
  /// Returns a [Future] that completes with a list of [SmsMessage] objects.
  Future<List<SmsMessage>> smsMessageUpdates(DateTime updatedAfter, int limit) async {
    try {
      final payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
      final req = await push('sms:message:updates', payload).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return (req.response['data'] as Iterable).map((e) => SmsMessagePhxMapper.fromMap(e)).toList();
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error fetching sms message updates $updatedAfter $limit',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [ChatOutboxMessageEntry] and sends a new chat message using this channel.
  /// It returns: [Future] that completes with a tuple containing the sent [ChatMessage]
  /// and an optional [Chat] object for case when new chat was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(ChatMessage, Chat?)> newChatMessage(ChatOutboxMessageEntry outboxEntry) async {
    try {
      final payload = {
        'recipient': outboxEntry.participantId,
        'content': outboxEntry.content,
        'idempotency_key': outboxEntry.idKey,
        'reply_to_id': outboxEntry.replyToId,
        'forwarded_from_id': outboxEntry.forwardFromId,
        'author_id': outboxEntry.authorId,
      };
      final req = await push('message:new', payload).future;
      final response = req.response;

      ChatMessage message;
      Chat? chat;

      if (req.isOk && response is Map<String, dynamic>) {
        if (response.containsKey('chat') && response.containsKey('message')) {
          chat = ChatPhxMapper.fromMap(response['chat']);
          message = ChatMessagePhxMapper.fromMap(response['message']);
          return (message, chat);
        }

        if (response.containsKey('id')) {
          message = ChatMessagePhxMapper.fromMap(response);
          return (message, chat);
        }
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error processing $outboxEntry',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [ChatOutboxMessageEditEntry] and attempts to edit a chat message using this channel.
  /// [editEntry] The entry containing the details of the message to be edited.
  /// It returns a [Future] that resolves to the edited [ChatMessage].
  /// Throws an exception if the edit process fails.
  Future<ChatMessage> editChatMessage(ChatOutboxMessageEditEntry editEntry) async {
    try {
      final payload = {'new_content': editEntry.newContent};
      final req = await push('message:edit:${editEntry.id}', payload).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return ChatMessagePhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error editing chat message: $editEntry',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [ChatOutboxMessageDeleteEntry] and attempts to delete a chat message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the deleted [ChatMessage].
  /// Throws an exception if the deletion process fails.
  Future<ChatMessage> deleteChatMessage(ChatOutboxMessageDeleteEntry deleteEntry) async {
    try {
      final req = await push('message:delete:${deleteEntry.id}', {}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return ChatMessagePhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error deleting chat message: $deleteEntry',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [ChatOutboxReadCursorEntry] and attempts to set a chat cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [ChatMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<ChatMessageReadCursor> setChatReadCursor(ChatOutboxReadCursorEntry readCursor) async {
    try {
      final payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
      final req = await push('chat:cursor:set', payload).future;

      if (req.isOk) {
        return ChatMessageReadCursor(chatId: readCursor.chatId, userId: socket.userId!, time: readCursor.time);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error setting chat read cursor: $readCursor',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes an [SmsOutboxMessageEntry] and attempts to send it as a new SMS message using this channel.
  /// It returns a [Future] that resolves to a tuple containing the sent [SmsMessage]
  /// and an optional [SmsConversation] object if a new conversation was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(SmsMessage, SmsConversation?) /*?*/ > newSmsMessage(SmsOutboxMessageEntry outboxEntry) async {
    try {
      final payload = {
        'content': outboxEntry.content,
        'idempotency_key': outboxEntry.idKey,
        'from_phone_number': outboxEntry.fromPhoneNumber,
        'to_phone_number': outboxEntry.toPhoneNumber,
        'recepient_id': outboxEntry.recepientId,
      };
      final req = await push('sms:message:new', payload).future;
      final response = req.response;

      SmsMessage smsMessage;
      SmsConversation? smsConversation;

      if (req.isOk && response is Map<String, dynamic>) {
        if (response.containsKey('conversation') && response.containsKey('message')) {
          smsConversation = SmsConversationPhxMapper.fromMap(response['conversation']);
          smsMessage = SmsMessagePhxMapper.fromMap(response['message']);
          return (smsMessage, smsConversation);
        }

        if (response.containsKey('id')) {
          smsMessage = SmsMessagePhxMapper.fromMap(response);
          return (smsMessage, smsConversation);
        }
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error processing $outboxEntry',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [SmsOutboxMessageDeleteEntry] and attempts to delete an SMS message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the edited [SmsMessage].
  /// Throws an exception if the edit process fails.
  Future<SmsMessage> deleteSmsMessage(SmsOutboxMessageDeleteEntry deleteEntry) async {
    try {
      final req = await push('sms:message:delete:${deleteEntry.id}', {}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return SmsMessagePhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error deleting sms message: $deleteEntry',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function takes a [SmsOutboxReadCursorEntry] and attempts to set an SMS cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [SmsMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<SmsMessageReadCursor> setSmsReadCursor(SmsOutboxReadCursorEntry readCursor) async {
    try {
      final payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
      final req = await push('sms:conversation:cursor:set', payload).future;

      if (req.isOk) {
        return SmsMessageReadCursor(
            conversationId: readCursor.conversationId, userId: socket.userId!, time: readCursor.time);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error setting sms read cursor: $readCursor',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// This function sends a typing event to the chat channel.
  void sendChatTyping() async {
    push('chat:typing', {});
  }

  /// This function sends a typing event to the SMS conversation channel.
  void sendSmsTypnig() async {
    push('sms:conversation:typing', {});
  }

  /// Deletes a chat conversation (group or dialog) from the server.
  ///
  /// This method asynchronously deletes a chat conversation and returns a
  /// boolean indicating the success of the operation.
  ///
  /// Returns:
  ///   A [Future] that completes with a [bool] indicating whether the
  ///   chat conversation was successfully deleted.
  Future<bool> deleteChatConversation() async {
    try {
      final req = await push('chat:delete', {}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error deleting chat',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Deletes an SMS conversation.
  ///
  /// This method asynchronously deletes an SMS conversation.
  ///
  /// Returns a [Future] that completes with a boolean value indicating
  /// whether the deletion was successful.
  Future<bool> deleteSmsConversation() async {
    try {
      final req = await push('sms:conversation:delete', {}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error deleting sms conversation',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Creates a new group with the specified name and members.
  ///
  /// This method sends a request to create a new group with the given [name]
  /// and a list of member IDs [memberIds]. It returns a [Future] that resolves
  /// to `true` if the group was successfully created, or `false` otherwise.
  ///
  /// [name]: The name of the new group.
  /// [memberIds]: A list of IDs representing the members to be added to the group.
  ///
  /// Returns a [Future] that resolves to a boolean indicating the success of the operation.
  Future<Chat> newGroup(String name, List<String> memberIds) async {
    try {
      final req = await push('chat:new', {'name': name, 'member_ids': memberIds}).future;
      final response = req.response;

      if (req.isOk && response is Map<String, dynamic>) {
        return ChatPhxMapper.fromMap(response);
      }

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error creating group: $name, members: $memberIds',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Asynchronously leaves a group.
  ///
  /// This method attempts to leave a group and returns a [Future] that
  /// completes with a boolean value indicating whether the operation
  /// was successful.
  ///
  /// Returns:
  /// - `true` if the group was successfully left.
  /// - `false` if there was an error leaving the group.
  Future<bool> leaveGroup() async {
    try {
      final req = await push('chat:member:leave', {}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error leaving group',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Adds a member to a group.
  ///
  /// This method takes a user ID and adds the corresponding user to a group.
  ///
  /// Returns a [Future] that completes with a boolean value indicating
  /// whether the operation was successful.
  ///
  /// [userId]: The ID of the user to be added to the group.
  Future<bool> addGroupMember(String userId) async {
    try {
      final req = await push('chat:member:add:$userId', {}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error adding group member $userId',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Removes a member from a group.
  ///
  /// This method takes a user ID as a parameter and attempts to remove the
  /// corresponding user from the group. It returns a [Future] that completes
  /// with a boolean value indicating whether the removal was successful.
  ///
  /// [userId]: The ID of the user to be removed from the group.
  ///
  /// Returns a [Future<bool>] that completes with `true` if the user was
  /// successfully removed, or `false` otherwise.
  Future<bool> removeGroupMember(String userId) async {
    try {
      final req = await push('chat:member:remove:$userId', {}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error removing group member $userId',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Sets the moderator status for a user in a group.
  ///
  /// This method updates the moderator status of a user identified by [userId]
  /// within a group. The [isModerator] parameter determines whether the user
  /// should be set as a moderator (`true`) or not (`false`).
  ///
  /// Returns a [Future] that completes with `true` if the operation was
  /// successful, or `false` otherwise.
  ///
  /// - Parameters:
  ///   - userId: The unique identifier of the user whose moderator status is to be updated.
  ///   - isModerator: A boolean value indicating whether the user should be a moderator.
  Future<bool> setGroupModerator(String userId, bool isModerator) async {
    try {
      final req = await push('chat:member:set_authorities:$userId', {'is_moderator': isModerator}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error setting group moderator $userId',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Sets the name of the group.
  ///
  /// This method sends a request to update the group name to the specified [name].
  ///
  /// Returns a [Future] that completes with a boolean value indicating whether the operation was successful.
  ///
  /// [name]: The new name to set for the group.
  ///
  /// Example:
  /// ```dart
  /// bool success = await setGroupName("New Group Name");
  /// ```
  Future<bool> setGroupName(String name) async {
    try {
      final req = await push('chat:patch', {'name': name}).future;

      if (req.isOk) return true;

      throw req;
    } catch (e) {
      throw MessagingSocketException(
        'Error setting group name $name',
        details: _mapPhxErrorDetails(e),
        topic: topic,
      );
    }
  }

  /// Remap Phoenix specific errors
  /// such as [ChannelTimeoutException], [PhoenixException] or [ChannelClosedError]
  /// or wrong responses [PushResponse] and other objects
  /// to [MessagingSocketException]'s details map with error code and description
  ///
  /// Needed for prevent doubling of error handling
  /// because Phoenix uses mix of functional and throwable style error handling like req.isOk and throw
  /// and also messed up with sync and async errors. ¯\_(ツ)_/¯
  Map _mapPhxErrorDetails(e) {
    if (e is PushResponse) {
      final response = e.response;
      if (response is Map) return response;
      if (response is String) return {'code': response};
      return {'response': response.toString()};
    }

    if (e is ChannelTimeoutException) {
      final response = e.response.response;

      return {...response, 'code': 'timeout'};
    }

    if (e is PhoenixException) {
      final socketClosed = e.socketClosed;
      final socketError = e.socketError;

      return {
        'channel_event': e.channelEvent,
        'code': socketError != null ? kPhxSocketErrorCode : kPhxSocketClosedCode,
        'socket_event': socketError?.toString() ?? socketClosed?.toString() ?? 'unknown',
      };
    }

    if (e is ChannelClosedError) {
      return {
        'code': kPhxChannelClosedCode,
        'message': e.toString(),
      };
    }

    return {
      'code': kPhxUnknownErrorCode,
      'exception': e.toString(),
    };
  }
}

sealed class UserChannelEvent {
  const UserChannelEvent();

  factory UserChannelEvent.fromMessage(Message m) {
    switch (m.event.value) {
      case 'chat_join':
        return ChatConversationJoin(int.parse(m.payload!['chat_id'].toString()));
      case 'chat_left':
        return ChatConversationLeave(int.parse(m.payload!['chat_id'].toString()));
      case 'sms_conversation_join':
        return SmsConversationJoin(int.parse(m.payload!['conversation_id'].toString()));
      case 'sms_conversation_left':
        return SmsConversationLeave(int.parse(m.payload!['conversation_id'].toString()));
      case 'phx_error':
        return UserChannelDisconnect();
      default:
        return UserChannelUnknown();
    }
  }
}

class ChatConversationJoin extends UserChannelEvent with EquatableMixin {
  ChatConversationJoin(this.chatId);
  final int chatId;

  @override
  List<Object> get props => [chatId];

  @override
  bool get stringify => true;
}

class ChatConversationLeave extends UserChannelEvent with EquatableMixin {
  ChatConversationLeave(this.chatId);
  final int chatId;

  @override
  List<Object> get props => [chatId];

  @override
  bool get stringify => true;
}

class SmsConversationJoin extends UserChannelEvent with EquatableMixin {
  SmsConversationJoin(this.conversationId);
  final int conversationId;

  @override
  List<Object> get props => [conversationId];

  @override
  bool get stringify => true;
}

class SmsConversationLeave extends UserChannelEvent with EquatableMixin {
  SmsConversationLeave(this.conversationId);
  final int conversationId;

  @override
  List<Object> get props => [conversationId];

  @override
  bool get stringify => true;
}

class UserChannelDisconnect extends UserChannelEvent {}

class UserChannelUnknown extends UserChannelEvent {}

sealed class ChatChannelEvent {
  const ChatChannelEvent();

  factory ChatChannelEvent.fromMessage(Message m) {
    switch (m.event.value) {
      case 'chat_info_update':
        return ChatChannelInfoUpdate(ChatPhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'message_update':
        return ChatChannelMessageUpdate(ChatMessagePhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'chat_cursor_set':
        return ChatChannelCursorSet(ChatMessageReadCursorPhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'typing':
        return ChatChannelTyping(m.payload!['user_id'].toString());
      case 'phx_error':
        return ChatChannelDisconnect();
      default:
        return ChatChannelUnknown(event: m.event.value);
    }
  }
}

class ChatChannelInfoUpdate extends ChatChannelEvent with EquatableMixin {
  ChatChannelInfoUpdate(this.chat);
  final Chat chat;

  @override
  List<Object> get props => [chat];

  @override
  bool get stringify => true;
}

class ChatChannelMessageUpdate extends ChatChannelEvent with EquatableMixin {
  ChatChannelMessageUpdate(this.message);
  final ChatMessage message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class ChatChannelCursorSet extends ChatChannelEvent with EquatableMixin {
  ChatChannelCursorSet(this.cursor);
  final ChatMessageReadCursor cursor;

  @override
  List<Object> get props => [cursor];

  @override
  bool get stringify => true;
}

class ChatChannelTyping extends ChatChannelEvent with EquatableMixin {
  ChatChannelTyping(this.userId);
  final String userId;

  @override
  List<Object> get props => [userId];

  @override
  bool get stringify => true;
}

class ChatChannelDisconnect extends ChatChannelEvent {}

class ChatChannelUnknown extends ChatChannelEvent {
  ChatChannelUnknown({this.event = 'unknown'});
  final String event;

  @override
  String toString() => 'ChatChannelUnknown: $event';
}

sealed class SmsChannelEvent {
  const SmsChannelEvent();

  factory SmsChannelEvent.fromMessage(Message m) {
    switch (m.event.value) {
      case 'conversation_info_update':
        return SmsChannelInfoUpdate(SmsConversationPhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'sms_message_update':
        return SmsChannelMessageUpdate(SmsMessagePhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'sms_conversation_cursor_set':
        return SmsChannelCursorSet(SmsMessageReadCursorPhxMapper.fromMap(m.payload as Map<String, dynamic>));
      case 'phx_error':
        return SmsChannelDisconnect();
      default:
        return SmsChannelUnknown(event: m.event.value);
    }
  }
}

class SmsChannelInfoUpdate extends SmsChannelEvent with EquatableMixin {
  SmsChannelInfoUpdate(this.conversation);
  final SmsConversation conversation;

  @override
  List<Object> get props => [conversation];

  @override
  bool get stringify => true;
}

class SmsChannelMessageUpdate extends SmsChannelEvent with EquatableMixin {
  SmsChannelMessageUpdate(this.message);
  final SmsMessage message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class SmsChannelCursorSet extends SmsChannelEvent with EquatableMixin {
  SmsChannelCursorSet(this.cursor);
  final SmsMessageReadCursor cursor;

  @override
  List<Object> get props => [cursor];

  @override
  bool get stringify => true;
}

class SmsChannelTyping extends ChatChannelEvent with EquatableMixin {
  SmsChannelTyping(this.number);
  final String number;

  @override
  List<Object> get props => [number];

  @override
  bool get stringify => true;
}

class SmsChannelDisconnect extends SmsChannelEvent {}

class SmsChannelUnknown extends SmsChannelEvent {
  SmsChannelUnknown({this.event = 'unknown'});
  final String event;

  @override
  String toString() => 'SmsChannelUnknown: $event';
}

class MessagingSocketException with EquatableMixin implements Exception {
  /// This message is intended to provide a human-readable description of the error from invokation side.
  final String message;

  /// The details of the response if has any.
  final Map details;

  /// The topic of the channel where the error occurred.
  final String topic;

  /// Server side error code
  late final code = details['code']?.toString() ?? details['reason']?.toString() ?? kPhxUnknownErrorCode;

  MessagingSocketException(this.message, {required this.details, required this.topic});

  @override
  String toString() => 'MessagingSocketException:\n$message\ntopic:$topic\ncode:$code';

  @override
  List<Object> get props => [message, details, topic];
}

const kPhxChannelClosedCode = 'channel_closed';
const kPhxSocketClosedCode = 'socket_closed';
const kPhxSocketErrorCode = 'socket_error';
const kPhxUnknownErrorCode = 'unknown_error';
