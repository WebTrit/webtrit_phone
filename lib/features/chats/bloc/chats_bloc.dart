import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http; // TODO: remove
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

    try {
      final chatClientData = await _chatClientData;
      await state.client.connectUser(User(id: chatClientData.userId), chatClientData.token);
      emit(state.copyWith(status: ChatsStatus.connected));
    } on Exception catch (e) {
      emit(state.copyWith(status: ChatsStatus.error, error: e));
    }
  }

  /// Fetches the chat token and user id from the chat service
  /// TODO: move somewhere
  Future<ChatClientData> get _chatClientData async {
    final response = await http.get(
      Uri.parse('http://192.168.1.85:3000/auth/chat-token'),
      headers: {'Authorization': 'Bearer $_token', 'x-tenant-id': _tenantId},
    );

    final responseJson = jsonDecode(response.body);
    final chatToken = responseJson['token'] as String;
    final userId = responseJson['userId'] as String;

    return (userId: userId, token: chatToken);
  }
}

typedef ChatClientData = ({String userId, String token});
