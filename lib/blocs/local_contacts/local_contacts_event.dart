part of 'local_contacts_bloc.dart';

@immutable
abstract class LocalContactsEvent extends Equatable {
  const LocalContactsEvent();

  @override
  List<Object> get props => [];
}

class LocalContactsInitialLoaded extends LocalContactsEvent {
  const LocalContactsInitialLoaded();
}

class LocalContactsRefreshed extends LocalContactsEvent {
  const LocalContactsRefreshed();
}

class LocalContactsUpdated extends LocalContactsEvent {
  final List<LocalContact> contacts;

  const LocalContactsUpdated({
    @required this.contacts,
  });

  @override
  List<Object> get props => [
    contacts,
  ];
}
