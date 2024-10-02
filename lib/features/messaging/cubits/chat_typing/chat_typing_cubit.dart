import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('ChatTypingCubit');

class ChatTypingCubit extends Cubit<TypingState> {
  ChatTypingCubit(
    this.client,
    this.contactsRepo, {
    this.typeThrottle = const Duration(seconds: 3),
    this.typeTimeout = const Duration(seconds: 5),
  }) : super({});

  final PhoenixSocket client;
  final ContactsRepository contactsRepo;
  final Duration typeThrottle;
  final Duration typeTimeout;

  int? _chatId;
  StreamSubscription? _typingSub;
  final Map<String, Timer> _typingTimers = {};
  DateTime? _lastTypingSent;

  init(int chatId) {
    if (_chatId != chatId) {
      _chatId = chatId;
      _typingSub?.cancel();
      _typingSub = _typingStream(chatId).listen(_handleEvent);
    }
  }

  Future sendTyping() async {
    if (_chatId == null) return;
    if (_lastTypingSent != null && DateTime.now().difference(_lastTypingSent!) < typeThrottle) return;

    try {
      final channel = client.getChatChannel(_chatId!);
      if (channel == null) throw Exception('No channel yet');
      if (channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');
      channel.push('chat:typing', {});
      _lastTypingSent = DateTime.now();
    } catch (e) {
      _logger.warning('Failed to send typing event: $e');
    }
  }

  Future<void> _handleEvent(e) async {
    if (e is TypingEvent) {
      final typings = state;
      final userId = e.userId;
      final contact = await contactsRepo.getContactBySource(ContactSourceType.external, userId);
      if (contact != null) {
        typings.add((userId: userId, name: contact.name));
      } else {
        typings.add((userId: userId, name: 'unknown'));
      }
      emit(Set.from(typings));
      _typingTimers[e.userId]?.cancel();
      _typingTimers[e.userId] = Timer(typeTimeout, () {
        if (isClosed) return;
        final typings = state;
        typings.removeWhere((typing) => typing.userId == e.userId);
        emit(Set.from(typings));
      });
    }

    if (e is SentEvent) {
      final typings = state;
      typings.removeWhere((typing) => typing.userId == e.senderId);
      emit(Set.from(typings));
    }
  }

  Stream<dynamic> _typingStream(int chatId) async* {
    while (true) {
      try {
        final channel = client.getChatChannel(chatId);
        if (channel == null) throw Exception('No channel yet');
        if (channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');

        await for (final e in channel.messages) {
          if (e.event.value == 'typing') {
            TypingEvent event = (userId: e.payload!['user_id'] as String);
            yield event;
          }
          if (e.event.value == 'message_update') {
            SentEvent event = (senderId: e.payload!['sender_id'] as String);
            yield event;
          }
        }
      } catch (e) {
        yield e;
      } finally {
        yield null;
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Future<void> close() {
    if (_chatId != null) _chatId = null;
    _typingSub?.cancel();
    for (var t in _typingTimers.values) {
      t.cancel();
    }
    return super.close();
  }
}

typedef TypingEvent = ({String userId});
typedef SentEvent = ({String senderId});
typedef TypingState = Set<({String userId, String name})>;
