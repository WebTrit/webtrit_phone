import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/push_notification/app_local_notification.dart';
import 'package:webtrit_phone/repositories/notifications/local_notifications_repository.dart';

class SystemNotificationState extends Equatable {
  const SystemNotificationState({
    this.notifications = const [],
    this.isLoading = false,
  });

  final List<SystemNotification> notifications;
  final bool isLoading;

  @override
  List<Object?> get props => [notifications, isLoading];

  @override
  String toString() {
    return 'SystemNotificationState(notifications: $notifications, isLoading: $isLoading)';
  }

  int get unreadCount {
    return notifications.where((notification) => notification.readAt == null).length;
  }
}

class SystemNotificationsCubit extends Cubit<SystemNotificationState> {
  SystemNotificationsCubit(
    this._localNotificationRepository, {
    Function()? onOpenNotifications,
  }) : super(const SystemNotificationState(notifications: [], isLoading: true)) {
    // Simulate loading notifications
    Future.delayed(const Duration(seconds: 1), () {
      emit(SystemNotificationState(notifications: notificationsMock, isLoading: false));
    });

    // Listen for system notification actions e.g. tap, dismiss
    _systemNotificationActionsSub = _localNotificationRepository.systemActions.listen(
      (_) => onOpenNotifications?.call(),
    );
  }

  final LocalNotificationRepository _localNotificationRepository;
  StreamSubscription? _systemNotificationActionsSub;

  Future<void> rotateNotifications() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;

    final random = Random().nextInt(state.notifications.length);
    final newNotification = SystemNotification(
      title: state.notifications[random].title,
      body: state.notifications[random].body,
      dateTime: DateTime.now(),
    );

    final notifications = [newNotification, ...state.notifications];
    emit(SystemNotificationState(notifications: notifications, isLoading: false));

    final pushPayload = {
      'system_id': newNotification.hashCode.toString(),
      'title': newNotification.title,
      'body': newNotification.body,
      'dateTime': newNotification.dateTime.toIso8601String(),
    };
    final push = AppLocalNotification(
      newNotification.hashCode,
      newNotification.title,
      newNotification.body,
      payload: pushPayload,
    );
    _localNotificationRepository.displayNotification(push);
  }

  void markAsRead(SystemNotification notification) {
    final notifications = List<SystemNotification>.from(state.notifications);
    final index = notifications.indexOf(notification);
    if (index != -1) {
      notifications[index] = notification.copyWith(readAt: DateTime.now());
      emit(SystemNotificationState(notifications: notifications, isLoading: false));
    }
    _localNotificationRepository.dismissByContent(notification.title, notification.body);
  }

  @override
  Future<void> close() {
    _systemNotificationActionsSub?.cancel();
    return super.close();
  }
}

List<SystemNotification> notificationsMock = [
  SystemNotification(
    title: 'App support',
    body: 'Your refund request has been approved, check your email for more details',
    dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  SystemNotification(
    title: 'New feature announcement',
    body: 'We have released a new feature\nCALCULATOR!!🥳🥳\nNow you can calculate your sales',
    dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
    readAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  SystemNotification(
    title: 'System maintenance',
    body: 'The system will be down for maintenance at 2 AM',
    dateTime: DateTime.now().subtract(const Duration(hours: 25)),
    readAt: DateTime.now().subtract(const Duration(minutes: 20)),
  ),
  SystemNotification(
    title: 'Super puper sale',
    body: 'Hurray super puper sale!\nYou can sale all your sales for free!\n[Expires in 24 hours]',
    dateTime: DateTime.now().subtract(const Duration(hours: 50)),
    readAt: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  SystemNotification(
    title: 'Super sale',
    body: 'We have a new super sale, you can sale your previous sale for 50% off',
    dateTime: DateTime.now().subtract(const Duration(hours: 50)),
    readAt: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  SystemNotification(
    title: 'New sales',
    body: 'You have a new sale, check it out!',
    dateTime: DateTime.now().subtract(const Duration(hours: 50)),
    readAt: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
];
