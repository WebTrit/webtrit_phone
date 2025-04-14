import 'dart:async';

import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('UnreadCountCubit');

class UnreadCountCubit extends Cubit<UnreadCountState> {
  UnreadCountCubit({
    required this.userId,
    required this.chatsRepository,
    required this.smsRepository,
    this.updateDebounce = const Duration(seconds: 1),
  }) : super(UnreadCountState.initial());

  final String userId;
  final ChatsRepository chatsRepository;
  final SmsRepository smsRepository;
  final Duration updateDebounce;
  StreamSubscription? _updatesSub;

  void init() {
    _logger.fine('Initializing');
    _updateUnreadCount();

    _updatesSub = StreamGroup.merge([
      chatsRepository.eventBus,
      smsRepository.eventBus,
    ]).debounce(updateDebounce).listen((_) => _updateUnreadCount());
  }

  void _updateUnreadCount() async {
    final chatCounts = await chatsRepository.unreadedCountPerChat(userId);
    final smsCounts = await smsRepository.unreadedCountPerConversation(userId);

    final newState = UnreadCountState.fromCountPerChat(chatCounts, smsCounts);
    emit(newState);

    _logger.fine('UnreadMessagesState: $newState');
  }

  @override
  Future<void> close() {
    _logger.fine('Closing');
    _updatesSub?.cancel();
    return super.close();
  }
}

class UnreadCountState with EquatableMixin {
  UnreadCountState._(
    this.chatUnreadCounts,
    this.chatsWithUnreadCount,
    this.smsUnreadCounts,
    this.smsConversationsWithUnreadCount,
  );

  factory UnreadCountState.initial() => UnreadCountState._({}, 0, {}, 0);

  factory UnreadCountState.fromCountPerChat(
    Map<int, int> chatUnreadCounts,
    Map<int, int> smsUnreadCounts,
  ) {
    final chatsWithUnreadCount = chatUnreadCounts.values.where((count) => count > 0).length;
    final smsConversationsWithUnreadCount = smsUnreadCounts.values.where((count) => count > 0).length;
    return UnreadCountState._(chatUnreadCounts, chatsWithUnreadCount, smsUnreadCounts, smsConversationsWithUnreadCount);
  }

  final Map<int, int> chatUnreadCounts;
  final int chatsWithUnreadCount;

  final Map<int, int> smsUnreadCounts;
  final int smsConversationsWithUnreadCount;

  int unreadCountForChatConversation(int id) => chatUnreadCounts[id] ?? 0;
  int unreadCountForSmsConversation(int id) => smsUnreadCounts[id] ?? 0;

  @override
  List<Object> get props => [chatUnreadCounts, chatsWithUnreadCount, smsUnreadCounts, smsConversationsWithUnreadCount];

  @override
  bool get stringify => true;
}
