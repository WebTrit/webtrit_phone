import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'conversation_state.dart';

final _logger = Logger('SmsConversationCubit');

class SmsConversationCubit extends Cubit<ConversationState> {
  SmsConversationCubit(
    this._creds,
    this._client,
    this._repository,
    this._outboxRepository,
  ) : super(ConversationState.init(_creds)) {
    _init();
    // _logger.onRecord.listen((record) {
    //   // ignore: avoid_print
    //   print('\x1B[33mcht: ${record.message}\x1B[0m');
    // });
  }

  // final String _firstNumber;
  // final String _secondNumber;

  // /// Should be removed as soon as possible when backend will be ready
  // final String? _recipientId;

  final UsersCreds _creds;

  final PhoenixSocket _client;
  final SmsRepository _repository;
  final SmsOutboxRepository _outboxRepository;

  StreamSubscription? _chatUpdateSub;
  StreamSubscription? _chatRemoveSub;
  StreamSubscription? _messagesSub;
  StreamSubscription? _outboxMessagesSub;

  void restart() {
    _logger.info('Restarting sms conversation with $_creds');
    _cancelSubs();
    emit(ConversationState.init(_creds));
    _init();
  }

  Future sendMessage(String content) async {
    // final outboxEntry = SmsOutboxMessageEntry(
    //     // fromPhoneNumber: fromPhoneNumber,
    //     // toPhoneNumber: toPhoneNumber,
    //     // content: content,
    //     );
    // _outboxRepository.upsertOutboxMessage(outboxEntry);
  }

  Future<bool> deleteDialog() async {
    // final state = this.state;

    // if (_chat == null) return false;

    // if (state is! CVSReady) return false;
    // if (state.busy) return false;
    // emit(state.copyWith(busy: true));

    // final channel = _client.getChatChannel(_chat!.id);
    // if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    // final r = await channel.push('chat:delete', {}).future;

    // emit(state.copyWith(busy: false));
    // if (r.isOk) return true;
    return false;
  }

  Future fetchHistory() async {
    final state = this.state;
    if (state is! CVSReady) return;

    if (state.fetchingHistory || state.historyEndReached) return;

    final conversationId = state.conversation?.id;
    if (conversationId == null) return;

    final topMessage = state.messages.lastOrNull;
    if (topMessage == null) return;
    final topDate = topMessage.createdAt;

    emit(state.copyWith(fetchingHistory: true));

    _logger.info('fetchHistory: $conversationId, ${topMessage.createdAt}');

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
        final payload = {'created_before': topDate.toUtc().toIso8601String(), 'limit': 50};
        final req = await channel.push('sms:message:history', payload).future;
        messages = (req.response['data'] as List).map((e) => SmsMessage.fromMap(e)).toList();
        _logger.info('fetchHistory: remote messages ${messages.length}');
        if (messages.isNotEmpty) {
          await _repository.insertHistoryPage(messages);
          await _repository.upsertSmsMessageSyncCursor(SmsMessageSyncCursor(
            conversationId: conversationId,
            cursorType: SmsSyncCursorType.oldest,
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
    _logger.info('Preparing sms conversation with $_creds');

    try {
      final c = await _repository.findConversationBetweenNumbers(_creds.firstNumber, _creds.secondNumber);
      _logger.info('local chat find result: $c');

      if (isClosed) return;
      emit(ConversationState.ready(_creds, conversation: c));

      // If local conversation is not found, subscribtion will find the conversation when it will created
      // e.g when you send the first message or another user sends to you
      _chatUpdateSub = _conversationUpdateSubFactory(_handleConversationUpdate);
      _chatRemoveSub = _conversationRemoveSubFactory(_handleConversationRemove);
      _outboxMessagesSub = _outboxMessagesSubFactory(_handleOutboxMessagesUpdate);

      // if (c != null) _conversation = c;
      if (c != null) await _initMessages(c.id);
    } catch (e) {
      emit(ConversationState.error(_creds, e));
    }
  }

  Future<void> _initMessages(int conversationId) async {
    // Fetch last 100 messages from the chat history
    final oldestCursor = await _repository.getMessageSyncCursor(conversationId, SmsSyncCursorType.oldest);
    final messages = await _repository.getMessageHistory(conversationId, to: oldestCursor?.time);
    _logger.info('_initMessages: ${messages.length}');

    if (isClosed) return;
    final state = this.state;
    if (state is CVSReady) emit(state.copyWith(messages: messages));

    // Subscribe to chat messages updates eg new messages, edited, deleted, etc. and merge them with the current list
    _messagesSub?.cancel();
    _messagesSub = _messagesSubFactory((msg) => _handleMessageUpdate(conversationId, msg));
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
    if (state is! CVSReady) return;
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
    if (state is! CVSReady) return;
    if (state.conversation?.id == conversationId) emit(ConversationState.left(_creds));
  }

  StreamSubscription _messagesSubFactory(void Function(SmsMessage) onArrive) {
    return _repository.eventBus.whereType<SmsMessageUpdate>().listen((event) {
      onArrive(event.message);
    });
  }

  void _handleMessageUpdate(int conversationId, SmsMessage message) {
    _logger.info('_handleMessageUpdate: $message');
    final state = this.state;
    if (state is! CVSReady) return;
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
    if (state is! CVSReady) return;
    final conversationEntries = entries
        .where((e) =>
            (e.fromPhoneNumber == _creds.firstNumber && e.toPhoneNumber == _creds.secondNumber) ||
            (e.fromPhoneNumber == _creds.secondNumber && e.toPhoneNumber == _creds.firstNumber))
        .toList();
    emit(state.copyWith(outboxMessages: conversationEntries));
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
  }
}
