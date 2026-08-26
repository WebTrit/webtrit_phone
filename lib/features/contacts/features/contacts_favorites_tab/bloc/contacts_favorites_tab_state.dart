part of 'contacts_favorites_tab_bloc.dart';

/// Only the two a list without a fetch of its own can be in: nothing read yet,
/// or read. There is no failure here - see the note on the bloc.
enum ContactsFavoritesTabStatus { initial, success }

class ContactsFavoritesTabState extends Equatable {
  const ContactsFavoritesTabState({
    this.status = ContactsFavoritesTabStatus.initial,
    this.contacts = const [],
    this.searching = false,
  });

  final ContactsFavoritesTabStatus status;
  final List<Contact> contacts;
  final bool searching;

  @override
  List<Object?> get props => [status, EquatablePropToString.list(contacts), searching];

  ContactsFavoritesTabState copyWith({ContactsFavoritesTabStatus? status, List<Contact>? contacts, bool? searching}) {
    return ContactsFavoritesTabState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      searching: searching ?? this.searching,
    );
  }
}
