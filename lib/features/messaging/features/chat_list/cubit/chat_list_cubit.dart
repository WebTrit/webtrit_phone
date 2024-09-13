import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_list_state.dart';

final _logger = Logger('ChatListCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._chatsRepository) : super(ChatListState.initial()) {
    init();
  }

  final ChatsRepository _chatsRepository;
  late final StreamSubscription _chatsListSub;

  void init() async {
    _logger.info('Initialising');

    final chatsList = await _chatsRepository.getChatsWithLastMessages();
    chatsList.sort(_comparator);

    emit(ChatListState(chatsList, [], false));
    _logger.info('Initialised: ${chatsList.length} chats');

    _chatsListSub = _chatsRepository.eventBus.listen((event) {
      _logger.info('Event: $event');

      if (event is ChatUpdate) {
        emit(state.copyWith(chats: _mergeWithChatUpdate(event.chat)));
      }
      if (event is ChatRemove) {
        emit(state.copyWith(chats: _removeChat(event.chatId)));
      }
      if (event is ChatMessageUpdate) {
        emit(state.copyWith(chats: _mergeWithMessageUpdate(event.message)));
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
    final index = state.chats.indexWhere((element) => element.$1.id == chat.id);
    if (index == -1) {
      newList = state.chats + [(chat, null)];
    } else {
      newList = List.of(state.chats);
      newList[index] = (chat, newList[index].$2);
    }
    newList.sort(_comparator);
    return newList;
  }

  List<(Chat, ChatMessage?)> _mergeWithMessageUpdate(ChatMessage message) {
    final index = state.chats.indexWhere((element) => element.$1.id == message.chatId);
    final oldMessage = state.chats[index].$2;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(state.chats);
      newList[index] = (newList[index].$1, message);
      return newList;
    }

    return state.chats;
  }

  List<(Chat, ChatMessage?)> _removeChat(int chatId) {
    return state.chats.where((element) => element.$1.id != chatId).toList();
  }

  @override
  Future<void> close() {
    _chatsListSub.cancel();
    return super.close();
  }
}
