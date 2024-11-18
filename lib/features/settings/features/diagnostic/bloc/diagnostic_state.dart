part of 'diagnostic_cubit.dart';

@freezed
class DiagnosticState with _$DiagnosticState {
  const factory DiagnosticState({
    @Default([]) List<PermissionWithStatus> permissions,
    @Default(PushTokenStatus()) PushTokenStatus pushTokenStatus,
    @Default(CallkeepAndroidBatteryMode.unknown) CallkeepAndroidBatteryMode batteryMode,
  }) = _Initial;
}
