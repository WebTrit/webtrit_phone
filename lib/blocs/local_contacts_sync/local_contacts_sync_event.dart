part of 'local_contacts_sync_bloc.dart';

sealed class LocalContactsSyncEvent extends Equatable {
  const LocalContactsSyncEvent();

  @override
  List<Object?> get props => [];
}

class LocalContactsSyncStarted extends LocalContactsSyncEvent {
  const LocalContactsSyncStarted();
}

class LocalContactsSyncRefreshed extends LocalContactsSyncEvent {
  const LocalContactsSyncRefreshed();
}

class _LocalContactsSyncUpdated extends LocalContactsSyncEvent {
  final List<LocalContact> contacts;

  const _LocalContactsSyncUpdated({required this.contacts});

  @override
  List<Object?> get props => [EquatablePropToString.list(contacts)];
}
