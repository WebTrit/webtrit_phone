import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:uuid/uuid.dart';
import 'package:webtrit_phone/features/chats/extensions/phoenix_socket.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'conversation_state.dart';

final _logger = Logger('ConversationCubit');

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    this._participantId,
    this._client,
    this._chatsRepository,
    this._outboxRepository,
  ) : super(ConversationState.init(_participantId)) {
    _init();
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final String _participantId;
  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;

  Chat? _chat;
  StreamSubscription? _chatSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxMessagesSub;
  StreamSubscription? _outboxMessageEditsSub;
  StreamSubscription? _outboxMessageDeletesSub;

  void restart() {
    _logger.info('Restarting conversation with $_participantId');
    _cancelSubs();
    _chat = null;
    emit(ConversationState.init(_participantId));
    _init();
  }

  Future sendMessage(String content, bool useSms) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chat?.id,
      participantId: _participantId,
      content: content,
      viaSms: useSms,
      smsNumber: useSms ? _participantId : null,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendReply(String content, ChatMessage refMessage) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chat?.id,
      participantId: _participantId,
      replyToId: refMessage.id,
      content: content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendForward(ChatMessage refMessage) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chat?.id,
      participantId: _participantId,
      forwardFromId: refMessage.chatId,
      authorId: refMessage.senderId,
      content: refMessage.content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendEdit(String content, ChatMessage refMessage) async {
    if (_chat == null) return;
    final outboxEntry = ChatOutboxMessageEditEntry(
      id: refMessage.id,
      idKey: refMessage.idKey,
      chatId: _chat!.id,
      newContent: content,
    );
    _outboxRepository.upsertOutboxMessageEdit(outboxEntry);
  }

  Future deleteMessage(ChatMessage message) async {
    if (_chat == null) return;
    final outboxEntry = ChatOutboxMessageDeleteEntry(
      id: message.id,
      idKey: message.idKey,
      chatId: _chat!.id,
    );
    _outboxRepository.upsertOutboxMessageDelete(outboxEntry);
  }

  Future markAsViewed(ChatMessage message) async {
    if (_chat == null) return;
    final outboxEntry = ChatOutboxMessageViewEntry(
      id: message.id,
      idKey: message.idKey,
      chatId: _chat!.id,
    );
    _outboxRepository.upsertOutboxMessageView(outboxEntry);
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
      List<ChatMessage> messages = [];

      // Fetch history from local storage
      // Exclude reply,forward cache and other messages that are not in sync
      final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.oldest);
      messages = await _chatsRepository.getMessageHistory(chatId, from: topMessage.createdAt, to: oldestCursor?.time);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final channel = _client.getChatChannel(chatId);
      if (messages.isEmpty && channel != null) {
        final payload = {'created_before': topMessage.createdAt.toUtc().toIso8601String(), 'limit': 50};
        final req = await channel.push('message:history', payload).future;
        messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();
        _logger.info('fetchHistory: remote messages ${messages.length}');
        if (messages.isNotEmpty) {
          await _chatsRepository.insertHistoryPage(messages);
          await _chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
            chatId: chatId,
            cursorType: MessageSyncCursorType.oldest,
            time: messages.last.createdAt,
          ));
        }
      }

      if (isClosed) return;

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
      final chatId = await _chatsRepository.findDialogId(_participantId);
      if (chatId != null) _chat = await _chatsRepository.getChat(chatId);
      _logger.info('local chat id find result: $_chat');

      if (isClosed) return;
      emit(ConversationState.ready(_participantId, chat: _chat));

      // If local chat is not found, subscribtion will find the chat when it will created
      // e.g when you send the first message or another user sends to you
      _chatSub = _chatUpdateSubFactory(_handleChatUpdate);

      _outboxMessagesSub = _outboxMessagesSubFactory(_handleOutboxMessagesUpdate);
      _outboxMessageEditsSub = _outboxMessageEditsSubFactory(_handleOutboxMessageEditsUpdate);
      _outboxMessageDeletesSub = _outboxMessageDeletesSubFactory(_handleOutboxMessageDeletesUpdate);

      if (chatId != null) await _initMessages();
    } catch (e) {
      emit(ConversationState.error(_participantId, e));
    }
  }

  Future<void> _initMessages() async {
    final chatId = _chat?.id;
    if (chatId == null) return;

    // Fetch last 100 messages from the chat history
    final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.oldest);
    final messages = await _chatsRepository.getMessageHistory(chatId, to: oldestCursor?.time);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(messages: messages));

    // Subscribe to chat messages updates eg new messages, edited, deleted, etc. and merge them with the current list
    _messagesSub?.cancel();
    _messagesSub = _messagesSubFactory(_handleMessageUpdate);
  }

  StreamSubscription _chatUpdateSubFactory(void Function(Chat) onArrive) {
    return _chatsRepository.eventBus.whereType<ChatUpdate>().listen((event) {
      final chat = event.chat;
      final desiredChat = chat.isDialogWith(_participantId);
      if (desiredChat) onArrive(chat);
    });
  }

  void _handleChatUpdate(Chat chat) {
    _logger.info('_handleChatUpdate: $chat');
    final chatWasntExistBefore = _chat == null;

    _chat = chat;
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(chat: chat));

    // Init messages after chat is created for conversation with the participant
    if (chatWasntExistBefore) _initMessages();
  }

  StreamSubscription _messagesSubFactory(void Function(ChatMessage) onArrive) {
    return _chatsRepository.eventBus.whereType<ChatMessageUpdate>().listen((event) {
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

  StreamSubscription _outboxMessagesSubFactory(void Function(List<ChatOutboxMessageEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessages().listen((entries) {
      final chatQueueEntries = entries.where((e) {
        return e.participantId == _participantId || (_chat?.id != null && e.chatId == _chat?.id);
      }).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessagesUpdate(List<ChatOutboxMessageEntry> entries) {
    _logger.info('_handleOutboxMessagesUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessages: entries));
  }

  StreamSubscription _outboxMessageEditsSubFactory(void Function(List<ChatOutboxMessageEditEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessageEdits().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chat?.id).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageEditsUpdate(List<ChatOutboxMessageEditEntry> entries) {
    _logger.info('_handleOutboxMessageEditsUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessageEdits: entries));
  }

  StreamSubscription _outboxMessageDeletesSubFactory(void Function(List<ChatOutboxMessageDeleteEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessageDeletes().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chat?.id).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageDeletesUpdate(List<ChatOutboxMessageDeleteEntry> entries) {
    _logger.info('_handleOutboxMessageDeletesUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessageDeletes: entries));
  }

  @override
  Future<void> close() {
    _logger.info('Closing conversation with $_participantId');
    _cancelSubs();
    return super.close();
  }

  _cancelSubs() {
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _outboxMessagesSub?.cancel();
    _outboxMessageEditsSub?.cancel();
    _outboxMessageDeletesSub?.cancel();
  }
}
