part of 'contact_bloc.dart';

abstract class ContactEvent {
  const ContactEvent();
}

class ContactStarted extends ContactEvent {
  const ContactStarted();
}

@Freezed(copyWith: false)
abstract class ContactAddedToFavorites with _$ContactAddedToFavorites implements ContactEvent {
  const factory ContactAddedToFavorites(ContactPhone contactPhone) = _ContactAddedToFavorites;
}

@Freezed(copyWith: false)
abstract class ContactRemovedFromFavorites with _$ContactRemovedFromFavorites implements ContactEvent {
  const factory ContactRemovedFromFavorites(ContactPhone contactPhone) = _ContactRemovedFromFavorites;
}

@Freezed(copyWith: false)
abstract class ContactEmailSend with _$ContactEmailSend implements ContactEvent {
  const factory ContactEmailSend(ContactEmail contactEmail) = _ContactEmailSend;
}
