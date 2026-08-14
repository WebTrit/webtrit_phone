part of 'diagnostic_cubit.dart';

@freezed
class DiagnosticState with _$DiagnosticState {
  const DiagnosticState({
    this.permissions = const [],
    this.pushTokenStatus = const PushTokenStatus(),
    this.batteryMode = CallkeepAndroidBatteryMode.unknown,
    this.callDeliveryMode = CallkeepAndroidCallDeliveryMode.unknown,
    this.isXiaomiDevice = false,
    this.backgroundActivityStartStatus = CallkeepSpecialPermissionStatus.unknown,
    this.showWhenLockedStatus = CallkeepSpecialPermissionStatus.unknown,
    this.fullScreenIntentStatus = CallkeepSpecialPermissionStatus.unknown,
  });

  @override
  final List<PermissionWithStatus> permissions;

  @override
  final PushTokenStatus pushTokenStatus;

  @override
  final CallkeepAndroidBatteryMode batteryMode;

  @override
  final CallkeepAndroidCallDeliveryMode callDeliveryMode;

  /// Whether the device belongs to the Xiaomi/HyperOS family (MIUI, Redmi, Poco),
  /// which gates visibility of the "Xiaomi permissions" diagnostic section.
  @override
  final bool isXiaomiDevice;

  /// Status of the OEM "display pop-up windows while running in background"
  /// capability (MIUI/HyperOS), which gates showing the incoming-call UI over
  /// the lock screen.
  @override
  final CallkeepSpecialPermissionStatus backgroundActivityStartStatus;

  /// Status of the OEM "show on lock screen" capability (MIUI/HyperOS), which
  /// gates showing the incoming-call UI over the lock screen.
  @override
  final CallkeepSpecialPermissionStatus showWhenLockedStatus;

  /// Status of the permission that lets an incoming call take over the lock screen.
  /// Denied only costs the full-screen call UI - the call still arrives as a
  /// notification - so this is the place where the user can turn it on later.
  @override
  final CallkeepSpecialPermissionStatus fullScreenIntentStatus;

  List<PermissionWithStatus> filterPermissionsByAgreement({List<Permission> exclude = const []}) {
    return permissions.where((permission) {
      return !exclude.contains(permission.permission);
    }).toList();
  }
}
