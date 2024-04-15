import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'chats_event.dart';
part 'chats_state.dart';

/// Cubit for managing the getstream chat connection.
/// Responsible for requesting chat token for user from the backend service and connecting to the getstream api.
class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc(
    String apiKey,
    this._token,
    this._tenantId,
    this._getStreamServiceUrl,
  ) : super(ChatsState.initial(apiKey)) {
    on<Connect>(_connect);
    on<Refresh>(_refresh);
  }
  final String _token;
  final String _tenantId;
  final String _getStreamServiceUrl;

  void _connect(Connect event, Emitter<ChatsState> emit) async {
    try {
      final chatClientData = await _chatClientData;
      await state.client.connectUser(User(id: chatClientData.userId), chatClientData.token);
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  void _refresh(Refresh event, Emitter<ChatsState> emit) async {
    try {
      emit(state.copyWith(status: ChatsStatus.connecting));
      await state.client.disconnectUser();
      final chatClientData = await _chatClientData;
      await state.client.connectUser(User(id: chatClientData.userId), chatClientData.token);
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  /// Fetches the chat token and user id from the chat service
  Future<ChatClientData> get _chatClientData async {
    final response = await http.get(
      Uri.parse('$_getStreamServiceUrl/api/chat-token'),
      headers: {'Authorization': 'Bearer $_token', 'x-tenant-id': _tenantId},
    );

    final responseJson = jsonDecode(response.body);
    final chatToken = responseJson['token'] as String;
    final userId = responseJson['userId'] as String;

    return (userId: userId, token: chatToken);
  }
}

typedef ChatClientData = ({String userId, String token});
