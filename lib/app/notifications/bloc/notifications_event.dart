part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationsSubmitted extends NotificationsEvent {
  const NotificationsSubmitted(this.notification);

  final Notification notification;
}

class NotificationsCleared extends NotificationsEvent {
  const NotificationsCleared();
}
