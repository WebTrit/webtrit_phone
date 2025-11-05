part of 'contacts_external_tab_bloc.dart';

sealed class ContactsExternalTabEvent extends Equatable {
  const ContactsExternalTabEvent();

  @override
  List<Object> get props => [];
}

class ContactsExternalTabStarted extends ContactsExternalTabEvent {
  const ContactsExternalTabStarted({required this.search});

  final String search;

  @override
  List<Object> get props => [
    EquatablePropToString([search], listPropToString),
  ];
}

class ContactsExternalTabRefreshed extends ContactsExternalTabEvent {
  const ContactsExternalTabRefreshed();
}
