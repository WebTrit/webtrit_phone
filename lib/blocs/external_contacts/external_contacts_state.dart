part of 'external_contacts_bloc.dart';

@immutable
abstract class ExternalContactsState extends Equatable {
  const ExternalContactsState();

  @override
  List<Object> get props => [];
}

class ExternalContactsInitial extends ExternalContactsState {
  const ExternalContactsInitial();
}

class ExternalContactsLoadSuccess extends ExternalContactsState {
  final List<ExternalContact> contacts;

  const ExternalContactsLoadSuccess({
    required this.contacts,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

abstract class ExternalContactsLoadFailure extends ExternalContactsState {
  const ExternalContactsLoadFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class ExternalContactsInitialLoadFailure extends ExternalContactsLoadFailure {
  const ExternalContactsInitialLoadFailure();
}

class ExternalContactsRefreshFailure extends ExternalContactsLoadFailure {
  const ExternalContactsRefreshFailure();
}
