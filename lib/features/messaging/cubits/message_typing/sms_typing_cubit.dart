// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/features/features.dart';

final _logger = Logger('ChatTypingCubit');

typedef TypingNumbers = Set<String>;

class SmsTypingCubit extends Cubit<TypingNumbers> {
  SmsTypingCubit(
    this.client, {
    this.typeThrottle = const Duration(seconds: 3),
    this.typeTimeout = const Duration(seconds: 5),
  }) : super({});

  final PhoenixSocket client;
  final Duration typeThrottle;
  final Duration typeTimeout;

  int? _conversationId;
  StreamSubscription? _typingSub;
  final Map<String, Timer> _typingTimers = {};
  DateTime? _lastTypingSent;

  void initConversation(int id) {
    if (_conversationId != id) {
      _conversationId = id;
      _typingSub?.cancel();
      _typingSub = _typingStream(id).listen((_) {});
    }
  }

  Future sendTyping() async {
    if (_conversationId == null) return;
    if (_lastTypingSent != null && DateTime.now().difference(_lastTypingSent!) < typeThrottle) return;

    try {
      final channel = client.getSmsConversationChannel(_conversationId!);
      if (channel == null || channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');
      channel.sendSmsTypnig();
      _lastTypingSent = DateTime.now();
    } catch (e) {
      _logger.warning('Failed to send typing event: $e');
    }
  }

  void _addTypingNumber(String number) {
    if (isClosed) return;

    final typings = state;
    typings.add(number);
    emit(Set.from(typings));

    // Start auto-remove timer
    _typingTimers[number]?.cancel();
    _typingTimers[number] = Timer(typeTimeout, () {
      _removeTypingNumber(number);
    });
  }

  void _removeTypingNumber(String number) {
    if (isClosed) return;

    final typings = state;
    typings.remove(number);
    emit(Set.from(typings));
  }

  Stream<dynamic> _typingStream(int conversationId) async* {
    while (true) {
      try {
        final channel = client.getSmsConversationChannel(conversationId);
        if (channel == null || channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');

        await for (var event in channel.chatEvents) {
          switch (event) {
            case SmsChannelTyping event:
              _addTypingNumber((event).number);
            case SmsChannelMessageUpdate event:
              _removeTypingNumber((event).message.fromPhoneNumber);
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
