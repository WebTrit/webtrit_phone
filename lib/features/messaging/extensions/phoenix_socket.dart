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
  Stream<UserChannelEvent> get userEvents => messages.map((e) => UserChannelEvent.fromEvent(e));

  Stream<ChatChannelEvent> get chatEvents => messages.map((e) => ChatChannelEvent.fromEvent(e));

  Stream<SmsChannelEvent> get smsEvents => messages.map((e) => SmsChannelEvent.fromEvent(e));

  Future<Iterable<int>> get chatConversationsIds async {
    final response = (await push('chat:get_ids', {}).future).response;
    return (response as Iterable).cast<int>();
  }

  Future<Iterable<int>> get smsConversationsIds async {
    final response = (await push('sms:conversation:get_ids', {}).future).response;
    return (response as Iterable).cast<int>();
  }

  Future<Iterable<String>> get smsPhoneNumbers async {
    final response = (await push('user:get_info', {}).future).response;
    final smsNumbers = (response['sms_phone_numbers'] as Iterable).cast<String>();
    return smsNumbers.map((e) => e.e164Phone).whereNotNull();
  }

  Future<Chat> get chatConversation async {
    final infoReq = await push('chat:get', {}).future;
    return Chat.fromMap(infoReq.response as Map<String, dynamic>);
  }

  Future<SmsConversation> get smsConversation async {
    final infoReq = await push('sms:conversation:get', {}).future;
    return SmsConversation.fromMap(infoReq.response as Map<String, dynamic>);
  }

  Future<Iterable<ChatMessageReadCursor>> get chatCursors async {
    final cursorsReq = await push('chat:cursor:get', {}).future;
    return (cursorsReq.response as List).map((e) => ChatMessageReadCursor.fromMap(e));
  }

  Future<Iterable<SmsMessageReadCursor>> get smsCursors async {
    final cursorsReq = await push('sms:conversation:cursor:get', {}).future;
    return (cursorsReq.response as List).map((e) => SmsMessageReadCursor.fromMap(e));
  }

  Future<List<ChatMessage>> chatMessagHistory(int limit) async {
    final req = await push('message:history', {'limit': limit}).future;
    return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
  }

  Future<List<SmsMessage>> smsMessageHistory(int limit) async {
    final req = await push('sms:message:history', {'limit': limit}).future;
    return (req.response['data'] as Iterable).map((e) => SmsMessage.fromMap(e)).toList();
  }

  Future<List<ChatMessage>> chatMessageUpdates(DateTime updatedAfter, int limit) async {
    var payload = {'updated_after': updatedAfter.toUtc().toIso8601String(), 'limit': limit};
    final req = await push('message:updates', payload).future;
    return (req.response['data'] as Iterable).map((e) => ChatMessage.fromMap(e)).toList();
  }

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

  /// This function takes a [SmsOutboxMessageEditEntry] and attempts to edit an SMS message using this channel.
  /// [editEntry] The entry containing the details of the message to be edited.
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
