part of 'diagnostic_cubit.dart';

@freezed
class DiagnosticState with _$DiagnosticState {
  const DiagnosticState._();

  const factory DiagnosticState({
    @Default([]) List<PermissionWithStatus> permissions,
    @Default(PushTokenStatus()) PushTokenStatus pushTokenStatus,
    @Default(CallkeepAndroidBatteryMode.unknown) CallkeepAndroidBatteryMode batteryMode,
  }) = _Initial;

  List<PermissionWithStatus> filterPermissionsByAgreement({List<Permission> exclude = const []}) {
    return permissions.where((permission) {
      return !exclude.contains(permission.permission);
    }).toList();
  }
}
