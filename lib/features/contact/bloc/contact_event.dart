part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object?> get props => [];
}

class ContactStarted extends ContactEvent {
  const ContactStarted();
}

class ContactAddedToFavorites extends ContactEvent {
  const ContactAddedToFavorites(this.contactPhone, this.contact);

  final ContactPhone contactPhone;
  final Contact contact;

  @override
  List<Object?> get props => [contactPhone, contact];
}

class ContactRemovedFromFavorites extends ContactEvent {
  const ContactRemovedFromFavorites(this.contactPhone, this.contact);

  final ContactPhone contactPhone;
  final Contact contact;

  @override
  List<Object?> get props => [contactPhone, contact];
}

class ContactEmailSend extends ContactEvent {
  const ContactEmailSend(this.contactEmail);

  final ContactEmail contactEmail;

  @override
  List<Object?> get props => [contactEmail];
}
