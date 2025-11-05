part of 'contacts_local_tab_bloc.dart';

enum ContactsLocalTabStatus {
  initial,
  inProgress,
  success,
  failure,
  permissionFailure,
  contactsAgreementFailure,
}

class ContactsLocalTabState extends Equatable {
  const ContactsLocalTabState({
    this.status = ContactsLocalTabStatus.initial,
    this.contacts = const [],
    this.searching = false,
  });

  final ContactsLocalTabStatus status;
  final List<Contact> contacts;
  final bool searching;

  @override
  List<Object?> get props => [status, EquatablePropToString.list(contacts), searching];

  ContactsLocalTabState copyWith({
    ContactsLocalTabStatus? status,
    List<Contact>? contacts,
    bool? searching,
  }) {
    return ContactsLocalTabState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      searching: searching ?? this.searching,
    );
  }
}
