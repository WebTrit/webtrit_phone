part of 'contacts_local_tab_bloc.dart';

sealed class ContactsLocalTabEvent {
  const ContactsLocalTabEvent();
}

class ContactsLocalTabStarted extends ContactsLocalTabEvent {
  const ContactsLocalTabStarted({required this.search});

  final String search;
}

class ContactsLocalTabRefreshed extends ContactsLocalTabEvent {
  const ContactsLocalTabRefreshed();
}
