import 'dart:async';

import 'package:flutter/foundation.dart';

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
    this._chatsRepository,
    this._contactsRepository, {
    Duration searchDebounceDuration = const Duration(milliseconds: 100),
  }) : _searchDebounceDuration = searchDebounceDuration,
       super(ChatConversationsState.initial());

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ContactsRepository _contactsRepository;
  final Duration _searchDebounceDuration;

  StreamSubscription? _conversationsSub;
  String _searchString = '';
  Timer? _searchDebounceTimer;

  void init() async {
    _conversationsSub?.cancel();
    _conversationsSub = _actionsStream
        .asyncMap((event) async {
          if (event is List<(Chat, ChatMessage?)>) {
            final contacts = await _evaluateContacts(event.map((e) => e.$1).toList());

            final (raw, toShow) = await compute((data) {
              final (conversations, contacts, searchString) = data;
              final merged = _mergeChatsWithContacts(conversations, contacts);
              merged.sort(_comparator);
              final filtered = filterBySearch(searchString, merged);
              return (merged, filtered);
            }, (event, contacts, _searchString));

            return ChatConversationsState(raw, toShow, false);
          }
          if (event is ChatUpdate) {
            final contacts = await _evaluateContacts([event.chat]);

            final (raw, toShow) = await compute((data) {
              final (chat, contacts, conversations, searchString) = data;
              final newList = _mergeWithChatUpdate(chat, contacts, conversations);
              final filtered = filterBySearch(searchString, newList);
              return (newList, filtered);
            }, (event.chat, contacts, state.conversations, _searchString));

            return ChatConversationsState(raw, toShow, false);
          }
          if (event is ChatRemove) {
            final (raw, toShow) = await compute((data) {
              final (chatId, conversations, searchString) = data;
              final newList = _removeChat(chatId, conversations);
              final filtered = filterBySearch(searchString, newList);
              return (newList, filtered);
            }, (event.chatId, state.conversations, _searchString));

            return ChatConversationsState(raw, toShow, false);
          }
          if (event is ChatMessageUpdate) {
            final (raw, toShow) = await compute((data) {
              final (msg, chList, searchString) = data;
              final newList = _mergeWithMessageUpdate(msg, chList);
              final filtered = filterBySearch(searchString, newList);
              return (newList, filtered);
            }, (event.message, state.conversations, _searchString));

            return ChatConversationsState(raw, toShow, false);
          }

          _logger.info('list recomputed ${state.conversationsToShow.length} / ${state.conversations.length}');
        })
        .listen((newState) {
          if (!isClosed && newState != null) emit(newState);
        });
  }

  Future<void> updateSearch(String value) async {
    _searchString = value;
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounceDuration, () => _doUpdateSearch());
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

  Stream get _actionsStream async* {
    yield await _chatsRepository.getChatsWithLastMessages();
    yield* _chatsRepository.eventBus;
  }

  Future<List<Contact>> _evaluateContacts(List<Chat> chats) async {
    final userIds = chats.expand((e) => e.members).map((e) => e.userId).toSet();
    final q = await Future.wait(
      userIds.map((e) => _contactsRepository.getContactBySource(ContactSourceType.external, e)),
    );
    return q.nonNulls.toList();
  }

  Future<void> _doUpdateSearch() async {
    final conversationsToShow = await compute((data) {
      final (searchString, conversations) = data;
      return filterBySearch(searchString, conversations);
    }, (_searchString, state.conversations));
    if (isClosed) return;
    emit(state.copyWith(conversationsToShow: conversationsToShow));
  }

  /// Sort chat list by last message if available, otherwise by chat update time
  static int _comparator(ChatWithMessageAndMemebers a, ChatWithMessageAndMemebers b) {
    final aLastActivity = a.message?.createdAt ?? a.chat.updatedAt;
    final bLastActivity = b.message?.createdAt ?? b.chat.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  static List<ChatWithMessageAndMemebers> _mergeWithChatUpdate(
    Chat chat,
    List<Contact> contacts,
    List<ChatWithMessageAndMemebers> conversations,
  ) {
    List<ChatWithMessageAndMemebers> newList;
    final index = conversations.indexWhere((e) => e.chat.id == chat.id);
    if (index == -1) {
      newList = [(chat: chat, message: null, contacts: contacts), ...conversations];
    } else {
      newList = List.of(conversations);
      final item = newList[index];
      newList[index] = (chat: chat, message: item.message, contacts: contacts);
      newList.sort(_comparator);
    }
    return newList;
  }

  static List<ChatWithMessageAndMemebers> _mergeWithMessageUpdate(
    ChatMessage message,
    List<ChatWithMessageAndMemebers> conversations,
  ) {
    final index = conversations.indexWhere((e) => e.chat.id == message.chatId);
    final oldMessage = conversations[index].message;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(conversations);
      final oldItem = newList[index];
      newList[index] = (chat: oldItem.chat, message: message, contacts: oldItem.contacts);
      newList.sort(_comparator);
      return newList;
    }

    return conversations;
  }

  static List<ChatWithMessageAndMemebers> _removeChat(int chatId, List<ChatWithMessageAndMemebers> conversations) {
    return conversations.where((e) => e.chat.id != chatId).toList();
  }

  static List<ChatWithMessageAndMemebers> _mergeChatsWithContacts(
    List<(Chat, ChatMessage?)> chats,
    List<Contact> contacts,
  ) {
    final contactMap = {for (final contact in contacts) contact.sourceId: contact};
    return chats.map((e) {
      final (chat, lastMessage) = e;
      final chatContacts = chat.members.map((e) => contactMap[e.userId]).nonNulls.toList();
      return (chat: chat, message: lastMessage, contacts: chatContacts);
    }).toList();
  }

  static List<ChatWithMessageAndMemebers> filterBySearch(
    String search,
    List<ChatWithMessageAndMemebers> conversations,
  ) {
    if (search.isEmpty) return conversations;

    return conversations.where((e) {
      var (:chat, :message, :contacts) = e;

      final groupName = chat.name?.toLowerCase();
      final contactNames = contacts
          .where((e) => e.isCurrentUser == false)
          .map((e) => '${e.aliasName} + ${e.firstName} + ${e.lastName}'.toLowerCase())
          .join(' ');
      final contactPhones = contacts.expand((e) => e.phones).map((e) => e.number).join(' ');
      final lastMessageText = message?.content ?? '';

      return groupName?.contains(search) == true ||
          contactNames.contains(search) ||
          contactPhones.contains(search) ||
          lastMessageText.contains(search);
    }).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub?.cancel();
    return super.close();
  }
}
