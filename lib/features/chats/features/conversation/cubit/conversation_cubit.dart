import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/chat/components/chats_event.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'conversation_state.dart';

final _logger = Logger('ConversationCubit');

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    this._participantId,
    this._client,
    this._localChatRepository,
  ) : super(ConversationState.init(_participantId)) {
    _init();
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final String _participantId;
  final PhoenixSocket _client;
  final LocalChatRepository _localChatRepository;

  Chat? _chat;
  StreamSubscription? _chatSub;
  StreamSubscription? _messagesSub;

  void restart() {
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _chat = null;
    emit(ConversationState.init(_participantId));
    _init();
  }

  Future<void> _init() async {
    _logger.info('Preparing conversation with $_participantId');

    try {
      final chatId = await _localChatRepository.findDialogId(_participantId);
      if (chatId != null) _chat = await _localChatRepository.getChat(chatId);
      _logger.info('local chat id find result: $_chat');

      if (isClosed) return;

      // If local chat is not found, subscribtion will find the chat when it will created
      // e.g when you send the first message or another user sends to you
      _chatSub = _chatUpdateSubFactory(_handleChatUpdate);

      if (chatId == null) {
        emit(ConversationState.ready(_participantId));
      } else {
        await _initMessages();
      }
    } catch (e) {
      emit(ConversationState.error(_participantId, e));
    }
  }

  Future<void> _initMessages() async {
    final chatId = _chat?.id;
    if (chatId == null) return;

    // Fetch last 20 messages from the chat history
    final messages = await _localChatRepository.getLastMessages(chatId, limit: 20);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    emit(ConversationState.ready(_participantId, messages: messages));

    // Subscribe to chat messages updates eg new messages, edited, deleted, etc. and merge them with the current list
    _messagesSub?.cancel();
    _messagesSub = _messagesSubFactory(_handleMessageUpdate);
  }

  StreamSubscription _chatUpdateSubFactory(void Function(Chat) onArrive) {
    return _localChatRepository.eventBus.whereType<ChatUpdate>().listen((event) {
      final chat = event.chat;
      final desiredChat = chat.isDialogWith(_participantId);
      if (desiredChat) onArrive(chat);
    });
  }

  void _handleChatUpdate(Chat chat) {
    _logger.info('_handleChatUpdate: $chat');
    if (_chat == null) _initMessages();
    _chat = chat;
  }

  StreamSubscription _messagesSubFactory(void Function(ChatMessage) onArrive) {
    return _localChatRepository.eventBus.whereType<ChatMessageUpdate>().listen((event) {
      final message = event.message;
      if (message.chatId == (_chat?.id ?? -1)) onArrive(message);
    });
  }

  void _handleMessageUpdate(ChatMessage message) {
    _logger.info('_handleMessageUpdate: $message');
    final state = this.state;
    if (state is CVSReady) {
      final updatedMessages = state.messages.mergeUpdateWith(message);
      emit(state.copyWith(messages: updatedMessages));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing conversation with $_participantId');
    _chatSub?.cancel();
    _messagesSub?.cancel();
    return super.close();
  }
}
