import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';

part 'sms_conversations_state.dart';

final _logger = Logger('SmsConversationsCubit');

class SmsConversationsCubit extends Cubit<SmsConversationsState> {
  SmsConversationsCubit(
    this._client,
    this._repository, {
    Duration searchDebounceDuration = const Duration(milliseconds: 100),
  }) : _searchDebounceDuration = searchDebounceDuration,
       super(SmsConversationsState.initial());

  final PhoenixSocket _client;
  final SmsRepository _repository;
  final Duration _searchDebounceDuration;

  StreamSubscription? _conversationsSub;
  String _searchString = '';
  Timer? _searchDebounceTimer;

  void init() async {
    _conversationsSub?.cancel();
    _conversationsSub = _actionsStream
        .asyncMap((event) async {
          if (event is List<(SmsConversation, SmsMessage?)>) {
            final (raw, toShow) = await compute((data) {
              final (conversations, search) = data;
              final sorted = List<(SmsConversation, SmsMessage?)>.from(conversations);
              sorted.sort(_comparator);
              final filtered = _filterBySearch(search, sorted);
              return (sorted, filtered);
            }, (event, _searchString));

            return SmsConversationsState(raw, toShow, false);
          }
          if (event is SmsConversationUpdate) {
            final (raw, toShow) = await compute((data) {
              final (conversation, conversations, search) = data;
              final newList = _mergeWithChatUpdate(conversation, conversations);
              final filtered = _filterBySearch(search, newList);
              return (newList, filtered);
            }, (event.conversation, state.conversations, _searchString));

            return SmsConversationsState(raw, toShow, false);
          }
          if (event is SmsConversationRemove) {
            final (raw, toShow) = await compute((data) {
              final (conversationId, conversations, search) = data;
              final newList = _removeChat(conversationId, conversations);
              final filtered = _filterBySearch(search, newList);
              return (newList, filtered);
            }, (event.conversationId, state.conversations, _searchString));

            return SmsConversationsState(raw, toShow, false);
          }
          if (event is SmsMessageUpdate) {
            final (raw, toShow) = await compute((data) {
              final (message, conversations, search) = data;
              final newList = _mergeWithMessageUpdate(message, conversations);
              final filtered = _filterBySearch(search, newList);
              return (newList, filtered);
            }, (event.message, state.conversations, _searchString));

            return SmsConversationsState(raw, toShow, false);
          }
          _logger.info('list recomputed ${state.conversationsToShow.length} / ${state.conversations.length}');
        })
        .listen((newState) {
          if (!isClosed && newState != null) emit(newState);
        });
  }

  Future<void> updateSearch(String value) async {
    _searchString = value;
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounceDuration, () => _doUpdateSearch());
  }

  Future<bool> deleteConversation(int id) async {
    final channel = _client.getSmsConversationChannel(id);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    return channel.deleteSmsConversation();
  }

  Stream get _actionsStream async* {
    yield await _repository.getConversationsWithLastMessages();
    yield* _repository.eventBus;
  }

  Future<void> _doUpdateSearch() async {
    final conversationsToShow = await compute((data) {
      final (search, conversations) = data;
      return _filterBySearch(search, conversations);
    }, (_searchString, state.conversations));
    if (isClosed) return;
    emit(state.copyWith(conversationsToShow: conversationsToShow));
  }

  /// Sort conversations list by last message if available, otherwise by conversations update time
  static int _comparator((SmsConversation, SmsMessage?) a, (SmsConversation, SmsMessage?) b) {
    final aLastActivity = a.$2?.createdAt ?? a.$1.updatedAt;
    final bLastActivity = b.$2?.createdAt ?? b.$1.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  static List<(SmsConversation, SmsMessage?)> _mergeWithChatUpdate(
    SmsConversation conversation,
    List<(SmsConversation, SmsMessage?)> conversations,
  ) {
    List<(SmsConversation, SmsMessage?)> newList;
    final index = conversations.indexWhere((e) => e.$1.id == conversation.id);
    if (index == -1) {
      newList = conversations + [(conversation, null)];
    } else {
      newList = List.of(conversations);
      newList[index] = (conversation, newList[index].$2);
    }
    newList.sort(_comparator);
    return newList;
  }

  static List<(SmsConversation, SmsMessage?)> _mergeWithMessageUpdate(
    SmsMessage message,
    List<(SmsConversation, SmsMessage?)> conversations,
  ) {
    final index = conversations.indexWhere((e) => e.$1.id == message.conversationId);
    final oldMessage = conversations[index].$2;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(conversations);
      newList[index] = (newList[index].$1, message);
      return newList;
    }

    return conversations;
  }

  static List<(SmsConversation, SmsMessage?)> _removeChat(int id, List<(SmsConversation, SmsMessage?)> conversations) {
    return conversations.where((e) => e.$1.id != id).toList();
  }

  static List<(SmsConversation, SmsMessage?)> _filterBySearch(
    String search,
    List<(SmsConversation, SmsMessage?)> conversations,
  ) {
    if (search.isEmpty) return conversations;

    return conversations.where((e) {
      final (conversation, lastMessage) = e;
      final phones = conversation.firstPhoneNumber.toLowerCase() + conversation.secondPhoneNumber.toLowerCase();
      final lastMessageText = lastMessage?.content ?? '';

      return phones.contains(search) || lastMessageText.contains(search);
    }).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub?.cancel();
    return super.close();
  }
}
