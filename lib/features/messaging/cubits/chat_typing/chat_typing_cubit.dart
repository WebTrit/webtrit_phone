// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';

final _logger = Logger('ChatTypingCubit');

typedef TypingState = Set<String>;

class ChatTypingCubit extends Cubit<TypingState> {
  ChatTypingCubit(
    this.client, {
    this.typeThrottle = const Duration(seconds: 3),
    this.typeTimeout = const Duration(seconds: 5),
  }) : super({});

  final PhoenixSocket client;
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
      _typingSub = _typingStream(chatId).listen((_) {});
    }
  }

  Future sendTyping() async {
    if (_chatId == null) return;
    if (_lastTypingSent != null && DateTime.now().difference(_lastTypingSent!) < typeThrottle) return;

    try {
      final channel = client.getChatChannel(_chatId!);
      if (channel == null || channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');
      channel.sendChatTyping();
      _lastTypingSent = DateTime.now();
    } catch (e) {
      _logger.warning('Failed to send typing event: $e');
    }
  }

  _addTypingUser(String userId) {
    if (isClosed) return;

    final typings = state;
    typings.add(userId);
    emit(Set.from(typings));

    // Start auto-remove timer
    _typingTimers[userId]?.cancel();
    _typingTimers[userId] = Timer(typeTimeout, () {
      _removeTypingUser(userId);
    });
  }

  _removeTypingUser(String userId) {
    if (isClosed) return;

    final typings = state;
    typings.remove(userId);
    emit(Set.from(typings));
  }

  Stream<dynamic> _typingStream(int chatId) async* {
    while (true) {
      try {
        final channel = client.getChatChannel(chatId);
        if (channel == null || channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');

        await for (var event in channel.chatEvents) {
          switch (event) {
            case ChatChannelTyping event:
              _addTypingUser((event).userId);
            case ChatChannelMessageUpdate event:
              _removeTypingUser((event).message.senderId);
            default:
          }

          yield event;
        }
      } catch (e, s) {
        _logger.info('_typingStream error', e, s);
      } finally {
        yield null;
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  @override
  Future<void> close() {
    _typingSub?.cancel();
    _typingTimers.values.forEach((t) => t.cancel());
    return super.close();
  }
}
