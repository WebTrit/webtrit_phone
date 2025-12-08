part of 'contacts_bloc.dart';

sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

class ContactsSourceTypeChanged extends ContactsEvent {
  const ContactsSourceTypeChanged(this.sourceType);

  final ContactSourceType sourceType;

  @override
  List<Object?> get props => [sourceType];
}

class ContactsSearchChanged extends ContactsEvent {
  const ContactsSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class ContactsSearchSubmitted extends ContactsEvent {
  const ContactsSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}
