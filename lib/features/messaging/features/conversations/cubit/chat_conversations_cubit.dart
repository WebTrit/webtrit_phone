import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_conversations_state.dart';

final _logger = Logger('ChatConversationsCubit');

class ChatConversationsCubit extends Cubit<ChatConversationsState> {
  ChatConversationsCubit(this._repository) : super(ChatConversationsState.initial()) {
    init();
  }

  final ChatsRepository _repository;
  late final StreamSubscription _conversationsSub;

  void init() async {
    _logger.info('Initialising');

    final conversations = await _repository.getChatsWithLastMessages();
    conversations.sort(_comparator);

    emit(ChatConversationsState(conversations, false));
    _logger.info('Initialised: ${conversations.length} chats');

    _conversationsSub = _repository.eventBus.listen((event) {
      _logger.info('Event: $event');

      if (event is ChatUpdate) {
        emit(state.copyWith(conversations: _mergeWithChatUpdate(event.chat)));
      }
      if (event is ChatRemove) {
        emit(state.copyWith(conversations: _removeChat(event.chatId)));
      }
      if (event is ChatMessageUpdate) {
        emit(state.copyWith(conversations: _mergeWithMessageUpdate(event.message)));
      }
    });
  }

  /// Sort chat list by last message if available, otherwise by chat update time
  int _comparator((Chat, ChatMessage?) a, (Chat, ChatMessage?) b) {
    final aLastActivity = a.$2?.createdAt ?? a.$1.updatedAt;
    final bLastActivity = b.$2?.createdAt ?? b.$1.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  List<(Chat, ChatMessage?)> _mergeWithChatUpdate(Chat chat) {
    List<(Chat, ChatMessage?)> newList;
    final index = state.conversations.indexWhere((e) => e.$1.id == chat.id);
    if (index == -1) {
      newList = state.conversations + [(chat, null)];
    } else {
      newList = List.of(state.conversations);
      newList[index] = (chat, newList[index].$2);
    }
    newList.sort(_comparator);
    return newList;
  }

  List<(Chat, ChatMessage?)> _mergeWithMessageUpdate(ChatMessage message) {
    final index = state.conversations.indexWhere((e) => e.$1.id == message.chatId);
    final oldMessage = state.conversations[index].$2;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(state.conversations);
      newList[index] = (newList[index].$1, message);
      return newList;
    }

    return state.conversations;
  }

  List<(Chat, ChatMessage?)> _removeChat(int chatId) {
    return state.conversations.where((e) => e.$1.id != chatId).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub.cancel();
    return super.close();
  }
}
