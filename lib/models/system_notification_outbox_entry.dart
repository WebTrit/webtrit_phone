import 'package:equatable/equatable.dart';

enum SnOutboxActionType { seen }

enum SnOutboxState { pending, sent, failed }

class SystemNotificationOutboxEntry extends Equatable {
  final int notificationId;
  final SnOutboxActionType actionType;
  final SnOutboxState state;
  final int sendAttempts;

  const SystemNotificationOutboxEntry({
    required this.notificationId,
    required this.actionType,
    this.state = SnOutboxState.pending,
    this.sendAttempts = 0,
  });

  @override
  List<Object?> get props => [notificationId, actionType, sendAttempts];

  @override
  String toString() {
    return 'SystemNotificationOutboxEntry(notificationId: $notificationId, actionType: $actionType, sendAttempts: $sendAttempts)';
  }

  SystemNotificationOutboxEntry copyWith({
    int? notificationId,
    SnOutboxActionType? actionType,
    SnOutboxState? state,
    int? sendAttempts,
  }) {
    return SystemNotificationOutboxEntry(
      notificationId: notificationId ?? this.notificationId,
      actionType: actionType ?? this.actionType,
      state: state ?? this.state,
      sendAttempts: sendAttempts ?? this.sendAttempts,
    );
  }

  SystemNotificationOutboxEntry incAttempts() {
    return copyWith(sendAttempts: sendAttempts + 1);
  }

  SystemNotificationOutboxEntry toSent() {
    return copyWith(state: SnOutboxState.sent);
  }

  SystemNotificationOutboxEntry toFailed() {
    return copyWith(state: SnOutboxState.failed);
  }
}

extension SystemNotificationOutboxEntryExtension on Iterable<SystemNotificationOutboxEntry> {
  bool hasSeen(int id) {
    return any((entry) => entry.notificationId == id && entry.actionType == SnOutboxActionType.seen);
  }
}
