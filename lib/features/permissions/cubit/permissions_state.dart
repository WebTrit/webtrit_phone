part of 'permissions_cubit.dart';

enum PermissionsStatus {
  initial,
  inProgress,
  success,
  failure;

  bool get isInitial => this == initial;
}

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    @Default(PermissionsStatus.initial) PermissionsStatus status,
    Object? error,
  }) = _PermissionsState;
}
