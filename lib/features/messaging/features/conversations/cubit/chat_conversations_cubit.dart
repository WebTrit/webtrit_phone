import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';

part 'chat_conversations_state.dart';

final _logger = Logger('ChatConversationsCubit');

class ChatConversationsCubit extends Cubit<ChatConversationsState> {
  ChatConversationsCubit(
    this._client,
    this._repository,
    this._contactsRepo,
  ) : super(ChatConversationsState.initial()) {
    init();
  }

  final PhoenixSocket _client;
  final ChatsRepository _repository;
  final ContactsRepository _contactsRepo;

  late final StreamSubscription _conversationsSub;

  void init() async {
    _logger.info('Initialising');

    final conversations = await _repository.getChatsWithLastMessages();
    final contacts = await _evaluateContacts(conversations.map((e) => e.$1).toList());
    final conversationsWithContacts = _mergeChatsWithContacts(conversations, contacts);
    conversationsWithContacts.sort(_comparator);

    emit(ChatConversationsState(conversationsWithContacts, false));
    _logger.info('Initialised: ${conversations.length} chats');

    _conversationsSub = _repository.eventBus.listen((event) async {
      if (event is ChatUpdate) {
        final newList = _mergeWithChatUpdate(event.chat, await _evaluateContacts([event.chat]));
        emit(state.copyWith(conversations: newList));
      }
      if (event is ChatRemove) {
        final newList = _removeChat(event.chatId);
        emit(state.copyWith(conversations: newList));
      }
      if (event is ChatMessageUpdate) {
        final newList = _mergeWithMessageUpdate(event.message);
        emit(state.copyWith(conversations: newList));
      }
    });
  }

  Future<bool> deleteConversation(int id) async {
    final channel = _client.getChatChannel(id);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    return channel.deleteChatConversation();
  }

  Future<bool> leaveGroup(int id) async {
    final channel = _client.getChatChannel(id);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    return channel.leaveGroup();
  }

  /// Sort chat list by last message if available, otherwise by chat update time
  int _comparator(ChatWithMessageAndMemebers a, ChatWithMessageAndMemebers b) {
    final aLastActivity = a.message?.createdAt ?? a.chat.updatedAt;
    final bLastActivity = b.message?.createdAt ?? b.chat.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  List<ChatWithMessageAndMemebers> _mergeWithChatUpdate(Chat chat, List<Contact> contacts) {
    List<ChatWithMessageAndMemebers> newList;
    final index = state.conversations.indexWhere((e) => e.chat.id == chat.id);
    if (index == -1) {
      newList = [(chat: chat, message: null, contacts: contacts), ...state.conversations];
    } else {
      newList = List.of(state.conversations);
      final item = newList[index];
      newList[index] = (chat: chat, message: item.message, contacts: contacts);
      newList.sort(_comparator);
    }
    return newList;
  }

  List<ChatWithMessageAndMemebers> _mergeWithMessageUpdate(ChatMessage message) {
    final index = state.conversations.indexWhere((e) => e.chat.id == message.chatId);
    final oldMessage = state.conversations[index].message;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(state.conversations);
      final oldItem = newList[index];
      newList[index] = (chat: oldItem.chat, message: message, contacts: oldItem.contacts);
      newList.sort(_comparator);
      return newList;
    }

    return state.conversations;
  }

  List<ChatWithMessageAndMemebers> _removeChat(int chatId) {
    return state.conversations.where((e) => e.chat.id != chatId).toList();
  }

  Future<List<Contact>> _evaluateContacts(List<Chat> chats) async {
    final userIds = chats.expand((e) => e.members).map((e) => e.userId).toSet();
    final q = await Future.wait(userIds.map((e) => _contactsRepo.getContactBySource(ContactSourceType.external, e)));
    return q.nonNulls.toList();
  }

  List<ChatWithMessageAndMemebers> _mergeChatsWithContacts(List<(Chat, ChatMessage?)> chats, List<Contact> contacts) {
    final contactMap = {for (final contact in contacts) contact.sourceId: contact};
    return chats.map((e) {
      final (chat, lastMessage) = e;
      final chatContacts = chat.members.map((e) => contactMap[e.userId]).nonNulls.toList();
      return (chat: chat, message: lastMessage, contacts: chatContacts);
    }).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub.cancel();
    return super.close();
  }
}
