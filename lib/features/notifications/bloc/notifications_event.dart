part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationsIssued extends NotificationsEvent {
  const NotificationsIssued(this.notification);

  final Notification notification;
}

class NotificationsCleared extends NotificationsEvent {
  const NotificationsCleared();
}
