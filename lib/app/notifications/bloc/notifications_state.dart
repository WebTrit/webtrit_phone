part of 'notifications_bloc.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState([Notification? lastNotification]) = _NotificationsState;
}
