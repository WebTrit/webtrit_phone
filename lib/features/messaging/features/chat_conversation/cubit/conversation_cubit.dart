import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:uuid/uuid.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'conversation_state.dart';

final _logger = Logger('ConversationCubit');

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit(
    ChatCredentials credentials,
    this._client,
    this._chatsRepository,
    this._outboxRepository,
  ) : super(ConversationState.init(credentials));

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;

  StreamSubscription? _chatUpdateSub;
  StreamSubscription? _chatRemoveSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxMessagesSub;
  StreamSubscription? _outboxMessageEditsSub;
  StreamSubscription? _outboxMessageDeletesSub;
  StreamSubscription? _readCursorsSub;

  Future sendMessage(String content) async {
    final (:chatId, :participantId) = state.credentials;

    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: chatId,
      participantId: participantId,
      content: content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendReply(String content, ChatMessage refMessage) async {
    final (:chatId, :participantId) = state.credentials;

    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: chatId,
      participantId: participantId,
      replyToId: refMessage.id,
      content: content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendForward(ChatMessage refMessage) async {
    final (:chatId, :participantId) = state.credentials;

    final outboxEntry = ChatOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      chatId: chatId,
      participantId: participantId,
      forwardFromId: refMessage.chatId,
      authorId: refMessage.senderId,
      content: refMessage.content,
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future sendEdit(String content, ChatMessage refMessage) async {
    final (:chatId, :participantId) = state.credentials;
    if (chatId == null) return;

    final outboxEntry = ChatOutboxMessageEditEntry(
      id: refMessage.id,
      idKey: refMessage.idKey,
      chatId: chatId,
      newContent: content,
    );
    _outboxRepository.upsertOutboxMessageEdit(outboxEntry);
  }

  Future deleteMessage(ChatMessage message) async {
    final (:chatId, :participantId) = state.credentials;
    if (chatId == null) return;

    final outboxEntry = ChatOutboxMessageDeleteEntry(
      id: message.id,
      idKey: message.idKey,
      chatId: chatId,
    );
    _outboxRepository.upsertOutboxMessageDelete(outboxEntry);
  }

  Future userReadedUntilUpdate(DateTime time) async {
    final (:chatId, :participantId) = state.credentials;
    if (chatId == null) return;

    final outboxEntry = ChatOutboxReadCursorEntry(
      chatId: chatId,
      time: time,
    );
    _outboxRepository.upsertOutboxReadCursor(outboxEntry);
  }

  Future deleteChat() async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.deleteChatConversation();
      emit(ConversationState.left(state.credentials));
    } catch (e, s) {
      _logger.warning('deleteChat failed', e, s);
      emit(state.copyWith(busy: false));
    }
  }

  Future leaveGroup() async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.leaveGroup();
      emit(ConversationState.left(state.credentials));
    } catch (e, s) {
      _logger.warning('leaveGroup failed', e, s);
      emit(state.copyWith(busy: false));
    }
  }

  Future addGroupMember(String userId) async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.addGroupMember(userId);
    } catch (e, s) {
      _logger.warning('addGroupMember failed', e, s);
    } finally {
      emit(state.copyWith(busy: false));
    }
  }

  Future removeGroupMember(String userId) async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.removeGroupMember(userId);
    } catch (e, s) {
      _logger.warning('removeGroupMember failed', e, s);
    } finally {
      emit(state.copyWith(busy: false));
    }
  }

  Future setGroupModerator(String userId, bool isModerator) async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.setGroupModerator(userId, isModerator);
    } catch (e, s) {
      _logger.warning('setGroupModerator failed', e, s);
    } finally {
      emit(state.copyWith(busy: false));
    }
  }

  Future setGroupName(String name) async {
    final state = this.state;
    if (state is! CVSReady) return;
    if (state.busy) return;

    final channel = _channel;
    if (channel == null) return;

    try {
      emit(state.copyWith(busy: true));
      await channel.setGroupName(name);
    } catch (e, s) {
      _logger.warning('setGroupName failed', e, s);
    } finally {
      emit(state.copyWith(busy: false));
    }
  }

  Future fetchHistory() async {
    final state = this.state;
    final chatId = state.credentials.chatId;

    if (state is! CVSReady) return;
    if (chatId == null) return;
    if (state.fetchingHistory || state.historyEndReached) return;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return;
    final topDate = topMessage.createdAt;

    emit(state.copyWith(fetchingHistory: true));

    _logger.info('fetchHistory: $chatId, ${topMessage.createdAt}');

    try {
      List<ChatMessage> messages = [];

      // Fetch history from local storage
      // Exclude reply,forward cache and other messages that are not in sync boundaries
      final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.oldest);
      final syncedTo = oldestCursor?.time;
      messages = await _chatsRepository.getMessageHistory(chatId, from: topDate, to: syncedTo);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final channel = _channel;
      if (messages.isEmpty && channel != null) {
        messages = await channel.chatMessagHistory(50, createdBefore: topDate);
        _logger.info('fetchHistory: remote messages ${messages.length}');

        if (messages.isNotEmpty) {
          await _chatsRepository.upsertMessages(messages, silent: true);
          final newSyncCursor = ChatMessageSyncCursor(
            chatId: chatId,
            cursorType: MessageSyncCursorType.oldest,
            time: messages.last.createdAt,
          );
          await _chatsRepository.upsertChatMessageSyncCursor(newSyncCursor);
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

  Future<void> restart() async {
    _cancelSubs();
    emit(ConversationState.init(state.credentials));
    await init();
  }

  Future<void> init() async {
    _logger.info('Preparing conversation for $state.credentials');

    try {
      var (:chatId, :participantId) = state.credentials;
      // If provided only participantId, find the dialog with user credentials
      if (participantId != null && chatId == null) chatId ??= await _chatsRepository.findDialogId(participantId);

      // Find local chat data if it exists
      final chat = chatId != null ? await _chatsRepository.getChat(chatId) : null;
      _logger.info('local chat find result: $chat');

      if (isClosed) return;
      emit(ConversationState.ready((chatId: chatId, participantId: participantId), chat: chat));

      // If chat is not exist, update subscribtion will find it when it will created
      // e.g when you send the first message or another user sends to you
      _chatUpdateSub = _chatUpdateSubFactory(_handleChatUpdate);
      // Subscribe to outbox messages updates even if chat is not exist
      // to see new outcoming messages in unexisted chat or in offline mode
      _outboxMessagesSub = _outboxMessagesSubFactory(_handleOutboxMessagesUpdate);

      // Init chat if it exists
      if (chat != null) await _initChat(chat.id);
    } catch (e) {
      emit(ConversationState.error(state.credentials, e));
    }
  }

  /// Second stage of the chat initialization. When chat is exist and ready to use.
  /// Fetches the chat messages, read cursors, binds to all updates, etc.
  Future<void> _initChat(int chatId) async {
    // Fetch last 100 messages from the chat history
    final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.oldest);
    final messages = await _chatsRepository.getMessageHistory(chatId, to: oldestCursor?.time);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(messages: messages));

    // Subscribe to chat messages updates eg new messages, edited, deleted, etc. and merge them with the current list
    _messagesSub = _messagesSubFactory(chatId, _handleMessageUpdate);

    // Subscribe to read cursors updates
    _readCursorsSub = _readCursorsSubFactory(chatId, _handleReadCursorsUpdate);

    // Subscribe to outbox message edits and deletes
    _outboxMessageEditsSub = _outboxMessageEditsSubFactory(chatId, _handleOutboxMessageEditsUpdate);
    _outboxMessageDeletesSub = _outboxMessageDeletesSubFactory(chatId, _handleOutboxMessageDeletesUpdate);

    // Subscribe to chat remove event
    _chatRemoveSub = _chatRemoveSubFactory(chatId, _handleChatRemove);
  }

  StreamSubscription _chatUpdateSubFactory(void Function(Chat) onArrive) {
    final (:chatId, :participantId) = state.credentials;

    return _chatsRepository.eventBus.whereType<ChatUpdate>().listen((event) {
      final chat = event.chat;

      final sameChat = chatId != null && chat.id == chatId;
      final desiredDialog = participantId != null && chat.isDialogWith(participantId);
      if (sameChat || desiredDialog) onArrive(chat);
    });
  }

  void _handleChatUpdate(Chat chat) {
    _logger.info('_handleChatUpdate: $chat');

    final state = this.state;
    if (state is! CVSReady) return;

    final (:chatId, :participantId) = state.credentials;
    final chatWasntExistBefore = state.chat == null;

    emit(state.copyWith(credentials: (chatId: chat.id, participantId: participantId), chat: chat));

    // Init second stage of the chat initialization if chat was newly created
    if (chatWasntExistBefore) _initChat(chat.id);
  }

  StreamSubscription _chatRemoveSubFactory(int chatId, void Function(int, ChatRemove) onArrive) {
    return _chatsRepository.eventBus.whereType<ChatRemove>().listen((event) => onArrive(chatId, event));
  }

  void _handleChatRemove(int chatId, ChatRemove event) {
    _logger.info('_handleChatRemove: $chatId');
    if (event.chatId == chatId) emit(ConversationState.left(state.credentials));
  }

  StreamSubscription _messagesSubFactory(int chatId, void Function(ChatMessage) onArrive) {
    return _chatsRepository.eventBus.whereType<ChatMessageUpdate>().listen((event) {
      final message = event.message;
      if (message.chatId == chatId) onArrive(message);
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
    final (:chatId, :participantId) = state.credentials;
    return _outboxRepository.watchChatOutboxMessages().listen((entries) {
      final chatQueueEntries = entries.where((e) {
        final sameChat = chatId != null && chatId == e.chatId;
        final desiredParticipant = participantId != null && e.participantId == participantId;
        return (sameChat || desiredParticipant);
      }).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessagesUpdate(List<ChatOutboxMessageEntry> entries) {
    _logger.info('_handleOutboxMessagesUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessages: entries));
  }

  StreamSubscription _outboxMessageEditsSubFactory(
    int chatId,
    void Function(List<ChatOutboxMessageEditEntry>) onArrive,
  ) {
    return _outboxRepository.watchChatOutboxMessageEdits().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageEditsUpdate(List<ChatOutboxMessageEditEntry> entries) {
    _logger.info('_handleOutboxMessageEditsUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessageEdits: entries));
  }

  StreamSubscription _outboxMessageDeletesSubFactory(
    int chatId,
    void Function(List<ChatOutboxMessageDeleteEntry>) onArrive,
  ) {
    return _outboxRepository.watchChatOutboxMessageDeletes().listen((entries) {
      final chatQueueEntries = entries.where((e) => e.chatId == chatId).toList();
      onArrive(chatQueueEntries);
    });
  }

  void _handleOutboxMessageDeletesUpdate(List<ChatOutboxMessageDeleteEntry> entries) {
    _logger.info('_handleOutboxMessageDeletesUpdate: ${entries.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(outboxMessageDeletes: entries));
  }

  StreamSubscription _readCursorsSubFactory(int chatId, void Function(List<ChatMessageReadCursor>) onArrive) {
    return _chatsRepository.watchChatMessageReadCursors(chatId).listen(onArrive);
  }

  void _handleReadCursorsUpdate(List<ChatMessageReadCursor> cursors) {
    _logger.info('_handleReadCursorsUpdate: ${cursors.length}');
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(readCursors: cursors));
  }

  PhoenixChannel? get _channel {
    final state = this.state;
    final chatId = state.credentials.chatId;
    if (chatId != null) {
      final channel = _client.getChatChannel(chatId);
      if (channel != null && channel.state == PhoenixChannelState.joined) return channel;
    }

    return null;
  }

  @override
  Future<void> close() {
    _logger.info('Closing conversation ${state.credentials}');
    _cancelSubs();
    return super.close();
  }

  void _cancelSubs() {
    _chatUpdateSub?.cancel();
    _chatRemoveSub?.cancel();
    _messagesSub?.cancel();
    _outboxMessagesSub?.cancel();
    _outboxMessageEditsSub?.cancel();
    _outboxMessageDeletesSub?.cancel();
    _readCursorsSub?.cancel();
  }
}
