import 'dart:async';

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
    this._repository,
  ) : super(SmsConversationsState.initial()) {
    init();
  }

  final PhoenixSocket _client;
  final SmsRepository _repository;
  late final StreamSubscription _conversationsSub;

  void init() async {
    _logger.info('Initialising');

    final conversations = await _repository.getConversationsWithLastMessages();
    conversations.sort(_comparator);

    emit(SmsConversationsState(conversations, false));
    _logger.info('Initialised: ${conversations.length} conversations');

    _conversationsSub = _repository.eventBus.listen((event) {
      if (event is SmsConversationUpdate) {
        emit(state.copyWith(conversations: _mergeWithChatUpdate(event.conversation)));
      }
      if (event is SmsConversationRemove) {
        emit(state.copyWith(conversations: _removeChat(event.conversationId)));
      }
      if (event is SmsMessageUpdate) {
        emit(state.copyWith(conversations: _mergeWithMessageUpdate(event.message)));
      }
    });
  }

  Future<bool> deleteConversation(int id) async {
    final channel = _client.getSmsConversationChannel(id);
    if (channel == null || channel.state != PhoenixChannelState.joined) return false;
    return channel.deleteSmsConversation();
  }

  /// Sort conversations list by last message if available, otherwise by conversations update time
  int _comparator((SmsConversation, SmsMessage?) a, (SmsConversation, SmsMessage?) b) {
    final aLastActivity = a.$2?.createdAt ?? a.$1.updatedAt;
    final bLastActivity = b.$2?.createdAt ?? b.$1.updatedAt;
    return bLastActivity.compareTo(aLastActivity);
  }

  List<(SmsConversation, SmsMessage?)> _mergeWithChatUpdate(SmsConversation conversation) {
    List<(SmsConversation, SmsMessage?)> newList;
    final index = state.conversations.indexWhere((e) => e.$1.id == conversation.id);
    if (index == -1) {
      newList = state.conversations + [(conversation, null)];
    } else {
      newList = List.of(state.conversations);
      newList[index] = (conversation, newList[index].$2);
    }
    newList.sort(_comparator);
    return newList;
  }

  List<(SmsConversation, SmsMessage?)> _mergeWithMessageUpdate(SmsMessage message) {
    final index = state.conversations.indexWhere((e) => e.$1.id == message.conversationId);
    final oldMessage = state.conversations[index].$2;
    final isOldMessageNewer = oldMessage != null && oldMessage.createdAt.isAfter(message.createdAt);

    if (index != -1 && !isOldMessageNewer) {
      final newList = List.of(state.conversations);
      newList[index] = (newList[index].$1, message);
      return newList;
    }

    return state.conversations;
  }

  List<(SmsConversation, SmsMessage?)> _removeChat(int id) {
    return state.conversations.where((e) => e.$1.id != id).toList();
  }

  @override
  Future<void> close() {
    _conversationsSub.cancel();
    return super.close();
  }
}
