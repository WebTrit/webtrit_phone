// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';

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

  /// Create channel by [chatId] and connect, if already exists returns it
  PhoenixChannel createChatChannel(int chatId) => addChannel(topic: 'chat:$chatId');

  /// Create sms conversation channel by [conversationId] and connect, if already exists returns it
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
  /// A stream of [UserChannelEvent] objects derived from the user channel.
  ///
  /// Returns a [Stream] of [UserChannelEvent] objects.
  Stream<UserChannelEvent> get userEvents => messages.map((e) => UserChannelEvent.fromEvent(e));

  /// A stream of [ChatChannelEvent]s derived from the chat conversation channel.
  ///
  /// Returns a [Stream] of [ChatChannelEvent] objects.
  Stream<ChatChannelEvent> get chatEvents => messages.map((e) => ChatChannelEvent.fromEvent(e));

  /// A stream of [SmsChannelEvent]s derived from the sms conversation channel.
  ///
  /// Returns a [Stream] of [SmsChannelEvent] objects.
  Stream<SmsChannelEvent> get smsEvents => messages.map((e) => SmsChannelEvent.fromEvent(e));

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
    final p = push('chat:get_all', {});
    final req = await p.future.catchError(_mapPhxError);

    final response = req.response;

    if (req.isOk && response is Iterable) {
      return response.cast<int>();
    }

    throw MessagingSocketException(
      'Error fetching chat conversation ids',
      response: response,
      topic: topic,
    );
  }

  /// Asynchronously retrieves a list of SMS conversation IDs for the user.
  ///
  /// This method returns a [Future] that completes with an [Iterable] of
  /// integers representing the IDs of SMS conversations.
  Future<Iterable<int>> get smsConversationsIds async {
    final p = push('sms:conversation:get_all', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Iterable) {
      return response.cast<int>();
    }

    throw MessagingSocketException(
      'Error fetching sms conversation ids',
      response: response,
      topic: topic,
    );
  }

  /// Asynchronously retrieves a list of phone numbers associated with user.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [String] phone numbers.
  Future<Iterable<String>> get smsPhoneNumbers async {
    final p = push('user:get_info', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      final smsNumbers = (response['sms_phone_numbers'] as Iterable).cast<String>();
      return smsNumbers.map((e) => e.e164Phone).whereNotNull();
    }

    throw MessagingSocketException(
      'Error fetching sms phone numbers',
      response: response,
      topic: topic,
    );
  }

  /// Asynchronously retrieves the chat conversation.
  ///
  /// This getter returns a [Future] that completes with a [Chat] object
  /// representing the chat conversation.
  Future<Chat> get chatConversation async {
    final p = push('chat:get', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return Chat.fromMap(response);
    }

    throw MessagingSocketException(
      'Error fetching chat conversation',
      response: response,
      topic: topic,
    );
  }

  /// A getter that asynchronously retrieves an [SmsConversation].
  ///
  /// This method returns a [Future] that completes with an [SmsConversation].
  /// It can be used to fetch the conversation details for SMS messaging.
  Future<SmsConversation> get smsConversation async {
    final p = push('sms:conversation:get', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return SmsConversation.fromMap(response);
    }

    throw MessagingSocketException(
      'Error fetching sms conversation',
      response: response,
      topic: topic,
    );
  }

  /// Asynchronously retrieves an iterable collection of chat message read cursors.
  ///
  /// This getter fetches the read cursors for chat messages, which can be used
  /// to determine the read status of messages in a chat.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [ChatMessageReadCursor] objects.
  Future<Iterable<ChatMessageReadCursor>> get chatCursors async {
    final p = push('chat:cursor:get', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Iterable) {
      return response.map((e) => ChatMessageReadCursor.fromMap(e));
    }

    throw MessagingSocketException(
      'Error fetching chat cursors',
      response: response,
      topic: topic,
    );
  }

  /// A getter that asynchronously retrieves an iterable collection of
  /// [SmsMessageReadCursor] objects.
  ///
  /// This getter is used to obtain the current read cursors for SMS messages.
  /// It returns a [Future] that completes with an [Iterable] of
  /// [SmsMessageReadCursor] instances.
  Future<Iterable<SmsMessageReadCursor>> get smsCursors async {
    final p = push('sms:conversation:cursor:get', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Iterable) {
      return response.map((e) => SmsMessageReadCursor.fromMap(e));
    }

    throw MessagingSocketException(
      'Error fetching sms cursors',
      response: response,
      topic: topic,
    );
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
    final p = push('message:get:$messageId', {});
    final req = await p.future.catchError(_mapPhxError);
    return req.isOk ? ChatMessage.fromMap(req.response as Map<String, dynamic>) : null;
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
    Map<String, dynamic> payload = {'limit': limit};
    if (createdBefore != null) payload['created_before'] = createdBefore.toUtc().toIso8601String();

    final p = push('message:history', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
    }

    throw MessagingSocketException(
      'Error fetching chat message history $limit $createdBefore',
      response: req.response,
      topic: topic,
    );
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
    Map<String, dynamic> payload = {'limit': limit};
    if (createdBefore != null) payload['created_before'] = createdBefore.toUtc().toIso8601String();

    final p = push('sms:message:history', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return (req.response['data'] as Iterable).map((e) => SmsMessage.fromMap(e)).toList();
    }

    throw MessagingSocketException(
      'Error fetching sms message history $limit $createdBefore',
      response: req.response,
      topic: topic,
    );
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
    final payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
    final p = push('message:updates', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
    }

    throw MessagingSocketException(
      'Error fetching chat message updates $updatedAfter $limit',
      response: req.response,
      topic: topic,
    );
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
    final payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
    final p = push('sms:message:updates', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return (req.response['data'] as Iterable).map((e) => SmsMessage.fromMap(e)).toList();
    }

    throw MessagingSocketException(
      'Error fetching sms message updates $updatedAfter $limit',
      response: req.response,
      topic: topic,
    );
  }

  /// This function takes a [ChatOutboxMessageEntry] and sends a new chat message using this channel.
  /// It returns: [Future] that completes with a tuple containing the sent [ChatMessage]
  /// and an optional [Chat] object for case when new chat was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(ChatMessage, Chat?)> newChatMessage(ChatOutboxMessageEntry outboxEntry) async {
    final payload = {
      'recipient': outboxEntry.participantId,
      'content': outboxEntry.content,
      'idempotency_key': outboxEntry.idKey,
      'reply_to_id': outboxEntry.replyToId,
      'forwarded_from_id': outboxEntry.forwardFromId,
      'author_id': outboxEntry.authorId,
    };
    final p = push('message:new', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    ChatMessage message;
    Chat? chat;

    if (req.isOk && response is Map<String, dynamic>) {
      if (response.containsKey('chat') && response.containsKey('message')) {
        chat = Chat.fromMap(response['chat']);
        message = ChatMessage.fromMap(response['message']);
        return (message, chat);
      }

      if (response.containsKey('id')) {
        message = ChatMessage.fromMap(response);
        return (message, chat);
      }
    }

    throw MessagingSocketException(
      'Error processing $outboxEntry',
      response: response,
      topic: topic,
    );
  }

  /// This function takes a [ChatOutboxMessageEditEntry] and attempts to edit a chat message using this channel.
  /// [editEntry] The entry containing the details of the message to be edited.
  /// It returns a [Future] that resolves to the edited [ChatMessage].
  /// Throws an exception if the edit process fails.
  Future<ChatMessage> editChatMessage(ChatOutboxMessageEditEntry editEntry) async {
    final payload = {'new_content': editEntry.newContent};
    final p = push('message:edit:${editEntry.id}', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return ChatMessage.fromMap(response);
    }

    throw MessagingSocketException(
      'Error editing chat message: $editEntry',
      response: response,
      topic: topic,
    );
  }

  /// This function takes a [ChatOutboxMessageDeleteEntry] and attempts to delete a chat message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the deleted [ChatMessage].
  /// Throws an exception if the deletion process fails.
  Future<ChatMessage> deleteChatMessage(ChatOutboxMessageDeleteEntry deleteEntry) async {
    final p = push('message:delete:${deleteEntry.id}', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return ChatMessage.fromMap(response);
    }

    throw MessagingSocketException(
      'Error deleting chat message: $deleteEntry',
      response: response,
      topic: topic,
    );
  }

  /// This function takes a [ChatOutboxReadCursorEntry] and attempts to set a chat cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [ChatMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<ChatMessageReadCursor> setChatReadCursor(ChatOutboxReadCursorEntry readCursor) async {
    final payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
    final p = push('chat:cursor:set', payload);
    final r = await p.future.catchError(_mapPhxError);
    final response = r.response;

    if (r.isOk) {
      return ChatMessageReadCursor(chatId: readCursor.chatId, userId: socket.userId!, time: readCursor.time);
    }

    throw MessagingSocketException(
      'Error setting chat read cursor: $readCursor',
      response: response,
      topic: topic,
    );
  }

  /// This function takes an [SmsOutboxMessageEntry] and attempts to send it as a new SMS message using this channel.
  /// It returns a [Future] that resolves to a tuple containing the sent [SmsMessage]
  /// and an optional [SmsConversation] object if a new conversation was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(SmsMessage, SmsConversation?) /*?*/ > newSmsMessage(SmsOutboxMessageEntry outboxEntry) async {
    final payload = {
      'content': outboxEntry.content,
      'idempotency_key': outboxEntry.idKey,
      'from_phone_number': outboxEntry.fromPhoneNumber,
      'to_phone_number': outboxEntry.toPhoneNumber,
      'recepient_id': outboxEntry.recepientId,
    };
    final p = push('sms:message:new', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    SmsMessage smsMessage;
    SmsConversation? smsConversation;

    if (req.isOk && response is Map<String, dynamic>) {
      if (response.containsKey('conversation') && response.containsKey('message')) {
        smsConversation = SmsConversation.fromMap(response['conversation']);
        smsMessage = SmsMessage.fromMap(response['message']);
        return (smsMessage, smsConversation);
      }

      if (response.containsKey('id')) {
        smsMessage = SmsMessage.fromMap(response);
        return (smsMessage, smsConversation);
      }
    }

    throw MessagingSocketException(
      'Error processing $outboxEntry',
      response: response,
      topic: topic,
    );
  }

  /// This function takes a [SmsOutboxMessageDeleteEntry] and attempts to delete an SMS message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the edited [SmsMessage].
  /// Throws an exception if the edit process fails.
  Future<SmsMessage> deleteSmsMessage(SmsOutboxMessageDeleteEntry deleteEntry) async {
    final p = push('sms:message:delete:${deleteEntry.id}', {});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return SmsMessage.fromMap(response);
    }

    throw MessagingSocketException(
      'Error deleting sms message: $deleteEntry',
      response: response,
      topic: topic,
    );
  }

  /// This function takes a [SmsOutboxReadCursorEntry] and attempts to set an SMS cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [SmsMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<SmsMessageReadCursor> setSmsReadCursor(SmsOutboxReadCursorEntry readCursor) async {
    final payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
    final p = push('sms:conversation:cursor:set', payload);
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk) {
      return SmsMessageReadCursor(
          conversationId: readCursor.conversationId, userId: socket.userId!, time: readCursor.time);
    }

    throw MessagingSocketException(
      'Error setting sms read cursor: $readCursor',
      response: response,
      topic: topic,
    );
  }

  /// This function sends a typing event to the chat channel.
  void sendChatTyping() async {
    push('chat:typing', {});
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
    final p = push('chat:delete', {});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error deleting chat',
      response: req.response,
      topic: topic,
    );
  }

  /// Deletes an SMS conversation.
  ///
  /// This method asynchronously deletes an SMS conversation.
  ///
  /// Returns a [Future] that completes with a boolean value indicating
  /// whether the deletion was successful.
  Future<bool> deleteSmsConversation() async {
    final p = push('sms:conversation:delete', {});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error deleting sms conversation',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:new', {'name': name, 'member_ids': memberIds});
    final req = await p.future.catchError(_mapPhxError);
    final response = req.response;

    if (req.isOk && response is Map<String, dynamic>) {
      return Chat.fromMap(response);
    }

    throw MessagingSocketException(
      'Error creating group: $name, members: $memberIds',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:member:leave', {});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error leaving group',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:member:add:$userId', {});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error adding group member $userId',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:member:remove:$userId', {});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error removing group member $userId',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:member:set_authorities:$userId', {'is_moderator': isModerator});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error setting group moderator $userId',
      response: req.response,
      topic: topic,
    );
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
    final p = push('chat:patch', {'name': name});
    final req = await p.future.catchError(_mapPhxError);

    if (req.isOk) return true;

    throw MessagingSocketException(
      'Error setting group name $name',
      response: req.response,
      topic: topic,
    );
  }

  /// Unwraps a [ChannelTimeoutException] that made inside push().future implementation
  /// and returns the raw response with appended error code.
  ///
  /// If the exception is not a [ChannelTimeoutException], it is rethrown.
  _mapPhxError(e) {
    if (e is ChannelTimeoutException) {
      final response = e.response.response;
      final status = e.response.status;
      return PushResponse(response: {...response, 'code': 'timeout'}, status: status);
    }
    throw e;
  }
}

sealed class UserChannelEvent {
  const UserChannelEvent();

  factory UserChannelEvent.fromEvent(Message e) {
    switch (e.event.value) {
      case 'chat_join':
        return ChatConversationJoin(int.parse(e.payload!['chat_id'].toString()));
      case 'chat_left':
        return ChatConversationLeave(int.parse(e.payload!['chat_id'].toString()));
      case 'sms_conversation_join':
        return SmsConversationJoin(int.parse(e.payload!['conversation_id'].toString()));
      case 'sms_conversation_left':
        return SmsConversationLeave(int.parse(e.payload!['conversation_id'].toString()));
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

  factory ChatChannelEvent.fromEvent(Message e) {
    switch (e.event.value) {
      case 'chat_info_update':
        return ChatChannelInfoUpdate(Chat.fromMap(e.payload as Map<String, dynamic>));
      case 'message_update':
        return ChatChannelMessageUpdate(ChatMessage.fromMap(e.payload as Map<String, dynamic>));
      case 'chat_cursor_set':
        return ChatChannelCursorSet(ChatMessageReadCursor.fromMap(e.payload as Map<String, dynamic>));
      case 'typing':
        return ChatChannelTyping(e.payload!['user_id'].toString());
      case 'phx_error':
        return ChatChannelDisconnect();
      default:
        return ChatChannelUnknown(event: e.event.value);
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

  factory SmsChannelEvent.fromEvent(Message e) {
    switch (e.event.value) {
      case 'conversation_info_update':
        return SmsChannelInfoUpdate(SmsConversation.fromMap(e.payload as Map<String, dynamic>));
      case 'sms_message_update':
        return SmsChannelMessageUpdate(SmsMessage.fromMap(e.payload as Map<String, dynamic>));
      case 'sms_conversation_cursor_set':
        return SmsChannelCursorSet(SmsMessageReadCursor.fromMap(e.payload as Map<String, dynamic>));
      case 'phx_error':
        return SmsChannelDisconnect();
      default:
        return SmsChannelUnknown(event: e.event.value);
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

  /// The response returned by the server.
  final dynamic response;

  /// The topic of the channel where the error occurred.
  final String? topic;

  /// The details of the response if has any.
  late final Map details = response is Map ? response : {};

  /// Server side error code
  late final code = details['code'] ?? (response is String ? response : null);

  MessagingSocketException(this.message, {this.response, this.topic});

  @override
  String toString() => 'MessagingSocketException:\n$message\ntopic:$topic\ncode:$code';

  @override
  List<Object> get props => [message, response, topic.toString()];
}
