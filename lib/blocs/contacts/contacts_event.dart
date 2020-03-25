import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/contact.dart';

@immutable
abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactsInitialLoaded extends ContactsEvent {
  const ContactsInitialLoaded();
}

class ContactsRefreshed extends ContactsEvent {
  const ContactsRefreshed();
}

class ContactsUpdated extends ContactsEvent {
  final List<Contact> contacts;

  const ContactsUpdated({
    @required this.contacts,
  });

  @override
  List<Object> get props => [
    contacts,
  ];
}
