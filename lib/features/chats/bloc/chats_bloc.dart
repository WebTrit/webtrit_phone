// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc({required ChatsClient client}) : super(ChatsState.initial(client)) {
    on<Connect>(_connect);
    on<Refresh>(_refresh);
  }

  void _connect(Connect event, Emitter<ChatsState> emit) async {
    try {
      emit(state.copyWith(status: ChatsStatus.connecting));
      await state.client.connect();
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  void _refresh(Refresh event, Emitter<ChatsState> emit) async {
    try {
      await state.client.disconnect();
      emit(state.copyWith(status: ChatsStatus.connecting));
      await state.client.connect();
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }
}
