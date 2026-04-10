import 'package:equatable/equatable.dart';

/// Configuration for the system notifications feature, including push support.
class SystemNotificationsConfig extends Equatable {
  const SystemNotificationsConfig({
    required this.systemNotificationsSupport,
    required this.systemNotificationsPushSupport,
  });

  /// Whether the system notifications feature is enabled and supported by the remote system.
  final bool systemNotificationsSupport;

  /// Whether the system notifications push feature is enabled and supported by the remote system.
  final bool systemNotificationsPushSupport;

  @override
  List<Object?> get props => [systemNotificationsSupport, systemNotificationsPushSupport];
}
