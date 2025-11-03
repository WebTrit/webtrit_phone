part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const PermissionsState({
    this.hasRequestedPermissions = false,
    this.pendingSpecialPermissions = const [],
    this.manufacturerTip,
    this.failure,
  });

  @override
  final bool hasRequestedPermissions;
  @override
  final List<CallkeepSpecialPermissions> pendingSpecialPermissions;
  @override
  final ManufacturerTip? manufacturerTip;
  @override
  final Object? failure;

  bool get isInitial => !hasRequestedPermissions;

  bool get isSpecialPermissionNeeded => pendingSpecialPermissions.isNotEmpty;

  bool get isManufacturerTipNeeded => manufacturerTip != null && manufacturerTip!.shown == false;

  bool get isSuccess => hasRequestedPermissions && !isFailure && !isSpecialPermissionNeeded && !isManufacturerTipNeeded;

  bool get isFailure => failure != null;
}

@freezed
class ManufacturerTip with _$ManufacturerTip {
  const ManufacturerTip({
    required this.manufacturer,
    this.shown = false,
  });

  @override
  final Manufacturer manufacturer;
  @override
  final bool shown;
}
