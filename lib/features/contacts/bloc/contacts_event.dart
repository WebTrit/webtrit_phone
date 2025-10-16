part of 'contacts_bloc.dart';

abstract class ContactsEvent {
  const ContactsEvent();
}

@Freezed(copyWith: false)
abstract class ContactsSourceTypeChanged with _$ContactsSourceTypeChanged implements ContactsEvent {
  const factory ContactsSourceTypeChanged(ContactSourceType sourceType) = _ContactsSourceTypeChanged;
}

@Freezed(copyWith: false)
abstract class ContactsSearchChanged with _$ContactsSearchChanged implements ContactsEvent {
  const factory ContactsSearchChanged(String search) = _ContactsSearchChanged;
}

@Freezed(copyWith: false)
abstract class ContactsSearchSubmitted with _$ContactsSearchSubmitted implements ContactsEvent {
  const factory ContactsSearchSubmitted(String search) = _ContactsSearchSubmitted;
}
