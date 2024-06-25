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

part 'group_state.dart';

final _logger = Logger('GroupCubit');

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(
    this._chatId,
    this._client,
    this._localChatRepository,
  ) : super(GroupState.init(_chatId)) {
    _init();
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final int _chatId;
  final PhoenixSocket _client;
  final LocalChatRepository _localChatRepository;

  StreamSubscription? _chatSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxQueueSub;

  void restart() {
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _outboxQueueSub?.cancel();
    // _chat = null;
    emit(GroupState.init(_chatId));
    _init();
  }

  Future sendMessage(String content) async {
    _localChatRepository.submitNewMessage(_chatId, content);
  }

  Future fetchHistory() async {
    final state = this.state;
    if (state is! GroupStateReady) return;

    if (state.fetchingHistory || state.historyEndReached) return;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return;

    emit(state.copyWith(fetchingHistory: true));

    _logger.info('fetchHistory: $_chatId, ${topMessage.createdAt}');

    try {
      // Fetch history from local storage
      List<ChatMessage> messages = [];
      messages = await _localChatRepository.getMessageHistory(_chatId, topMessage.createdAt, limit: 100);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final userChannel = _client.userChannel;
      if (messages.isEmpty && userChannel != null) {
        final payload = {'chat_id': _chatId, 'from': topMessage.createdAt.toUtc().toIso8601String(), 'limit': 100};
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
    _logger.info('Preparing group $_chatId');

    try {
      final chat = await _localChatRepository.getChat(_chatId);
      _logger.info('init chat: $chat');
      final messages = await _localChatRepository.getLastMessages(_chatId, limit: 100);
      _logger.info('init msg\'s: ${messages.length}');

      if (isClosed) return;
      emit(GroupState.ready(_chatId, chat, messages: messages));

      _chatSub = _chatUpdateSubFactory(_handleChatUpdate);
      _messagesSub = _messagesSubFactory(_handleMessageUpdate);
      _outboxQueueSub = _outboxQueueSubFactory(_handleOutboxQueueUpdate);
    } catch (e) {
      emit(GroupState.error(_chatId, e));
    }
  }

  StreamSubscription _chatUpdateSubFactory(void Function(Chat) onArrive) {
    return _localChatRepository.eventBus.whereType<ChatUpdate>().listen((event) {
      final chat = event.chat;
      final desiredChat = chat.id == _chatId;
      if (desiredChat) onArrive(chat);
    });
  }

  void _handleChatUpdate(Chat chat) {
    _logger.info('_handleChatUpdate: $chat');
    final state = this.state;
    if (state is GroupStateReady) emit(state.copyWith(chat: chat));
  }

  StreamSubscription _messagesSubFactory(void Function(ChatMessage) onArrive) {
    return _localChatRepository.eventBus.whereType<ChatMessageUpdate>().listen((event) {
      final message = event.message;
      if (message.chatId == _chatId) onArrive(message);
    });
  }

  void _handleMessageUpdate(ChatMessage message) {
    _logger.info('_handleMessageUpdate: $message');
    final state = this.state;
    if (state is GroupStateReady) {
      final updatedMessages = state.messages.mergeUpdateWith(message);
      emit(state.copyWith(messages: updatedMessages));
    }
  }

  StreamSubscription _outboxQueueSubFactory(void Function(List<ChatQueueEntry>) onArrive) {
    return _localChatRepository.watchChatQueueEntries().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxQueueUpdate(List<ChatQueueEntry> entries) {
    _logger.info('_handleOutboxQueueUpdate: ${entries.length}');
    final state = this.state;
    if (state is GroupStateReady) emit(state.copyWith(outboxQueue: entries));
  }

  @override
  Future<void> close() {
    _logger.info('Closing group $_chatId');
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _outboxQueueSub?.cancel();
    return super.close();
  }
}
