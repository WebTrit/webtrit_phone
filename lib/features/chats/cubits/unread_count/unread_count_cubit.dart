import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/repositories/chats/chats.dart';

final _logger = Logger('UnreadCountCubit');

class UnreadCountCubit extends Cubit<UnreadCountState> {
  UnreadCountCubit({
    required this.appPreferences,
    required this.chatsRepository,
    this.updateDebounce = const Duration(milliseconds: 100),
  }) : super(UnreadCountState.initial());

  final AppPreferences appPreferences;
  final ChatsRepository chatsRepository;
  final Duration updateDebounce;
  String? userId;
  StreamSubscription? _updatesSub;

  void init() {
    _logger.fine('Initializing');
    _updateUnreadCount();
    _updatesSub = chatsRepository.eventBus.debounce(updateDebounce).listen((_) => _updateUnreadCount());
  }

  void _updateUnreadCount() async {
    userId ??= appPreferences.getChatUserId();
    _logger.fine('unread count update for user $userId');

    if (userId == null) return;
    final unreadCount = await chatsRepository.unreadedCountPerChat(userId!);
    final newState = UnreadCountState.fromCountPerChat(unreadCount);
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
  UnreadCountState._(this.chatUnreadCounts, this.totalUnreadCount, this.chatsWithUnreadCount);

  factory UnreadCountState.initial() => UnreadCountState._({}, 0, 0);

  factory UnreadCountState.fromCountPerChat(Map<int, int> chatUnreadCounts) {
    final totalUnreadCount = chatUnreadCounts.values.fold(0, (sum, count) => sum + count);
    final chatsWithUnreadCount = chatUnreadCounts.values.where((count) => count > 0).length;
    return UnreadCountState._(chatUnreadCounts, totalUnreadCount, chatsWithUnreadCount);
  }

  final Map<int, int> chatUnreadCounts;
  final int totalUnreadCount;
  final int chatsWithUnreadCount;

  int unreadCountForChat(int chatId) => chatUnreadCounts[chatId] ?? 0;

  @override
  List<Object> get props => [chatUnreadCounts, totalUnreadCount, chatsWithUnreadCount];

  @override
  bool get stringify => true;
}
