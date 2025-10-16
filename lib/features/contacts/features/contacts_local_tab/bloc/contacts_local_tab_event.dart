part of 'contacts_local_tab_bloc.dart';

abstract class ContactsLocalTabEvent {
  const ContactsLocalTabEvent();
}

@Freezed(copyWith: false)
abstract class ContactsLocalTabStarted with _$ContactsLocalTabStarted implements ContactsLocalTabEvent {
  const factory ContactsLocalTabStarted({required String search}) = _ContactsLocalTabStarted;
}

@Freezed(copyWith: false)
class ContactsLocalTabRefreshed with _$ContactsLocalTabRefreshed implements ContactsLocalTabEvent {
  const factory ContactsLocalTabRefreshed() = _ContactsLocalTabRefreshed;
}
