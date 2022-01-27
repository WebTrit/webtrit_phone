part of 'notifications_bloc.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState([Notification? lastNotification]) = _NotificationsState;
}
