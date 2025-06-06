import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'system_notifications_screen_state.dart';

final _logger = Logger('SystemNotificationsCubit');

class SystemNotificationsScreenCubit extends Cubit<SystemNotificationScreenState> {
  SystemNotificationsScreenCubit(
    this._systemNotificationsLocalRepository,
    this._systemNotificationsRemoteRepository, {
    this.pageSize = 50,
  }) : super(const SystemNotificationScreenState(notifications: [], isLoading: true));

  final SystemNotificationsLocalRepository _systemNotificationsLocalRepository;
  final SystemNotificationsRemoteRepository _systemNotificationsRemoteRepository;
  final int pageSize;
  late final StreamSubscription _eventsSub;

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
      final oldestDate = state.notifications.last.createdAt;
      var history = await _systemNotificationsLocalRepository.getNotifications(from: oldestDate, limit: pageSize);
      if (history.isEmpty) {
        history = await _systemNotificationsRemoteRepository.getHistory(since: oldestDate, limit: pageSize);
        await _systemNotificationsLocalRepository.upsertNotifications(history, silent: true);
      }
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        final notifications = state.notifications.mergeWithHistory(history).toList();
        emit(state.copyWith(notifications: notifications, fetchingHistory: false, historyEndReached: false));
      }
    } catch (e) {
      _logger.severe('Failed to load notifications', e);
      emit(state.copyWith(fetchingHistory: false));
    }
  }

  init() async {
    final outboxEntries = await _systemNotificationsLocalRepository.getOutboxNotifications();
    final notifications = await _systemNotificationsLocalRepository.getNotifications(limit: pageSize);
    emit(state.copyWith(notifications: notifications, outboxEntries: outboxEntries, isLoading: false));
    _eventsSub = _systemNotificationsLocalRepository.eventBus.listen(_handleLocalEvent);
  }

  void _handleLocalEvent(SystemNotificationEvent event) {
    _logger.info('Received event: $event');
    final _ = switch (event) {
      SystemNotificationUpdate() => _onSystemNotificationUpdate(event),
      SystemNotificationRemove() => _onSystemNotificationRemove(event),
      SystemNotificationOutboxUpdate() => _onSystemNotificationOutboxUpdate(event),
      SystemNotificationOutboxRemove() => _onSystemNotificationOutboxRemove(event),
    };
  }

  void _onSystemNotificationUpdate(SystemNotificationUpdate update) {
    final notification = update.notification;
    final notifications = state.notifications.mergeWithUpdate(notification);
    emit(state.copyWith(notifications: notifications.toList()));
  }

  void _onSystemNotificationRemove(SystemNotificationRemove remove) {
    final id = remove.id;
    final notifications = state.notifications.mergeWithRemove(id);
    emit(state.copyWith(notifications: notifications.toList()));
  }

  void _onSystemNotificationOutboxUpdate(SystemNotificationOutboxUpdate outboxUpdate) {
    final outboxEntry = outboxUpdate.entry;
    final notifications = state.outboxEntries.mergeWithUpdate(outboxEntry);
    emit(state.copyWith(outboxEntries: notifications.toList()));
  }

  void _onSystemNotificationOutboxRemove(SystemNotificationOutboxRemove outboxRemove) {
    final id = outboxRemove.id;
    var actionType = outboxRemove.actionType;
    final notifications = state.outboxEntries.mergeWithRemove(id, actionType);
    emit(state.copyWith(outboxEntries: notifications.toList()));
  }

  @override
  Future<void> close() async {
    await _eventsSub.cancel();
    return super.close();
  }
}
