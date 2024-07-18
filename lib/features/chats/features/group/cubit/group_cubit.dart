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

part 'group_state.dart';

final _logger = Logger('GroupCubit');

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(
    this._chatId,
    this._client,
    this._chatsRepository,
    this._outboxRepository,
  ) : super(GroupState.init(_chatId)) {
    _init();
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  final int _chatId;
  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;

  StreamSubscription? _chatSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxMessagesSub;
  StreamSubscription? _outboxMessageEditsSub;
  StreamSubscription? _outboxMessageDeletesSub;

  void restart() {
    _logger.info('Restarting group $_chatId');
    _cancelSubs();
    emit(GroupState.init(_chatId));
    _init();
  }

  Future sendMessage(String content) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chatId,
      content: content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendReply(String content, ChatMessage refMessage) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chatId,
      replyToId: refMessage.id,
      content: content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendForward(ChatMessage refMessage) async {
    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: _chatId,
      forwardFromId: refMessage.chatId,
      authorId: refMessage.senderId,
      content: refMessage.content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendEdit(String content, ChatMessage refMessage) async {
    final outboxEntry = ChatOutboxMessageEditEntry(
      id: refMessage.id,
      idKey: refMessage.idKey,
      chatId: _chatId,
      newContent: content,
    );
    _outboxRepository.upsertOutboxMessageEdit(outboxEntry);
  }

  Future deleteMessage(ChatMessage message) async {
    final outboxEntry = ChatOutboxMessageDeleteEntry(
      id: message.id,
      idKey: message.idKey,
      chatId: _chatId,
    );
    _outboxRepository.upsertOutboxMessageDelete(outboxEntry);
  }

  Future markAsViewed(ChatMessage message) async {
    final outboxEntry = ChatOutboxMessageViewEntry(
      id: message.id,
      idKey: message.idKey,
      chatId: _chatId,
    );
    _outboxRepository.upsertOutboxMessageView(outboxEntry);
  }

  Future<bool> leaveGroup() async {
    final state = this.state;
    if (state is! GroupStateReady) return false;
    if (state.busy) return false;
    emit(state.copyWith(busy: true));

    final channel = _client.getChatChannel(_chatId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    final r = await channel.push('chat:leave_group', {}).future;
    emit(state.copyWith(busy: false));
    if (r.isOk) return true;

    return false;
  }

  Future addUser(String phoneNumber) async {
    final state = this.state;
    if (state is! GroupStateReady) return;
    if (state.busy) return;
    emit(state.copyWith(busy: true));

    final channel = _client.getChatChannel(_chatId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return;
    final r = await channel.push('chat:add_group_member', {'member_id': phoneNumber}).future;
    emit(state.copyWith(busy: false));
    if (r.isOk) return true;

    return false;
  }

  Future removeUser(String phoneNumber) async {
    final state = this.state;
    if (state is! GroupStateReady) return;
    if (state.busy) return;
    emit(state.copyWith(busy: true));

    final channel = _client.getChatChannel(_chatId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return;
    final r = await channel.push('chat:remove_group_member', {'member_id': phoneNumber}).future;
    emit(state.copyWith(busy: false));
    if (r.isOk) return true;

    return false;
  }

  Future setModerator(String userId, bool isModerator) async {
    final state = this.state;
    if (state is! GroupStateReady) return;
    if (state.busy) return;
    emit(state.copyWith(busy: true));

    final channel = _client.getChatChannel(_chatId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return;
    final r = await channel.push('chat:set_group_moderator', {'member_id': userId, 'is_moderator': isModerator}).future;
    emit(state.copyWith(busy: false));
    if (r.isOk) return true;

    return false;
  }

  Future setName(String name) async {
    final state = this.state;
    if (state is! GroupStateReady) return;
    if (state.busy) return;
    emit(state.copyWith(busy: true));

    final channel = _client.getChatChannel(_chatId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return;
    final r = await channel.push('chat:set_group_name', {'name': name}).future;
    emit(state.copyWith(busy: false));
    if (r.isOk) return true;

    return false;
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
      List<ChatMessage> messages = [];

      // Fetch history from local storage
      // Exclude reply,forward cache and other messages that are not in sync
      final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(_chatId, MessageSyncCursorType.oldest);
      messages = await _chatsRepository.getMessageHistory(_chatId, from: topMessage.createdAt, to: oldestCursor?.time);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final channel = _client.getChatChannel(_chatId);
      if (messages.isEmpty && channel != null) {
        final payload = {'created_before': topMessage.createdAt.toUtc().toIso8601String(), 'limit': 100};
        final req = await channel.push('message:history', payload).future;
        messages = (req.response['data'] as List).map((e) => ChatMessage.fromMap(e)).toList();
        _logger.info('fetchHistory: remote messages ${messages.length}');
        if (messages.isNotEmpty) {
          await _chatsRepository.insertHistoryPage(messages);
          await _chatsRepository.upsertChatMessageSyncCursor(ChatMessageSyncCursor(
            chatId: _chatId,
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
    _logger.info('Preparing group $_chatId');

    try {
      final chat = await _chatsRepository.getChat(_chatId);
      _logger.info('init chat: $chat');

      final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(_chatId, MessageSyncCursorType.oldest);
      final messages = await _chatsRepository.getMessageHistory(_chatId, to: oldestCursor?.time);
      _logger.info('init msg\'s: ${messages.length}');

      if (isClosed) return;
      emit(GroupState.ready(_chatId, chat, messages: messages));

      _chatSub = _chatUpdateSubFactory(_handleChatUpdate);
      _messagesSub = _messagesSubFactory(_handleMessageUpdate);
      _outboxMessagesSub = _outboxMessagesSubFactory(_handleOutboxMessagesUpdate);
      _outboxMessageEditsSub = _outboxMessageEditsSubFactory(_handleOutboxMessageEditsUpdate);
      _outboxMessageDeletesSub = _outboxMessageDeletesSubFactory(_handleOutboxMessageDeletesUpdate);
    } catch (e) {
      emit(GroupState.error(_chatId, e));
    }
  }

  StreamSubscription _chatUpdateSubFactory(void Function(Chat) onArrive) {
    return _chatsRepository.eventBus.whereType<ChatUpdate>().listen((event) {
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
    return _chatsRepository.eventBus.whereType<ChatMessageUpdate>().listen((event) {
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

  StreamSubscription _outboxMessagesSubFactory(void Function(List<ChatOutboxMessageEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessages().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessagesUpdate(List<ChatOutboxMessageEntry> entries) {
    _logger.info('_handleOutboxMessagesUpdate: ${entries.length}');
    final state = this.state;
    if (state is GroupStateReady) emit(state.copyWith(outboxMessages: entries));
  }

  StreamSubscription _outboxMessageEditsSubFactory(void Function(List<ChatOutboxMessageEditEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessageEdits().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageEditsUpdate(List<ChatOutboxMessageEditEntry> entries) {
    _logger.info('handleOutboxMessageEditsUpdate: ${entries.length}');
    final state = this.state;
    if (state is GroupStateReady) emit(state.copyWith(outboxMessageEdits: entries));
  }

  StreamSubscription _outboxMessageDeletesSubFactory(void Function(List<ChatOutboxMessageDeleteEntry>) onArrive) {
    return _outboxRepository.watchChatOutboxMessageDeletes().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == _chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageDeletesUpdate(List<ChatOutboxMessageDeleteEntry> entries) {
    _logger.info('handleOutboxMessageDeletesUpdate: ${entries.length}');
    final state = this.state;
    if (state is GroupStateReady) emit(state.copyWith(outboxMessageDeletes: entries));
  }

  @override
  Future<void> close() {
    _logger.info('Closing group $_chatId');
    _cancelSubs();
    return super.close();
  }

  void _cancelSubs() {
    _chatSub?.cancel();
    _messagesSub?.cancel();
    _outboxMessagesSub?.cancel();
    _outboxMessageEditsSub?.cancel();
    _outboxMessageDeletesSub?.cancel();
  }
}
