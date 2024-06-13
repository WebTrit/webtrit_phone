// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

part 'conversation_state.dart';

final _logger = Logger('ConversationCubit');

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    this._participantId,
    this._client,
  ) : super(CVSPreparing(_participantId)) {
    prepareConversation();
  }

  final String _participantId;
  final PhoenixSocket _client;

  Future<void> prepareConversation() async {
    _logger.info('Preparing conversation with $_participantId');

    emit(CVSPreparing(_participantId));

    try {
      emit(CVSReady(_participantId));
    } catch (e) {
      emit(CVSError(_participantId, e));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing conversation with $_participantId');
    return super.close();
  }
}
