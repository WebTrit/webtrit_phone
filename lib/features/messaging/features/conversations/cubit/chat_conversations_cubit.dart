import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_conversations_state.dart';

final _logger = Logger('ChatConversationsCubit');

class ChatConversationsCubit extends Cubit<ChatConversationsState> {
  ChatConversationsCubit(this._repository, this._contactsRepo) : super(ChatConversationsState.initial()) {
    init();
  }

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
      _logger.info('Event: $event');

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

  /// Sort chat list by last message if available, otherwise by chat update time
  int _comparator(ChatWithMessageAndMemebers a, ChatWithMessageAndMemebers b) {
    final aLastActivity = a.$2?.createdAt ?? a.$1.updatedAt;
    final bLastActivity = b.$2?.createdAt ?? b.$1.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  List<ChatWithMessageAndMemebers> _mergeWithChatUpdate(Chat chat, List<Contact> contacts) {
    List<ChatWithMessageAndMemebers> newList;
    final index = state.conversations.indexWhere((e) => e.$1.id == chat.id);
    if (index == -1) {
      newList = [(chat, null, contacts), ...state.conversations];
    } else {
      newList = List.of(state.conversations);
      final item = newList[index];
      newList[index] = (chat, item.$2, contacts);
      newList.sort(_comparator);
    }
    return newList;
  }

  List<ChatWithMessageAndMemebers> _mergeWithMessageUpdate(ChatMessage message) {
    final index = state.conversations.indexWhere((e) => e.$1.id == message.chatId);
    final oldMessage = state.conversations[index].$2;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(state.conversations);
      final oldItem = newList[index];
      newList[index] = (oldItem.$1, message, oldItem.$3);
      newList.sort(_comparator);
      return newList;
    }

    return state.conversations;
  }

  List<ChatWithMessageAndMemebers> _removeChat(int chatId) {
    return state.conversations.where((e) => e.$1.id != chatId).toList();
  }

  Future<List<Contact>> _evaluateContacts(List<Chat> chats) async {
    final userIds = chats.expand((e) => e.members).map((e) => e.userId).toSet();
    final q = await Future.wait(userIds.map((e) => _contactsRepo.getContactBySource(ContactSourceType.external, e)));
    return q.whereNotNull().toList();
  }

  List<ChatWithMessageAndMemebers> _mergeChatsWithContacts(List<(Chat, ChatMessage?)> chats, List<Contact> contacts) {
    final contactMap = {for (final contact in contacts) contact.sourceId: contact};
    return chats.map((e) {
      final chat = e.$1;
      final lastMessage = e.$2;
      final chatContacts = chat.members.map((e) => contactMap[e.userId]).whereNotNull().toList();
      return (chat, lastMessage, chatContacts);
    }).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub.cancel();
    return super.close();
  }
}
