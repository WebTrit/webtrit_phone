import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';

final _logger = Logger('SystemNotificationsCubit');

class SystemNotificationViewEntry extends Equatable {
  SystemNotificationViewEntry({required this.notification, required this.seenPending});

  final SystemNotification notification;
  final bool seenPending;
  late final id = notification.id;
  late final title = notification.title;
  late final content = notification.content;
  late final seen = notification.seen || seenPending;
  late final date = notification.createdAt;

  @override
  List<Object?> get props => [notification, seenPending];

  @override
  String toString() {
    return 'SystemNotificationViewEntry(notification: $notification, seenPending: $seenPending)';
  }

  SystemNotificationViewEntry copyWith({SystemNotification? notification, bool? seenPending}) {
    return SystemNotificationViewEntry(
      notification: notification ?? this.notification,
      seenPending: seenPending ?? this.seenPending,
    );
  }
}

class SystemNotificationScreenState extends Equatable {
  const SystemNotificationScreenState({
    this.notifications = const [],
    this.isLoading = false,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  final List<SystemNotificationViewEntry> notifications;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object?> get props => [notifications, isLoading, fetchingHistory, historyEndReached];

  @override
  String toString() {
    return 'SystemNotificationState(notifications: $notifications, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }

  SystemNotificationScreenState copyWith({
    List<SystemNotificationViewEntry>? notifications,
    bool? isLoading,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return SystemNotificationScreenState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}

class SystemNotificationsScreenCubit extends Cubit<SystemNotificationScreenState> {
  SystemNotificationsScreenCubit(
    this._systemNotificationsLocalRepository,
    this._systemNotificationsRemoteRepository, {
    Function()? onOpenNotifications,
  }) : super(const SystemNotificationScreenState(notifications: [], isLoading: true)) {
    _init();
  }

  final SystemNotificationsLocalRepository _systemNotificationsLocalRepository;
  final SystemNotificationsRemoteRepository _systemNotificationsRemoteRepository;
  late final StreamSubscription _eventsSub;
  Set<int> _pendingSeenIDs = {};

  Future<void> markAsSeen(SystemNotification notification) async {
    final seenOutboxEntry = SystemNotificationOutboxEntry(
      notificationId: notification.id,
      actionType: SnOutboxActionType.seen,
    );
    await _systemNotificationsLocalRepository.upsertOutboxNotification(seenOutboxEntry);
  }

  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestDate = state.notifications.last.date;
      var history = await _systemNotificationsLocalRepository.getNotifications(from: oldestDate, limit: 50);
      if (history.isEmpty) {
        (history, _) = await _systemNotificationsRemoteRepository.getHistory(since: oldestDate, limit: 50);
        await _systemNotificationsLocalRepository.upsertNotifications(history, silent: true);
      }
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        final newEntries = history.map((n) {
          final seenPending = _pendingSeenIDs.contains(n.id);
          return SystemNotificationViewEntry(notification: n, seenPending: seenPending);
        }).toList();

        emit(state.copyWith(
          notifications: [...state.notifications, ...newEntries],
          fetchingHistory: false,
          historyEndReached: false,
        ));
      }
    } catch (e) {
      _logger.severe('Failed to load notifications', e);
      emit(state.copyWith(fetchingHistory: false));
    }
  }

  _init() async {
    final outboxSeenEntries = await _systemNotificationsLocalRepository.getOutboxNotifications(SnOutboxActionType.seen);
    _pendingSeenIDs = outboxSeenEntries.map((e) => e.notificationId).toSet();

    final systemNotifications = await _systemNotificationsLocalRepository.getNotifications(limit: 50);

    emit(state.copyWith(
      notifications: systemNotifications.map((n) {
        final seenPending = _pendingSeenIDs.contains(n.id);
        return SystemNotificationViewEntry(notification: n, seenPending: seenPending);
      }).toList(),
      isLoading: false,
    ));

    _eventsSub = _systemNotificationsLocalRepository.eventBus.listen(_handleLocalEvent);
  }

  void _handleLocalEvent(SystemNotificationEvent event) {
    final _ = switch (event) {
      SystemNotificationUpdate() => _onSystemNotificationUpdate(event),
      SystemNotificationRemove() => _onSystemNotificationRemove(event),
      SystemNotificationOutboxUpdate() => _onSystemNotificationOutboxUpdate(event),
      SystemNotificationOutboxRemove() => _onSystemNotificationOutboxRemove(event),
      SystemNotificationUnseenCountUpdate() => {},
    };
  }

  void _onSystemNotificationUpdate(SystemNotificationUpdate update) {
    _logger.info('SystemNotificationUpdate: ${update.notification}');
    final isNew = !state.notifications.any((n) => n.id == update.id);
    if (isNew) {
      final seenPending = _pendingSeenIDs.contains(update.notification.id);
      final newEntry = SystemNotificationViewEntry(notification: update.notification, seenPending: seenPending);
      emit(state.copyWith(notifications: [...state.notifications, newEntry]));
    } else {
      final updatedNotifications = state.notifications
          .map((n) => (n.id == update.id) ? n.copyWith(notification: update.notification) : n)
          .toList();
      emit(state.copyWith(notifications: updatedNotifications));
    }
  }

  void _onSystemNotificationRemove(SystemNotificationRemove remove) {
    _logger.info('SystemNotificationRemove: ${remove.id}');
    final updatedNotifications = state.notifications.where((n) => n.id != remove.id).toList();
    emit(state.copyWith(notifications: updatedNotifications));
  }

  void _onSystemNotificationOutboxUpdate(SystemNotificationOutboxUpdate outboxUpdate) {
    final outboxEntry = outboxUpdate.entry;
    _logger.info('SystemNotificationOutboxUpdate: $outboxEntry');
    _pendingSeenIDs.add(outboxEntry.notificationId);

    final updatedNotifications = state.notifications.map((n) {
      if (n.id == outboxUpdate.id) {
        final seenPending = _pendingSeenIDs.contains(n.id);
        return n.copyWith(seenPending: seenPending);
      }
      return n;
    }).toList();
    emit(state.copyWith(notifications: updatedNotifications));
  }

  void _onSystemNotificationOutboxRemove(SystemNotificationOutboxRemove outboxRemove) {
    _logger.info('SystemNotificationOutboxRemove: ${outboxRemove.id}');
    _pendingSeenIDs.remove(outboxRemove.id);

    final updatedNotifications = state.notifications.map((n) {
      if (n.id == outboxRemove.id) {
        final seenPending = _pendingSeenIDs.contains(n.id);
        return n.copyWith(seenPending: seenPending);
      }
      return n;
    }).toList();
    emit(state.copyWith(notifications: updatedNotifications));
  }

  @override
  Future<void> close() async {
    await _eventsSub.cancel();
    return super.close();
  }
}
