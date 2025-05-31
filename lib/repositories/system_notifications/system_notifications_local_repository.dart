// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/drift/system_notification_drift_mapper.dart';
import 'package:webtrit_phone/mappers/drift/system_notification_outbox_drift_mapper.dart';
import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';

abstract class SystemNotificationsLocalRepository {
  Stream<SystemNotificationEvent> get eventBus;

  Future<List<SystemNotification>> getNotifications({DateTime? from, DateTime? to, int limit = 50});
  Future<SystemNotification?> getNotificationById(int id);
  Future<DateTime?> getLastUpdate();
  Stream<int> unseenCount();

  Future<void> upsertNotifications(
    List<SystemNotification> notifications, {
    bool silent = false,
    bool initialData = false,
  });
  Future<void> deleteNotification(int id);

  Future<List<SystemNotificationOutboxEntry>> getOutboxNotifications({
    SnOutboxActionType? actionType,
    List<SnOutboxState> states = SnOutboxState.values,
  });
  Future<void> upsertOutboxNotification(SystemNotificationOutboxEntry entry);
  Future<void> deleteOutboxNotification(int notificationId, SnOutboxActionType actionType);

  Future<void> wipeData();
}

class SystemNotificationsLocalRepositoryDriftImpl
    with SystemNotificationOutboxDriftMapper, SystemNotificationDriftMapper
    implements SystemNotificationsLocalRepository {
  SystemNotificationsLocalRepositoryDriftImpl(this._appDatabase);

  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.systemNotificationsDao;

  final StreamController<SystemNotificationEvent> _eventBus = StreamController.broadcast();
  _addEvent(SystemNotificationEvent event) => _eventBus.add(event);

  @override
  Stream<SystemNotificationEvent> get eventBus => _eventBus.stream;

  @override
  Future<List<SystemNotification>> getNotifications({DateTime? from, DateTime? to, int limit = 50}) async {
    final data = await _dao.getNotifications(from: from, to: to, limit: limit);
    return data.map(systemNotificationFromDrift).toList();
  }

  @override
  Future<SystemNotification?> getNotificationById(int id) async {
    final data = await _dao.getNotificationById(id);
    return data != null ? systemNotificationFromDrift(data) : null;
  }

  @override
  Future<DateTime?> getLastUpdate() async {
    return await _dao.getLastUpdate();
  }

  @override
  Stream<int> unseenCount() {
    return _dao.unseenCount();
  }

  @override
  Future<void> upsertNotifications(
    List<SystemNotification> notifications, {
    bool silent = false,
    bool initialData = false,
  }) async {
    final data = notifications.map(systemNotificationToDrift).toList();
    await _dao.upsertNotifications(data);
    if (silent == false) {
      notifications.forEach(
        (n) => _addEvent(SystemNotificationUpdate(n, initialData: initialData)),
      );
    }
  }

  @override
  Future<void> deleteNotification(int id) async {
    await _dao.deleteNotification(id);
    _addEvent(SystemNotificationRemove(id));
  }

  @override
  Future<List<SystemNotificationOutboxEntry>> getOutboxNotifications({
    SnOutboxActionType? actionType,
    List<SnOutboxState> states = SnOutboxState.values,
  }) async {
    final actionTypeData = actionType != null ? actionTypeToDrift(actionType) : null;
    final statesData = states.map(stateToDrift).toSet().toList();
    final data = await _dao.getOutboxNotifications(actionTypeData, states: statesData);
    return data.map(notificationOutboxEntryFromDrift).toList();
  }

  @override
  Future<void> upsertOutboxNotification(SystemNotificationOutboxEntry entry) async {
    final data = notificationOutboxEntryToDrift(entry);
    await _dao.upsertOutboxNotification(data);
    _addEvent(SystemNotificationOutboxUpdate(entry));
  }

  @override
  Future<void> deleteOutboxNotification(int notificationId, SnOutboxActionType actionType) async {
    final actionTypeData = actionTypeToDrift(actionType);
    await _dao.deleteOutboxNotification(notificationId, actionTypeData);
    _addEvent(SystemNotificationOutboxRemove(notificationId, actionType));
  }

  @override
  Future<void> wipeData() async {
    await _dao.wipeData();
  }
}
