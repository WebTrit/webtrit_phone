// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import '../../../chats.dart';

part 'conversation_state.dart';

final logger = Logger('ConversationCubit');

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    this._participantId,
    this._client,
  ) : super(CVSPreparing(_participantId)) {
    prepareConversation();
  }

  final String _participantId;
  final ChatsClient _client;

  Future<void> prepareConversation() async {
    emit(CVSPreparing(_participantId));

    try {
      emit(CVSReady(_participantId));
    } catch (e) {
      emit(CVSError(_participantId, e));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
