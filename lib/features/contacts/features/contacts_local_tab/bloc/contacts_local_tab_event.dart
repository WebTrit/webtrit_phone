part of 'contacts_local_tab_bloc.dart';

sealed class ContactsLocalTabEvent extends Equatable {
  const ContactsLocalTabEvent();

  @override
  List<Object> get props => [];
}

class ContactsLocalTabStarted extends ContactsLocalTabEvent {
  const ContactsLocalTabStarted({required this.search});

  final String search;

  @override
  List<Object> get props => [
    EquatablePropToString([search], listPropToString),
  ];
}

class ContactsLocalTabRefreshed extends ContactsLocalTabEvent {
  const ContactsLocalTabRefreshed();
}
