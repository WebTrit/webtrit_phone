part of 'local_contacts_bloc.dart';

@immutable
abstract class LocalContactsState extends Equatable {
  const LocalContactsState();

  @override
  List<Object> get props => [];
}

class LocalContactsInitial extends LocalContactsState {
  const LocalContactsInitial();
}

class LocalContactsLoadSuccess extends LocalContactsState {
  final List<LocalContact> contacts;

  const LocalContactsLoadSuccess({
    required this.contacts,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

abstract class LocalContactsLoadFailure extends LocalContactsState {
  const LocalContactsLoadFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class LocalContactsInitialLoadFailure extends LocalContactsLoadFailure {
  const LocalContactsInitialLoadFailure();
}

class LocalContactsRefreshFailure extends LocalContactsLoadFailure {
  const LocalContactsRefreshFailure();
}
