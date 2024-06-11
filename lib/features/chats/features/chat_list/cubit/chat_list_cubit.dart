import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

part 'chat_list_state.dart';

final _logger = Logger('ConversationCubit');

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit() : super(ChatListState.initial()) {
    init();
  }

  void init() {
    _logger.info('Initialising');
    emit(ChatListState(chats: [], initialising: false));
  }
}
