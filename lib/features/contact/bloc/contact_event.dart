part of 'contact_bloc.dart';

sealed class ContactEvent {
  const ContactEvent();
}

class ContactStarted extends ContactEvent {
  const ContactStarted();
}

class ContactAddedToFavorites extends ContactEvent {
  const ContactAddedToFavorites(this.contactPhone);

  final ContactPhone contactPhone;
}

class ContactRemovedFromFavorites extends ContactEvent {
  const ContactRemovedFromFavorites(this.contactPhone);

  final ContactPhone contactPhone;
}

class ContactEmailSend extends ContactEvent {
  const ContactEmailSend(this.contactEmail);

  final ContactEmail contactEmail;
}
