import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:webtrit_phone/features/chats/extensions/phoenix_socket.dart';

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
  // ignore: unused_field
  final PhoenixSocket _client;
  final LocalChatRepository _localChatRepository;

  Chat? _chat;
  StreamSubscription? _chatSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxQueueSub;

  void restart() {
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _chat = null;
    emit(ConversationState.init(_participantId));
    _init();
  }

  Future sendMessage(String content) async {
    final chat = _chat;
    if (chat == null) {
      _localChatRepository.submitNewDialogMessage(_participantId, content);
    } else {
      _localChatRepository.submitNewMessage(chat.id, content);
    }
  }

  Future fetchHistory() async {
    final state = this.state;
    if (state is! CVSReady) return;

    final chatId = _chat?.id;
    if (state.fetchingHistory || state.historyEndReached) return;

    if (chatId == null) return;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return;

    emit(state.copyWith(fetchingHistory: true));

    _logger.info('fetchHistory: $chatId, ${topMessage.createdAt}');

    try {
      // Fetch history from local storage
      List<ChatMessage> messages = [];
      messages = await _localChatRepository.getMessageHistory(chatId, topMessage.createdAt, limit: 100);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final userChannel = _client.userChannel;
      if (messages.isEmpty && userChannel != null) {
        final payload = {'chat_id': chatId, 'from': topMessage.createdAt.toUtc().toIso8601String(), 'limit': 100};
        final req = await userChannel.push('messages_history', payload).future;
        messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();
        await _localChatRepository.insertHistoryPage(messages);
        _logger.info('fetchHistory: remote messages ${messages.length}');
      }

      final updatedMessages = [...state.messages, ...messages];
      if (messages.isNotEmpty) {
        emit(state.copyWith(messages: updatedMessages, fetchingHistory: false, historyEndReached: false));
      } else {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      }
    } on Exception catch (e) {
      emit(state.copyWith(fetchingHistory: false));
      _logger.warning('fetchHistory failed', e);
    }
  }

  Future<void> _init() async {
    _logger.info('Preparing conversation with $_participantId');

    try {
      final chatId = await _localChatRepository.findDialogId(_participantId);
      if (chatId != null) _chat = await _localChatRepository.getChat(chatId);
      _logger.info('local chat id find result: $_chat');

      if (isClosed) return;
      emit(ConversationState.ready(_participantId));

      // If local chat is not found, subscribtion will find the chat when it will created
      // e.g when you send the first message or another user sends to you
      _chatSub = _chatUpdateSubFactory(_handleChatUpdate);

      _outboxQueueSub = _outboxQueueSubFactory(_handleOutboxQueueUpdate);

      if (chatId != null) _initMessages();
    } catch (e) {
      emit(ConversationState.error(_participantId, e));
    }
  }

  Future<void> _initMessages() async {
    final chatId = _chat?.id;
    if (chatId == null) return;

    // Fetch last 100 messages from the chat history
    final messages = await _localChatRepository.getLastMessages(chatId, limit: 100);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(messages: messages));

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
    if (_chat == null) {
      _chat = chat;
      _initMessages();
    } else {
      _chat = chat;
    }
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

  StreamSubscription _outboxQueueSubFactory(void Function(List<ChatQueueEntry>) onArrive) {
    return _localChatRepository.watchChatQueueEntries().listen((entries) {
      final chatQueueEntries = entries.where((e) {
        return e.participantId == _participantId || (_chat?.id != null && e.chatId == _chat?.id);
      }).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxQueueUpdate(List<ChatQueueEntry> entries) {
    _logger.info('_handleOutboxQueueUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxQueue: entries));
  }

  @override
  Future<void> close() {
    _logger.info('Closing conversation with $_participantId');
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _outboxQueueSub?.cancel();
    return super.close();
  }
}
