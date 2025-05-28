import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';

sealed class SystemNotificationEvent {
  const SystemNotificationEvent();

  factory SystemNotificationEvent.update(SystemNotification notification) => SystemNotificationUpdate(notification);
  factory SystemNotificationEvent.remove(int id) => SystemNotificationRemove(id);
  factory SystemNotificationEvent.outboxUpdate(SystemNotificationOutboxEntry entry) =>
      SystemNotificationOutboxUpdate(entry);
  factory SystemNotificationEvent.outboxRemove(int id) => SystemNotificationOutboxRemove(id);
  factory SystemNotificationEvent.unseenCountUpdate(int count) => SystemNotificationUnseenCountUpdate(count);
}

final class SystemNotificationUpdate extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationUpdate(this.notification);
  final SystemNotification notification;
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
  SystemNotificationOutboxRemove(this.id);
  final int id;

  @override
  List<Object?> get props => [id];

  @override
  bool get stringify => true;
}

final class SystemNotificationUnseenCountUpdate extends SystemNotificationEvent with EquatableMixin {
  SystemNotificationUnseenCountUpdate(this.count);
  final int count;

  @override
  List<Object?> get props => [count];

  @override
  bool get stringify => true;
}
