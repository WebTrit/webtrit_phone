part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState.initial() = PermissionsStateInitial;

  const factory PermissionsState.inProgress() = PermissionsStateInProgress;

  const factory PermissionsState.subPlatformTipNeeded(Manufacturer subPlatform) = PermissionsStateSubPlatformTipNeeded;

  const factory PermissionsState.success() = PermissionsStateSuccess;

  const factory PermissionsState.failure(Object error) = PermissionsStateFailure;
}

enum Manufacturer {
  xiaomi,
}
