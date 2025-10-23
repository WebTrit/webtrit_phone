part of 'contacts_bloc.dart';

sealed class ContactsEvent {
  const ContactsEvent();
}

class ContactsSourceTypeChanged extends ContactsEvent {
  const ContactsSourceTypeChanged(this.sourceType);

  final ContactSourceType sourceType;
}

class ContactsSearchChanged extends ContactsEvent {
  const ContactsSearchChanged(this.search);

  final String search;
}

class ContactsSearchSubmitted extends ContactsEvent {
  const ContactsSearchSubmitted(this.search);

  final String search;
}