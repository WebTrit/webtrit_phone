part of 'notifications_bloc.dart';

abstract class NotificationsEvent {
  const NotificationsEvent();
}

@Freezed(copyWith: false)
abstract class NotificationsSubmitted with _$NotificationsSubmitted implements NotificationsEvent {
  const factory NotificationsSubmitted(Notification notification) = _NotificationsSubmitted;
}

@Freezed(copyWith: false)
class NotificationsCleared with _$NotificationsCleared implements NotificationsEvent {
  const factory NotificationsCleared() = _NotificationsCleared;
}
