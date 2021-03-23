part of 'external_contacts_bloc.dart';

@immutable
abstract class ExternalContactsEvent extends Equatable {
  const ExternalContactsEvent();

  @override
  List<Object> get props => [];
}

class ExternalContactsInitialLoaded extends ExternalContactsEvent {
  const ExternalContactsInitialLoaded();
}

class ExternalContactsRefreshed extends ExternalContactsEvent {
  const ExternalContactsRefreshed();
}

class ExternalContactsUpdated extends ExternalContactsEvent {
  final List<ExternalContact> contacts;

  const ExternalContactsUpdated({
    @required this.contacts,
  });

  @override
  List<Object> get props => [
    contacts,
  ];
}
