part of 'contacts_local_tab_bloc.dart';

enum ContactsLocalTabStatus {
  initial,
  inProgress,
  success,
  failure,
  permissionFailure,
}

class ContactsLocalTabState extends Equatable {
  const ContactsLocalTabState({
    this.status = ContactsLocalTabStatus.initial,
    this.contacts = const [],
  });

  final ContactsLocalTabStatus status;
  final List<Contact> contacts;

  @override
  List<Object> get props => [
        status,
        contacts,
      ];

  ContactsLocalTabState copyWith({
    ContactsLocalTabStatus? status,
    List<Contact>? contacts,
  }) {
    return ContactsLocalTabState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
    );
  }
}
