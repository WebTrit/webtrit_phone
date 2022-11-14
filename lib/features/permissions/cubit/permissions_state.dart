part of 'permissions_cubit.dart';

enum PermissionsStatus {
  initial,
  inProgress,
  success,
  failure;

  bool get isInitial => this == initial;

  bool get isInProgress => this == inProgress;

  bool get isSuccess => this == success;

  bool get isFailure => this == failure;
}

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    @Default(PermissionsStatus.initial) PermissionsStatus status,
  }) = _PermissionsState;
}
