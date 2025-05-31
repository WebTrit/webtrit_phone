import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';

sealed class SystemNotificationEvent {
  const SystemNotificationEvent();

  factory SystemNotificationEvent.update(SystemNotification n) => SystemNotificationUpdate(n);
  factory SystemNotificationEvent.remove(int id) => SystemNotificationRemove(id);
  factory SystemNotificationEvent.outboxUpdate(SystemNotificationOutboxEntry e) => SystemNotificationOutboxUpdate(e);
  factory SystemNotificationEvent.outboxRemove(int id, SnOutboxActionType actionType) =>
      SystemNotificationOutboxRemove(id, actionType);
}

final class SystemNotificationUpdate extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationUpdate(this.notification, {this.initialData = false});
  final SystemNotification notification;
  final bool initialData;

  int get id => notification.id;

  @override
  List<Object?> get props => [notification];

  @override
  bool get stringify => true;
}

final class SystemNotificationRemove extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationRemove(this.id);
  final int id;

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}

final class SystemNotificationOutboxUpdate extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationOutboxUpdate(this.entry);
  final SystemNotificationOutboxEntry entry;
  int get id => entry.notificationId;

  @override
  List<Object?> get props => [entry];

  @override
  bool get stringify => true;
}

final class SystemNotificationOutboxRemove extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationOutboxRemove(this.id, this.actionType);
  final int id;
  final SnOutboxActionType actionType;

  @override
  List<Object?> get props => [id, actionType];

  @override
  bool get stringify => true;
}
