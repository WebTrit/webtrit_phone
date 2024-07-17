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

    final chats = await _chatsRepository.getChats();
    chats.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    emit(ChatListState(chats: chats, initialising: false));
    _logger.info('Initialised: ${chats.length} chats');

    _chatsListSub = _chatsRepository.eventBus.listen((event) {
      _logger.info('Event: $event');

      if (event is ChatUpdate) {
        emit(state.copyWith(chats: state.chats.mergeWith(event.chat)));
      }
      if (event is ChatRemove) {
        emit(state.copyWith(chats: state.chats.where((chat) => chat.id != event.chatId).toList()));
      }
    });
  }

  @override
  Future<void> close() {
    _chatsListSub.cancel();
    return super.close();
  }
}
