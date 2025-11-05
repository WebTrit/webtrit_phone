part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class NotificationsSubmitted extends NotificationsEvent {
  const NotificationsSubmitted(this.notification);

  final Notification notification;

  @override
  List<Object?> get props => [notification];
}

class NotificationsCleared extends NotificationsEvent {
  const NotificationsCleared();
}
