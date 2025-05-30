part of 'system_notifications_screen_cubit.dart';

class SystemNotificationScreenState extends Equatable {
  const SystemNotificationScreenState({
    this.notifications = const [],
    this.isLoading = false,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  final List<SystemNotificationViewEntry> notifications;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object?> get props => [notifications, isLoading, fetchingHistory, historyEndReached];

  @override
  String toString() {
    return 'SystemNotificationState(notifications: $notifications, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }

  SystemNotificationScreenState copyWith({
    List<SystemNotificationViewEntry>? notifications,
    bool? isLoading,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return SystemNotificationScreenState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}

class SystemNotificationViewEntry extends Equatable {
  SystemNotificationViewEntry({required this.notification, required this.seenPending});

  final SystemNotification notification;
  final bool seenPending;
  late final id = notification.id;
  late final title = notification.title;
  late final content = notification.content;
  late final type = notification.type;
  late final seen = notification.seen || seenPending;
  late final date = notification.createdAt;

  @override
  List<Object?> get props => [notification, seenPending];

  @override
  String toString() {
    return 'SystemNotificationViewEntry(notification: $notification, seenPending: $seenPending)';
  }

  SystemNotificationViewEntry copyWith({SystemNotification? notification, bool? seenPending}) {
    return SystemNotificationViewEntry(
      notification: notification ?? this.notification,
      seenPending: seenPending ?? this.seenPending,
    );
  }
}
