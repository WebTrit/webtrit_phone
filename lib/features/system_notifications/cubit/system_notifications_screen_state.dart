part of 'system_notifications_screen_cubit.dart';

class SystemNotificationScreenState extends Equatable {
  const SystemNotificationScreenState({
    this.notifications = const [],
    this.outboxEntries = const [],
    this.isLoading = false,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  final List<SystemNotification> notifications;
  final List<SystemNotificationOutboxEntry> outboxEntries;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  @override
  List<Object?> get props => [notifications, outboxEntries, isLoading, fetchingHistory, historyEndReached];

  @override
  String toString() {
    return 'SystemNotificationState(notifications: $notifications, outboxEntries: $outboxEntries, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }

  SystemNotificationScreenState copyWith({
    List<SystemNotification>? notifications,
    List<SystemNotificationOutboxEntry>? outboxEntries,
    bool? isLoading,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return SystemNotificationScreenState(
      notifications: notifications ?? this.notifications,
      outboxEntries: outboxEntries ?? this.outboxEntries,
      isLoading: isLoading ?? this.isLoading,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }
}
