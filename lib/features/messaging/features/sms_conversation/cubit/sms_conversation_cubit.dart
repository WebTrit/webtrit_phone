import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:uuid/uuid.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'sms_conversation_state.dart';

final _logger = Logger('SmsConversationCubit');

class SmsConversationCubit extends Cubit<SmsConversationState> {
  SmsConversationCubit(
    this._creds,
    this._client,
    this._repository,
    this._outboxRepository,
    this._submitNotification,
  ) : super(SmsConversationState.init(_creds)) {
    _init();
  }

  final UsersCreds _creds;

  final PhoenixSocket _client;
  final SmsRepository _repository;
  final SmsOutboxRepository _outboxRepository;
  final Function(Notification) _submitNotification;

  StreamSubscription? _chatUpdateSub;
  StreamSubscription? _chatRemoveSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxMessagesSub;
  StreamSubscription? _outboxMessageDeletesSub;
  StreamSubscription? _readCursorsSub;

  void restart() {
    _logger.info('Restarting sms conversation with $_creds');
    _cancelSubs();
    emit(SmsConversationState.init(_creds));
    _init();
  }

  Future sendMessage(String content, List<String> attachments) async {
    final userNumbers = await _repository.getUserSmsNumbers();
    final userNumber = userNumbers.firstWhereOrNull((e) => e == _creds.firstNumber || e == _creds.secondNumber);
    if (userNumber == null) return;
    final recipientNumber = _creds.firstNumber == userNumber ? _creds.secondNumber : _creds.firstNumber;

    final outAttachments = attachments.map((p) => OutboxAttachment(id: (const Uuid()).v4(), pickedPath: p));

    final outboxEntry = SmsOutboxMessageEntry(
      idKey: (const Uuid()).v4(),
      fromPhoneNumber: userNumber,
      toPhoneNumber: recipientNumber,
      recepientId: _creds.recipientId,
      content: content,
      attachments: outAttachments.toList(),
    );
    _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future deleteMessage(SmsMessage message) async {
    final state = this.state;
    if (state is! SCSReady || state.busy) return false;

    final conversationId = state.conversation?.id;
    if (conversationId == null) return false;

    final outboxEntry = SmsOutboxMessageDeleteEntry(
      id: message.id,
      idKey: message.idKey,
      conversationId: conversationId,
    );
    _outboxRepository.upsertOutboxMessageDelete(outboxEntry);
  }

  Future userReadedUntilUpdate(DateTime time) async {
    final state = this.state;
    if (state is! SCSReady || state.busy) return false;

    final conversationId = state.conversation?.id;
    if (conversationId == null) return false;

    final outboxEntry = SmsOutboxReadCursorEntry(
      conversationId: conversationId,
      time: time,
    );
    _outboxRepository.upsertOutboxReadCursor(outboxEntry);
  }

  Future deleteConversation() async {
    final state = this.state;
    if (state is! SCSReady || state.busy) return false;

    final conversationId = state.conversation?.id;
    if (conversationId == null) return false;

    final channel = _client.getSmsConversationChannel(conversationId);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;

    final busy = _acquireBusy();
    if (busy == false) return;

    try {
      await channel.deleteSmsConversation();
      emit(SmsConversationState.left(_creds));
    } catch (e, s) {
      _logger.warning('deleteConversation failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
      _releaseBusy();
    }
  }

  Future fetchHistory() async {
    final hLock = _acquireHistoryFetching();
    if (hLock == null) return;
    final (topDate, conversationId) = hLock;

    _logger.info('fetchHistory: $conversationId, $topDate');

    try {
      List<SmsMessage> messages = [];

      // Fetch history from local storage
      // Exclude reply,forward cache and other messages that are not in sync boundaries
      final oldestCursor = await _repository.getMessageSyncCursor(conversationId, SmsSyncCursorType.oldest);
      final syncedTo = oldestCursor?.time;
      messages = await _repository.getMessageHistory(conversationId, from: topDate, to: syncedTo);
      _logger.info('fetchHistory: local messages ${messages.length}');

      // If no messages found in local storage, fetch from the remote server
      final channel = _client.getSmsConversationChannel(conversationId);
      if (messages.isEmpty && channel != null) {
        messages = await channel.smsMessageHistory(50, createdBefore: topDate);
        _logger.info('fetchHistory: remote messages ${messages.length}');
        if (messages.isNotEmpty) {
          await _repository.upsertMessages(messages, silent: true);
          await _repository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
            conversationId: conversationId,
            cursorType: SmsSyncCursorType.oldest,
            time: messages.last.createdAt,
          ));
        }
      }

      if (isClosed) return;
      _releaseHistoryFetching(endReached: messages.isEmpty, newMessages: messages);
    } on Exception catch (e, s) {
      _releaseHistoryFetching();
      _logger.warning('fetchHistory failed', e, s);
      _submitNotification(DefaultErrorNotification(e));
    }
  }

  Future<void> _init() async {
    _logger.info('Preparing sms conversation with $_creds');

    try {
      final c = await _repository.findConversationBetweenNumbers(_creds.firstNumber, _creds.secondNumber);
      _logger.info('local chat find result: $c');

      if (isClosed) return;
      emit(SmsConversationState.ready(_creds, conversation: c));

      // If local conversation is not found, subscribtion will find the conversation when it will created
      // e.g when you send the first message or another user sends to you
      _chatUpdateSub = _conversationUpdateSubFactory(_handleConversationUpdate);
      _chatRemoveSub = _conversationRemoveSubFactory(_handleConversationRemove);
      _outboxMessagesSub = _outboxMessagesSubFactory(_handleOutboxMessagesUpdate);

      if (c != null) await _initMessages(c.id);
    } catch (e) {
      emit(SmsConversationState.error(_creds, e));
    }
  }

  Future<void> _initMessages(int conversationId) async {
    // Fetch last 100 messages from the chat history
    final oldestCursor = await _repository.getMessageSyncCursor(conversationId, SmsSyncCursorType.oldest);
    final messages = await _repository.getMessageHistory(conversationId, to: oldestCursor?.time);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    final state = this.state;
    if (state is SCSReady) emit(state.copyWith(messages: messages));

    // Subscribe to chat messages updates eg new messages, edited, deleted, etc. and merge them with the current list
    _messagesSub?.cancel();
    _messagesSub = _messagesSubFactory((msg) => _handleMessageUpdate(conversationId, msg));

    // Subscribe to read cursors updates
    _readCursorsSub?.cancel();
    _readCursorsSub = _readCursorsSubFactory(conversationId, _handleReadCursorsUpdate);

    // Subscribe to outbox messages updates
    _outboxMessageDeletesSub =
        _outboxMessageDeletesSubFactory((entries) => _handleOutboxMessageDeletesUpdate(conversationId, entries));

    // _fillHistory();
  }

  StreamSubscription _conversationUpdateSubFactory(void Function(SmsConversation) onArrive) {
    return _repository.eventBus.whereType<SmsConversationUpdate>().listen((event) {
      final conversation = event.conversation;
      final desiredChat = conversation.isConversationBetween(_creds.firstNumber, _creds.secondNumber);
      if (desiredChat) onArrive(conversation);
    });
  }

  void _handleConversationUpdate(SmsConversation conversation) {
    _logger.info('_handleConversationUpdate: $conversation');
    final state = this.state;
    if (state is! SCSReady) return;
    final chatWasntExistBefore = state.conversation == null;

    emit(state.copyWith(conversation: conversation));

    // Init messages after chat is created for conversation with the participant
    if (chatWasntExistBefore) _initMessages(conversation.id);
  }

  StreamSubscription _conversationRemoveSubFactory(void Function(int) onArrive) {
    return _repository.eventBus.whereType<SmsConversationRemove>().listen((event) {
      onArrive(event.conversationId);
    });
  }

  void _handleConversationRemove(int conversationId) {
    _logger.info('_handleConversationRemove: $conversationId');
    final state = this.state;
    if (state is! SCSReady) return;
    if (state.conversation?.id == conversationId) emit(SmsConversationState.left(_creds));
  }

  StreamSubscription _messagesSubFactory(void Function(SmsMessage) onArrive) {
    return _repository.eventBus.whereType<SmsMessageUpdate>().listen((event) {
      onArrive(event.message);
    });
  }

  void _handleMessageUpdate(int conversationId, SmsMessage message) {
    _logger.info('_handleMessageUpdate: $message');
    final state = this.state;
    if (state is! SCSReady) return;
    if (message.conversationId != conversationId) return;
    final updatedMessages = state.messages.mergeUpdateWith(message);
    emit(state.copyWith(messages: updatedMessages));
  }

  StreamSubscription _outboxMessagesSubFactory(void Function(List<SmsOutboxMessageEntry>) onArrive) {
    return _outboxRepository.watchOutboxMessages().listen((entries) {
      onArrive(entries);
    });
  }

  void _handleOutboxMessagesUpdate(List<SmsOutboxMessageEntry> entries) {
    _logger.info('_handleOutboxMessagesUpdate: ${entries.length}');
    final state = this.state;
    if (state is! SCSReady) return;
    final conversationEntries = entries
        .where((e) =>
            (e.fromPhoneNumber == _creds.firstNumber && e.toPhoneNumber == _creds.secondNumber) ||
            (e.fromPhoneNumber == _creds.secondNumber && e.toPhoneNumber == _creds.firstNumber))
        .toList();
    emit(state.copyWith(outboxMessages: conversationEntries));
  }

  StreamSubscription _outboxMessageDeletesSubFactory(void Function(List<SmsOutboxMessageDeleteEntry>) onArrive) {
    return _outboxRepository.watchOutboxMessageDeletes().listen((entries) => onArrive(entries));
  }

  void _handleOutboxMessageDeletesUpdate(int conversationId, List<SmsOutboxMessageDeleteEntry> entries) {
    _logger.info('_handleOutboxMessageDeletesUpdate: ${entries.length}');
    final state = this.state;
    if (state is! SCSReady) return;
    final conversationEntries = entries.where((e) => e.conversationId == conversationId).toList();
    emit(state.copyWith(outboxMessageDeletes: conversationEntries));
  }

  StreamSubscription _readCursorsSubFactory(int conversationId, void Function(List<SmsMessageReadCursor>) onArrive) {
    return _repository.watchMessageReadCursors(conversationId).listen(onArrive);
  }

  void _handleReadCursorsUpdate(List<SmsMessageReadCursor> cursors) {
    _logger.info('_handleReadCursorsUpdate: ${cursors.length}');
    final state = this.state;
    if (state is SCSReady) emit(state.copyWith(readCursors: cursors));
  }

  /// Acquire busy lock state if it's not busy yet
  /// Returns true if busy state was acquired, false otherwise
  /// The lock state will be released by [_releaseBusy]
  bool _acquireBusy() {
    final state = this.state;
    if (state is! SCSReady) return false;
    emit(state.copyWith(busy: true));
    return true;
  }

  /// Release busy lock state
  void _releaseBusy() {
    final state = this.state;
    if (state is SCSReady) emit(state.copyWith(busy: false));
  }

  /// Acquire fetching history lock state if it's not fetching yet
  /// Returns the data needed to fetch history if it's able to fetch, null otherwise
  /// The lock state will be released by [_releaseHistoryFetching]
  (DateTime, int)? _acquireHistoryFetching() {
    final state = this.state;
    if (state is! SCSReady || state.fetchingHistory) return null;

    final conversationId = state.conversation?.id;
    if (conversationId == null) return null;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return null;

    emit(state.copyWith(fetchingHistory: true));
    return (topMessage.createdAt, conversationId);
  }

  /// Release fetching history lock state and update the state with new messages if any
  void _releaseHistoryFetching({bool endReached = false, List<SmsMessage> newMessages = const []}) {
    final state = this.state;
    if (state is SCSReady) {
      final messages = [...state.messages, ...newMessages];
      emit(state.copyWith(fetchingHistory: false, historyEndReached: endReached, messages: messages));
    }
  }

  // reserved for testing purposes
  // ignore: unused_element
  Future<void> _fillHistory({int index = 0}) async {
    if (isClosed) return;
    await sendMessage('Hello, I am a bot. I am here to help you. \n $index', []);
    if (index < 100) {
      await Future.delayed(const Duration(seconds: 2));
      await _fillHistory(index: index + 1);
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing sms conversation with $_creds');
    _cancelSubs();
    return super.close();
  }

  _cancelSubs() {
    _chatUpdateSub?.cancel();
    _chatRemoveSub?.cancel();
    _messagesSub?.cancel();
    _outboxMessagesSub?.cancel();
    _outboxMessageDeletesSub?.cancel();
    _readCursorsSub?.cancel();
  }
}
