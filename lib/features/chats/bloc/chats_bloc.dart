import 'package:flutter/foundation.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(String apiKey, this._token, this._tenantId) : super(ChatsState.initial(apiKey)) {
    on<Connect>(_connect);
  }
  final String _token;
  final String _tenantId;

  void _connect(Connect event, Emitter<ChatsState> emit) async {
    debugPrint(_token);
    debugPrint(_tenantId);
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: ChatsStatus.connected));
  }
}
