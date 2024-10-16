// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/models.dart';

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
    final response = (await push('chat:get_ids', {}).future).response;
    return (response as Iterable).cast<int>();
  }

  /// Asynchronously retrieves a list of SMS conversation IDs for the user.
  ///
  /// This method returns a [Future] that completes with an [Iterable] of
  /// integers representing the IDs of SMS conversations.
  Future<Iterable<int>> get smsConversationsIds async {
    final response = (await push('sms:conversation:get_ids', {}).future).response;
    return (response as Iterable).cast<int>();
  }

  /// Asynchronously retrieves a list of phone numbers associated with user.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [String] phone numbers.
  Future<Iterable<String>> get smsPhoneNumbers async {
    final response = (await push('user:get_info', {}).future).response;
    final smsNumbers = (response['sms_phone_numbers'] as Iterable).cast<String>();
    return smsNumbers.map((e) => e.e164Phone).whereNotNull();
  }

  /// Asynchronously retrieves the chat conversation.
  ///
  /// This getter returns a [Future] that completes with a [Chat] object
  /// representing the chat conversation.
  Future<Chat> get chatConversation async {
    final infoReq = await push('chat:get', {}).future;
    return Chat.fromMap(infoReq.response as Map<String, dynamic>);
  }

  /// A getter that asynchronously retrieves an [SmsConversation].
  ///
  /// This method returns a [Future] that completes with an [SmsConversation].
  /// It can be used to fetch the conversation details for SMS messaging.
  Future<SmsConversation> get smsConversation async {
    final infoReq = await push('sms:conversation:get', {}).future;
    return SmsConversation.fromMap(infoReq.response as Map<String, dynamic>);
  }

  /// Asynchronously retrieves an iterable collection of chat message read cursors.
  ///
  /// This getter fetches the read cursors for chat messages, which can be used
  /// to determine the read status of messages in a chat.
  ///
  /// Returns a [Future] that completes with an [Iterable] of [ChatMessageReadCursor] objects.
  Future<Iterable<ChatMessageReadCursor>> get chatCursors async {
    final cursorsReq = await push('chat:cursor:get', {}).future;
    return (cursorsReq.response as List).map((e) => ChatMessageReadCursor.fromMap(e));
  }

  /// A getter that asynchronously retrieves an iterable collection of
  /// [SmsMessageReadCursor] objects.
  ///
  /// This getter is used to obtain the current read cursors for SMS messages.
  /// It returns a [Future] that completes with an [Iterable] of
  /// [SmsMessageReadCursor] instances.
  Future<Iterable<SmsMessageReadCursor>> get smsCursors async {
    final cursorsReq = await push('sms:conversation:cursor:get', {}).future;
    return (cursorsReq.response as List).map((e) => SmsMessageReadCursor.fromMap(e));
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
    final req = await push('message:get:$messageId', {}).future;
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
    final req = await push('message:history', payload).future;
    return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
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
    final req = await push('sms:message:history', payload).future;
    return (req.response['data'] as Iterable).map((e) => SmsMessage.fromMap(e)).toList();
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
    var payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
    final req = await push('message:updates', payload).future;
    return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
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
    var payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
    final req = await push('sms:message:updates', payload).future;
    return (req.response['data'] as Iterable).map((e) => SmsMessage.fromMap(e)).toList();
  }

  /// This function takes a [ChatOutboxMessageEntry] and sends a new chat message using this channel.
  /// It returns: [Future] that completes with a tuple containing the sent [ChatMessage]
  /// and an optional [Chat] object for case when new chat was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(ChatMessage, Chat?)> newChatMessage(ChatOutboxMessageEntry outboxEntry) async {
    var payload = {
      'recipient': outboxEntry.participantId,
      'content': outboxEntry.content,
      'idempotency_key': outboxEntry.idKey,
      'reply_to_id': outboxEntry.replyToId,
      'forwarded_from_id': outboxEntry.forwardFromId,
      'author_id': outboxEntry.authorId,
    };
    final r = await push('message:new', payload).future;
    final response = r.response;

    ChatMessage message;
    Chat? chat;

    if (r.isOk && response is Map<String, dynamic>) {
      if (response.containsKey('chat') && response.containsKey('msg')) {
        chat = Chat.fromMap(response['chat']);
        message = ChatMessage.fromMap(response['msg']);
        return (message, chat);
      }

      if (response.containsKey('id')) {
        message = ChatMessage.fromMap(response);
        return (message, chat);
      }
    }
    throw Exception('Error processing $outboxEntry $response');
  }

  /// This function takes a [ChatOutboxMessageEditEntry] and attempts to edit a chat message using this channel.
  /// [editEntry] The entry containing the details of the message to be edited.
  /// It returns a [Future] that resolves to the edited [ChatMessage].
  /// Throws an exception if the edit process fails.
  Future<ChatMessage> editChatMessage(ChatOutboxMessageEditEntry editEntry) async {
    var payload = {'new_content': editEntry.newContent};
    final r = await push('message:edit:${editEntry.id}', payload).future;
    final response = r.response;

    if (r.isOk && response is Map<String, dynamic>) {
      return ChatMessage.fromMap(response);
    }

    throw Exception('Error processing $editEntry $response');
  }

  /// This function takes a [ChatOutboxMessageDeleteEntry] and attempts to delete a chat message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the deleted [ChatMessage].
  /// Throws an exception if the deletion process fails.
  Future<ChatMessage> deleteChatMessage(ChatOutboxMessageDeleteEntry deleteEntry) async {
    final r = await push('message:delete:${deleteEntry.id}', {}).future;
    final response = r.response;

    if (r.isOk && response is Map<String, dynamic>) {
      return ChatMessage.fromMap(response);
    }

    throw Exception('Error processing $deleteEntry $response');
  }

  /// This function takes a [ChatOutboxReadCursorEntry] and attempts to set a chat cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [ChatMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<ChatMessageReadCursor> setChatReadCursor(ChatOutboxReadCursorEntry readCursor) async {
    var payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
    final r = await push('chat:cursor:set', payload).future;
    final response = r.response;

    if (r.isOk) {
      return ChatMessageReadCursor(chatId: readCursor.chatId, userId: socket.userId!, time: readCursor.time);
    }

    throw Exception('Error processing $readCursor $response');
  }

  /// This function takes an [SmsOutboxMessageEntry] and attempts to send it as a new SMS message using this channel.
  /// It returns a [Future] that resolves to a tuple containing the sent [SmsMessage]
  /// and an optional [SmsConversation] object if a new conversation was created by first message.
  /// Throws an exception if the message sending process fails.
  Future<(SmsMessage, SmsConversation?) /*?*/ > newSmsMessage(SmsOutboxMessageEntry outboxEntry) async {
    var payload = {
      'content': outboxEntry.content,
      'idempotency_key': outboxEntry.idKey,
      'from_phone_number': outboxEntry.fromPhoneNumber,
      'to_phone_number': outboxEntry.toPhoneNumber,
      'recepient_id': outboxEntry.recepientId,
    };
    final r = await push('sms:message:new', payload).future;
    final response = r.response;

    SmsMessage smsMessage;
    SmsConversation? smsConversation;

    if (r.isOk && response is Map<String, dynamic>) {
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
    throw Exception('Error processing $outboxEntry $response');
  }

  /// This function takes a [SmsOutboxMessageDeleteEntry] and attempts to delete an SMS message using this channel.
  /// [deleteEntry] The entry containing the details of the message to be deleted.
  /// It returns a [Future] that resolves to the edited [SmsMessage].
  /// Throws an exception if the edit process fails.
  Future<SmsMessage> deleteSmsMessage(SmsOutboxMessageDeleteEntry deleteEntry) async {
    final r = await push('sms:message:delete:${deleteEntry.id}', {}).future;
    final response = r.response;

    if (r.isOk && response is Map<String, dynamic>) {
      return SmsMessage.fromMap(response);
    }

    throw Exception('Error processing $deleteEntry $response');
  }

  /// This function takes a [SmsOutboxReadCursorEntry] and attempts to set an SMS cursor using this channel.
  /// [readCursor] The entry containing the details of the read cursor to be set.
  /// It returns a [Future] that resolves to the set [SmsMessageReadCursor].
  /// Throws an exception if the cursor setting process fails.
  Future<SmsMessageReadCursor> setSmsReadCursor(SmsOutboxReadCursorEntry readCursor) async {
    var payload = {'last_read_at': readCursor.time.toUtc().toIso8601String()};
    final r = await push('sms:conversation:cursor:set', payload).future;
    final response = r.response;

    if (r.isOk) {
      return SmsMessageReadCursor(
          conversationId: readCursor.conversationId, userId: socket.userId!, time: readCursor.time);
    }

    throw Exception('Error processing $readCursor $response');
  }

  /// This function sends a typing event to the chat channel.
  Future<bool> sendChatTyping() async {
    final r = await push('chat:typing', {}).future;
    if (r.isOk) return true;
    throw Exception('Error sending typing event ${r.response}');
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
    final r = await push('chat:delete', {}).future;
    if (r.isOk) return true;
    throw Exception('Error deleting chat ${r.response}');
  }

  /// Deletes an SMS conversation.
  ///
  /// This method asynchronously deletes an SMS conversation.
  ///
  /// Returns a [Future] that completes with a boolean value indicating
  /// whether the deletion was successful.
  Future<bool> deleteSmsConversation() async {
    final r = await push('sms:conversation:delete', {}).future;
    if (r.isOk) return true;
    throw Exception('Error deleting sms conversation ${r.response}');
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
  Future<bool> newGroup(String name, List<String> memberIds) async {
    final r = await push('chat:new', {'name': name, 'member_ids': memberIds}).future;
    if (r.isOk) return true;
    throw Exception('Error creating group $name ${r.response}');
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
    final r = await push('chat:member:leave', {}).future;
    if (r.isOk) return true;
    throw Exception('Error leaving group ${r.response}');
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
    final r = await push('chat:member:add:$userId', {}).future;
    if (r.isOk) return true;
    throw Exception('Error adding group member $userId ${r.response}');
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
    final r = await push('chat:member:remove:$userId', {}).future;
    if (r.isOk) return true;
    throw Exception('Error removing group member $userId ${r.response}');
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
    final r = await push('chat:member:set_authorities:$userId', {'is_moderator': isModerator}).future;
    if (r.isOk) return true;
    throw Exception('Error setting group moderator $userId ${r.response}');
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
    final r = await push('chat:patch', {'name': name}).future;
    if (r.isOk) return true;
    throw Exception('Error setting group name $name ${r.response}');
  }
}

sealed class UserChannelEvent {
  const UserChannelEvent();

  factory UserChannelEvent.fromEvent(Message e) {
    switch (e.event.value) {
      case 'chat_membership_join':
        return ChatConversationJoin(int.parse(e.payload!['chat_id'].toString()));
      case 'chat_membership_left':
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
      case 'chat:cursor:set':
        return ChatChannelCursorSet(ChatMessageReadCursor.fromMap(e.payload as Map<String, dynamic>));
      case 'typing':
        return ChatChannelTyping(e.payload!['user_id'].toString());
      case 'phx_error':
        return ChatChannelDisconnect();
      default:
        return ChatChannelUnknown();
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

class ChatChannelUnknown extends ChatChannelEvent {}

sealed class SmsChannelEvent {
  const SmsChannelEvent();

  factory SmsChannelEvent.fromEvent(Message e) {
    switch (e.event.value) {
      case 'conversation_info_update':
        return SmsChannelInfoUpdate(SmsConversation.fromMap(e.payload as Map<String, dynamic>));
      case 'sms_message_update':
        return SmsChannelMessageUpdate(SmsMessage.fromMap(e.payload as Map<String, dynamic>));
      case 'sms:conversation:cursor:set':
        return SmsChannelCursorSet(SmsMessageReadCursor.fromMap(e.payload as Map<String, dynamic>));
      case 'phx_error':
        return SmsChannelDisconnect();
      default:
        return SmsChannelUnknown();
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

class SmsChannelUnknown extends SmsChannelEvent {}
