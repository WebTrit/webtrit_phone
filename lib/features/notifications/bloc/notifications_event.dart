part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

@Freezed(copyWith: false)
class NotificationsIssued with _$NotificationsIssued implements NotificationsEvent {
  const factory NotificationsIssued(Notification notification) = _NotificationsIssued;
}

@Freezed(copyWith: false)
class NotificationsCleared with _$NotificationsCleared implements NotificationsEvent {
  const factory NotificationsCleared() = _NotificationsCleared;
}
