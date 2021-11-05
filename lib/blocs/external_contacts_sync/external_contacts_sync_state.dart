part of 'external_contacts_sync_bloc.dart';

@immutable
abstract class ExternalContactsSyncState extends Equatable {
  const ExternalContactsSyncState();

  @override
  List<Object> get props => [];
}

class ExternalContactsSyncInitial extends ExternalContactsSyncState {
  const ExternalContactsSyncInitial();
}

class ExternalContactsSyncRefreshInProgress extends ExternalContactsSyncState {
  const ExternalContactsSyncRefreshInProgress();
}

class ExternalContactsSyncSuccess extends ExternalContactsSyncState {
  const ExternalContactsSyncSuccess();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

abstract class ExternalContactsSyncFailure extends ExternalContactsSyncState {
  const ExternalContactsSyncFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class ExternalContactsSyncRefreshFailure extends ExternalContactsSyncFailure {
  const ExternalContactsSyncRefreshFailure();
}
