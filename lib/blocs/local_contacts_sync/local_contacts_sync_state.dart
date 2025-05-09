part of 'local_contacts_sync_bloc.dart';

@immutable
abstract class LocalContactsSyncState extends Equatable {
  const LocalContactsSyncState();

  @override
  List<Object> get props => [];
}

class LocalContactsSyncInitial extends LocalContactsSyncState {
  const LocalContactsSyncInitial();
}

class LocalContactsSyncRefreshInProgress extends LocalContactsSyncInitial {
  const LocalContactsSyncRefreshInProgress();
}

class LocalContactsSyncSuccess extends LocalContactsSyncState {
  const LocalContactsSyncSuccess();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

abstract class LocalContactsSyncFailure extends LocalContactsSyncState {
  const LocalContactsSyncFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class LocalContactsSyncRefreshFailure extends LocalContactsSyncFailure {
  const LocalContactsSyncRefreshFailure();
}

class LocalContactsSyncPermissionFailure extends LocalContactsSyncFailure {
  const LocalContactsSyncPermissionFailure();
}

class LocalContactsSyncUpdateFailure extends LocalContactsSyncFailure {
  const LocalContactsSyncUpdateFailure();
}

class LocalContactsSyncNotAllowedException extends LocalContactsSyncFailure {
  const LocalContactsSyncNotAllowedException();

  @override
  String toString() => 'Local contacts sync is not allowed due to settings or permissions';
}
