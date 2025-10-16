part of 'permissions_cubit.dart';

@freezed
abstract class PermissionsState with _$PermissionsState {
  const PermissionsState._();

  const factory PermissionsState({
    @Default(false) bool hasRequestedPermissions,
    @Default([]) List<CallkeepSpecialPermissions> pendingSpecialPermissions,
    ManufacturerTip? manufacturerTip,
    Object? failure,
  }) = _PermissionsState;

  bool get isInitial => !hasRequestedPermissions;

  bool get isSpecialPermissionNeeded => pendingSpecialPermissions.isNotEmpty;

  bool get isManufacturerTipNeeded => manufacturerTip != null && manufacturerTip!.shown == false;

  bool get isSuccess => hasRequestedPermissions && !isFailure && !isSpecialPermissionNeeded && !isManufacturerTipNeeded;

  bool get isFailure => failure != null;
}

@freezed
abstract class ManufacturerTip with _$ManufacturerTip {
  const factory ManufacturerTip({
    required Manufacturer manufacturer,
    @Default(false) bool shown,
  }) = _ManufacturerTip;
}
