part of 'permissions_cubit.dart';

enum PermissionsStatus {
  initial,
  inProgress,
  success;

  bool get isInitial => this == initial;

  bool get isInProgress => this == inProgress;

  bool get isSuccess => this == success;
}

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    @Default(PermissionsStatus.initial) PermissionsStatus status,
    Object? error,
  }) = _PermissionsState;
}
