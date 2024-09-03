import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_list_state.dart';

// TODO: fetch with last message and sort by last message date

final _logger = Logger('ChatListCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._chatsRepository) : super(ChatListState.initial()) {
    init();
  }

  final ChatsRepository _chatsRepository;
  late final StreamSubscription _chatsListSub;

  void init() async {
    _logger.info('Initialising');

    final chatsList = await _chatsRepository.getChats();
    chatsList.sort(_comparator);
    emit(ChatListState(chats: chatsList, initialising: false));
    _logger.info('Initialised: ${chatsList.length} chats');

    _chatsListSub = _chatsRepository.eventBus.listen((event) {
      _logger.info('Event: $event');

      if (event is ChatUpdate) {
        var newList = state.chats.copyMerge(event.chat);
        newList.sort(_comparator);
        emit(state.copyWith(chats: newList));
      }
      if (event is ChatRemove) {
        var newList = state.chats.copyRemove(event.chatId);
        emit(state.copyWith(chats: newList));
      }
    });
  }

  int _comparator(Chat a, Chat b) => b.updatedAt.compareTo(a.updatedAt);

  @override
  Future<void> close() {
    _chatsListSub.cancel();
    return super.close();
  }
}
