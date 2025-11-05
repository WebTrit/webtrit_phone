part of 'external_contacts_sync_bloc.dart';

sealed class ExternalContactsSyncEvent extends Equatable {
  const ExternalContactsSyncEvent();

  @override
  List<Object?> get props => [];
}

class ExternalContactsSyncStarted extends ExternalContactsSyncEvent {
  const ExternalContactsSyncStarted();
}

class ExternalContactsSyncRefreshed extends ExternalContactsSyncEvent {
  const ExternalContactsSyncRefreshed();
}

class _ExternalContactsSyncUpdated extends ExternalContactsSyncEvent {
  final List<ExternalContact> contacts;

  const _ExternalContactsSyncUpdated({required this.contacts});

  @override
  List<Object?> get props => [EquatablePropToString.list(contacts)];
}
