import 'package:freezed_annotation/freezed_annotation.dart';

part 'system_notification.freezed.dart';

part 'system_notification.g.dart';

@freezed
class SystemNotification with _$SystemNotification {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SystemNotification({
    required int id,
    required String title,
    required String content,
    required bool seen,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? readAt,
  }) = _SystemNotification;

  factory SystemNotification.fromJson(Map<String, Object?> json) => _$SystemNotificationFromJson(json);
}

@freezed
class SystemNotificationResponce with _$SystemNotificationResponce {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SystemNotificationResponce({
    required List<SystemNotification> notifications,
    required int total,
  }) = _SystemNotificationResponce;

  factory SystemNotificationResponce.fromJson(Map<String, Object?> json) => _$SystemNotificationResponceFromJson(json);
}
