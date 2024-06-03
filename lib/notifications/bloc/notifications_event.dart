part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

@Freezed(copyWith: false)
class NotificationSubmitted with _$NotificationSubmitted implements NotificationsEvent {
  const factory NotificationSubmitted(Notification notification) = _NotificationSubmitted;
}

@Freezed(copyWith: false)
class NotificationsCleared with _$NotificationsCleared implements NotificationsEvent {
  const factory NotificationsCleared() = _NotificationsCleared;
}
