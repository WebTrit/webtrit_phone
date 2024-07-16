import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/features/features.dart';

final _logger = Logger('ChatTypingCubit');

class ChatTypingCubit extends Cubit<TypingState> {
  ChatTypingCubit(this.client) : super({});

  final PhoenixSocket client;

  int? _chatId;
  StreamSubscription? _typingSub;
  final Map<String, Timer> _typingTimers = {};

  init(int chatId) {
    if (_chatId != chatId) {
      _chatId = chatId;
      _typingSub?.cancel();
      _typingSub = _typingStream(chatId).whereType<TypingEvent>().listen(_handleTyping);
    }
  }

  Future sendTyping() async {
    if (_chatId == null) return;

    try {
      final channel = client.getChatChannel(_chatId!);
      if (channel == null) throw Exception('No channel yet');
      if (channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');
      await channel.push('user:typing', {}).future;
    } catch (e) {
      _logger.warning('Failed to send typing event: $e');
    }
  }

  void _handleTyping(e) {
    final ids = state;
    ids.add(e.userId);
    emit(Set.from(ids));
    _typingTimers[e.userId]?.cancel();
    _typingTimers[e.userId] = Timer(const Duration(seconds: 5), () {
      if (isClosed) return;
      final ids = state;
      ids.remove(e.userId);
      emit(Set.from(ids));
    });
  }

  Stream<dynamic> _typingStream(int chatId) async* {
    while (true) {
      try {
        final channel = client.getChatChannel(chatId);
        if (channel == null) throw Exception('No channel yet');
        if (channel.state != PhoenixChannelState.joined) throw Exception('Channel not ready yet');

        await for (final e in channel.messages.where((e) => e.event.value == 'typing')) {
          if (e.payload?.containsKey('user_id') ?? false) {
            TypingEvent event = (userId: e.payload!['user_id'] as String);
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
typedef TypingState = Set<String>;
