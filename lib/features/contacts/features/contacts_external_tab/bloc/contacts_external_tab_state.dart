part of 'contacts_external_tab_bloc.dart';

enum ContactsExternalTabStatus {
  initial,
  inProgress,
  success,
  failure,
}

class ContactsExternalTabState extends Equatable {
  const ContactsExternalTabState({
    this.status = ContactsExternalTabStatus.initial,
    this.contacts = const [],
  });

  final ContactsExternalTabStatus status;
  final List<Contact> contacts;

  @override
  List<Object> get props => [
        status,
        contacts,
      ];

  ContactsExternalTabState copyWith({
    ContactsExternalTabStatus? status,
    List<Contact>? contacts,
  }) {
    return ContactsExternalTabState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
    );
  }
}
