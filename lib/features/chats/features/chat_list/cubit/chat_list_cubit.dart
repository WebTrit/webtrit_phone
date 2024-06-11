import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_list_state.dart';

final _logger = Logger('ChatListCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit({
    required this.localChatRepository,
  }) : super(ChatListState.initial()) {
    init();
  }

  final LocalChatRepository localChatRepository;
  late final StreamSubscription _chatsListSub;

  void init() async {
    _logger.info('Initialising');

    final chats = await localChatRepository.getChats();
    emit(ChatListState(chats: chats, initialising: false));
    _logger.info('Initialised: ${chats.length} chats');

    _chatsListSub = localChatRepository.watchChats().listen((chats) {
      emit(ChatListState(chats: chats, initialising: false));
      _logger.info('Update emitted: ${chats.length} chats');
    });
  }

  @override
  Future<void> close() {
    _chatsListSub.cancel();
    return super.close();
  }
}
