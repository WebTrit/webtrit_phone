import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notification.freezed.dart';

part 'system_notification.g.dart';

enum SystemNotificationType { announcement, promotion, security, system }

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SystemNotification with _$SystemNotification {
  const SystemNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.seen,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.readAt,
  });

  @override
  final int id;

  @override
  final String title;

  @override
  final String content;

  @override
  final bool seen;

  @override
  final SystemNotificationType type;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  @override
  final DateTime? readAt;

  factory SystemNotification.fromJson(Map<String, Object?> json) => _$SystemNotificationFromJson(json);

  Map<String, Object?> toJson() => _$SystemNotificationToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SystemNotificationResponce with _$SystemNotificationResponce {
  const SystemNotificationResponce({required this.items});

  @override
  final List<SystemNotification> items;

  factory SystemNotificationResponce.fromJson(Map<String, Object?> json) => _$SystemNotificationResponceFromJson(json);

  Map<String, Object?> toJson() => _$SystemNotificationResponceToJson(this);
}
