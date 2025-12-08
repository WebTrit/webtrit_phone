part of 'contacts_external_tab_bloc.dart';

enum ContactsExternalTabStatus { initial, inProgress, success, failure }

class ContactsExternalTabState extends Equatable {
  const ContactsExternalTabState({
    this.status = ContactsExternalTabStatus.initial,
    this.contacts = const [],
    this.searching = false,
  });

  final ContactsExternalTabStatus status;
  final List<Contact> contacts;
  final bool searching;

  @override
  List<Object?> get props => [status, EquatablePropToString.list(contacts), searching];

  ContactsExternalTabState copyWith({ContactsExternalTabStatus? status, List<Contact>? contacts, bool? searching}) {
    return ContactsExternalTabState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      searching: searching ?? this.searching,
    );
  }
}
