part of 'permissions_cubit.dart';

enum PermissionsStatus {
  initial,
  inProgress,
  success,
  failure,
}

@freezed
class PermissionsState with _$PermissionsState {
  const PermissionsState._();

  const factory PermissionsState({
    @Default(PermissionsStatus.initial) PermissionsStatus status,
    @Default([]) List<CallkeepSpecialPermissions> requiredSpecialPermissions,
    ManufacturerTip? manufacturerTip,
    Object? error,
  }) = _PermissionsState;

  bool get isInitial => status == PermissionsStatus.initial;

  bool get isInProgress => status == PermissionsStatus.inProgress;

  bool get isSpecialPermissionNeeded => requiredSpecialPermissions.isNotEmpty;

  bool get isManufacturerTipNeeded => manufacturerTip != null && manufacturerTip!.shown == false;

  bool get isSuccess => status == PermissionsStatus.success;

  bool get isFailure => status == PermissionsStatus.failure && error != null;
}

@freezed
class ManufacturerTip with _$ManufacturerTip {
  const factory ManufacturerTip({
    required Manufacturer manufacturer,
    // Indicates whether the tip has been shown to the user
    @Default(false) bool shown,
  }) = _ManufacturerTip;
}
