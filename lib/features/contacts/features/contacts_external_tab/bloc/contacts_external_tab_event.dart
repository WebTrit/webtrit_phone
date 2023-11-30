part of 'contacts_external_tab_bloc.dart';

abstract class ContactsExternalTabEvent {
  const ContactsExternalTabEvent();
}

@Freezed(copyWith: false)
class ContactsExternalTabStarted with _$ContactsExternalTabStarted implements ContactsExternalTabEvent {
  const factory ContactsExternalTabStarted({required String search}) = _ContactsExternalTabStarted;
}

@Freezed(copyWith: false)
class ContactsExternalTabRefreshed with _$ContactsExternalTabRefreshed implements ContactsExternalTabEvent {
  const factory ContactsExternalTabRefreshed() = _ContactsExternalTabRefreshed;
}
