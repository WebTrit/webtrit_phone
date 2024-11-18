import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:uuid/uuid.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
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
    this._submitNotification,
  ) : super(ConversationState.init(credentials));

  final PhoenixSocket _client;
  final ChatsRepository _chatsRepository;
  final ChatsOutboxRepository _outboxRepository;
  final Function(Notification) _submitNotification;

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
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.deleteChatConversation();
      emit(ConversationState.left(state.credentials));
    } catch (e, s) {
      _logger.warning('deleteChat failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
      _releaseBusy();
    }
  }

  Future leaveGroup() async {
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.leaveGroup();
      emit(ConversationState.left(state.credentials));
    } catch (e, s) {
      _logger.warning('leaveGroup failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
      _releaseBusy();
    }
  }

  Future addGroupMember(String userId) async {
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.addGroupMember(userId);
    } catch (e, s) {
      _logger.warning('addGroupMember failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
    } finally {
      _releaseBusy();
    }
  }

  Future removeGroupMember(String userId) async {
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.removeGroupMember(userId);
    } catch (e, s) {
      _logger.warning('removeGroupMember failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
    } finally {
      _releaseBusy();
    }
  }

  Future setGroupModerator(String userId, bool isModerator) async {
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.setGroupModerator(userId, isModerator);
    } catch (e, s) {
      _logger.warning('setGroupModerator failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
    } finally {
      _releaseBusy();
    }
  }

  Future setGroupName(String name) async {
    final channel = _getChannel();
    if (channel == null) return;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.setGroupName(name);
    } catch (e, s) {
      _logger.warning('setGroupName failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
    } finally {
      _releaseBusy();
    }
  }

  Future fetchHistory() async {
    final hLock = _acquireHistoryFetching();
    if (hLock == null) return;
    final (topDate, chatId) = hLock;

    _logger.info('fetchHistory: $chatId, $topDate');

    try {
      List<ChatMessage> newMessages = [];

      // Fetch history from local storage
      // Exclude reply,forward cache and other messages that are not in sync boundaries
      final oldestCursor = await _chatsRepository.getChatMessageSyncCursor(chatId, MessageSyncCursorType.oldest);
      final syncedTo = oldestCursor?.time;
      newMessages = await _chatsRepository.getMessageHistory(chatId, from: topDate, to: syncedTo);
      _logger.info('fetchHistory: local messages ${newMessages.length}');

      // If no messages found in local storage, fetch from the remote server
      final channel = _getChannel();
      if (newMessages.isEmpty && channel != null) {
        newMessages = await channel.chatMessagHistory(50, createdBefore: topDate);
        _logger.info('fetchHistory: remote messages ${newMessages.length}');

        if (newMessages.isNotEmpty) {
          await _chatsRepository.upsertMessages(newMessages, silent: true);
          final newSyncCursor = ChatMessageSyncCursor(
            chatId: chatId,
            cursorType: MessageSyncCursorType.oldest,
            time: newMessages.last.createdAt,
          );
          await _chatsRepository.upsertChatMessageSyncCursor(newSyncCursor);
        }
      }

      if (isClosed) return;
      _releaseHistoryFetching(endReached: newMessages.isEmpty, newMessages: newMessages);
    } on Exception catch (e, s) {
      _releaseHistoryFetching();
      _logger.warning('fetchHistory failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
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

  /// Try get the chat channel if it's connected and ready to use
  PhoenixChannel? _getChannel() {
    final state = this.state;
    final chatId = state.credentials.chatId;
    if (chatId != null) {
      final channel = _client.getChatChannel(chatId);
      if (channel != null && channel.state == PhoenixChannelState.joined) return channel;
    }

    return null;
  }

  /// Acquire busy lock state if it's not busy yet
  /// Returns true if busy state was acquired, false otherwise
  /// The lock state will be released by [_releaseBusy]
  bool _acquireBusy() {
    final state = this.state;
    if (state is! CVSReady) return false;
    emit(state.copyWith(busy: true));
    return true;
  }

  /// Release busy lock state
  void _releaseBusy() {
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(busy: false));
  }

  /// Acquire fetching history lock state if it's not fetching yet
  /// Returns the data needed to fetch history if it's able to fetch, null otherwise
  /// The lock state will be released by [_releaseHistoryFetching]
  (DateTime, int)? _acquireHistoryFetching() {
    final state = this.state;
    if (state is! CVSReady || state.fetchingHistory) return null;

    final chatId = state.credentials.chatId;
    if (chatId == null) return null;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return null;

    emit(state.copyWith(fetchingHistory: true));
    return (topMessage.createdAt, chatId);
  }

  /// Release fetching history lock state and update the state with new messages if any
  void _releaseHistoryFetching({bool endReached = false, List<ChatMessage> newMessages = const []}) {
    final state = this.state;
    if (state is CVSReady) {
      final messages = [...state.messages, ...newMessages];
      emit(state.copyWith(fetchingHistory: false, historyEndReached: endReached, messages: messages));
    }
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
