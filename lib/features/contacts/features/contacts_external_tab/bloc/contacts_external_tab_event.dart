part of 'contacts_external_tab_bloc.dart';

@immutable
abstract class ContactsExternalTabEvent {
  const ContactsExternalTabEvent();
}

class ContactsExternalTabStarted extends ContactsExternalTabEvent {
  const ContactsExternalTabStarted({required this.search});

  final String search;
}

class ContactsExternalTabRefreshed extends ContactsExternalTabEvent {
  const ContactsExternalTabRefreshed();
}
