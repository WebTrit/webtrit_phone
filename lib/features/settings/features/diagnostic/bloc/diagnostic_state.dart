part of 'diagnostic_cubit.dart';

@freezed
class DiagnosticState with _$DiagnosticState {
  const DiagnosticState({
    this.permissions = const [],
    this.pushTokenStatus = const PushTokenStatus(),
    this.batteryMode = CallkeepAndroidBatteryMode.unknown,
    this.callDeliveryMode = CallkeepAndroidCallDeliveryMode.unknown,
  });

  @override
  final List<PermissionWithStatus> permissions;

  @override
  final PushTokenStatus pushTokenStatus;

  @override
  final CallkeepAndroidBatteryMode batteryMode;

  @override
  final CallkeepAndroidCallDeliveryMode callDeliveryMode;

  List<PermissionWithStatus> filterPermissionsByAgreement({List<Permission> exclude = const []}) {
    return permissions.where((permission) {
      return !exclude.contains(permission.permission);
    }).toList();
  }
}
