import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;

part 'conversation_state.dart';

final logger = Logger('ConversationCubit');

/// Cubit for managing the conversation channel with one participant.
/// Needs to create a channel with the desired participant without explicit actions.
/// For example, when the user opens the chat screen with a specific user event if never chatted before.
class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    this._participantId,
    this._token,
    this._tenantId,
    this._getStreamServiceUrl,
    this._client,
  ) : super(CvnPreparing(_participantId)) {
    prepareConversation();
  }

  final String _participantId;
  final String _token;
  final String _tenantId;
  final String _getStreamServiceUrl;
  final StreamChatClient _client;
  Channel? _channel;

  /// Prepares and connects to the conversation channel
  Future<void> prepareConversation() async {
    emit(CvnPreparing(_participantId));
    final userId = _client.state.currentUser?.id;

    final channel = _client.channel(
      'messaging',
      extraData: {
        'members': [userId, _participantId]
      },
    );

    try {
      // Try to connect to the channel
      // If it fails, thats mean the channel does not exist or cant be created on client side
      // So call the getstream service to create the channel and try to connect again
      try {
        await channel.watch();
        _channel = channel;
        emit(CvnReady(_participantId, channel));
      } catch (e) {
        logger.info('Cant connect to channel: $e');
        await _createChannel();
        await prepareConversation();
      }
    } catch (e) {
      emit(CvnError(_participantId, e));
    }
  }

  Future<void> _createChannel() async {
    final response = await http.post(
      Uri.parse('$_getStreamServiceUrl/api/prepare-conversation'),
      headers: {
        'Authorization': 'Bearer $_token',
        'x-tenant-id': _tenantId,
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'participantId': _participantId}),
    );

    logger.info('_createChannel: ${response.body}');
  }

  @override
  Future<void> close() {
    _channel?.stopWatching();
    return super.close();
  }
}
