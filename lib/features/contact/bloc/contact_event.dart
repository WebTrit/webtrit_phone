part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactStarted extends ContactEvent {
  const ContactStarted();
}

class ContactAddedToFavorites extends ContactEvent {
  const ContactAddedToFavorites(this.contactPhone);

  final ContactPhone contactPhone;

  @override
  List<Object> get props => [
    EquatablePropToString([contactPhone], listPropToString),
  ];
}

class ContactRemovedFromFavorites extends ContactEvent {
  const ContactRemovedFromFavorites(this.contactPhone);

  final ContactPhone contactPhone;

  @override
  List<Object> get props => [
    EquatablePropToString([contactPhone], listPropToString),
  ];
}

class ContactEmailSend extends ContactEvent {
  const ContactEmailSend(this.contactEmail);

  final ContactEmail contactEmail;

  @override
  List<Object> get props => [
    EquatablePropToString([contactEmail], listPropToString),
  ];
}
