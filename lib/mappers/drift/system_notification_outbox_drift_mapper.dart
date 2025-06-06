import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

mixin SystemNotificationOutboxDriftMapper {
  SystemNotificationOutboxEntryData notificationOutboxEntryToDrift(SystemNotificationOutboxEntry entry) {
    return SystemNotificationOutboxEntryData(
      notificationId: entry.notificationId,
      actionType: actionTypeToDrift(entry.actionType),
      state: stateToDrift(entry.state),
      sendAttempts: entry.sendAttempts,
    );
  }

  SystemNotificationOutboxEntry notificationOutboxEntryFromDrift(SystemNotificationOutboxEntryData data) {
    return SystemNotificationOutboxEntry(
      notificationId: data.notificationId,
      actionType: actionTypefromDrift(data.actionType),
      state: stateFromDrift(data.state),
      sendAttempts: data.sendAttempts,
    );
  }

  SnOutboxDataActionType actionTypeToDrift(SnOutboxActionType actionType) {
    return SnOutboxDataActionType.values.firstWhere((e) => e.name == actionType.name);
  }

  SnOutboxActionType actionTypefromDrift(SnOutboxDataActionType actionType) {
    return SnOutboxActionType.values.firstWhere((e) => e.name == actionType.name);
  }

  SnOutboxDataState stateToDrift(SnOutboxState state) {
    return SnOutboxDataState.values.firstWhere((e) => e.name == state.name);
  }

  SnOutboxState stateFromDrift(SnOutboxDataState state) {
    return SnOutboxState.values.firstWhere((e) => e.name == state.name);
  }
}
