part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationsSubmitted extends NotificationsEvent {
  const NotificationsSubmitted(this.notification);

  final Notification notification;

  @override
  List<Object> get props => [
        EquatablePropToString([notification], listPropToString),
      ];
}

class NotificationsCleared extends NotificationsEvent {
  const NotificationsCleared();
}
