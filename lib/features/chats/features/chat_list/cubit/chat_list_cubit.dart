import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/chat/components/chats_event.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_list_state.dart';

final _logger = Logger('ChatListCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this._localChatRepository) : super(ChatListState.initial()) {
    init();
  }

  final LocalChatRepository _localChatRepository;
  late final StreamSubscription _chatsListSub;

  void init() async {
    _logger.info('Initialising');

    final chats = await _localChatRepository.getChats();
    emit(ChatListState(chats: chats, initialising: false));
    _logger.info('Initialised: ${chats.length} chats');

    _chatsListSub = _localChatRepository.eventBus.whereType<ChatUpdate>().listen((event) {
      _logger.info('ChatUpdate: ${event.chat}');
      emit(state.copyWith(chats: state.chats.mergeWith(event.chat)));
    });
  }

  @override
  Future<void> close() {
    _chatsListSub.cancel();
    return super.close();
  }
}
