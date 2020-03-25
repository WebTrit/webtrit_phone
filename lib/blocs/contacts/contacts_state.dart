import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/contact.dart';

@immutable
abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {
  const ContactsInitial();
}

class ContactsLoadSuccess extends ContactsState {
  final List<Contact> contacts;

  const ContactsLoadSuccess({
    @required this.contacts,
  });

  @override
  List<Object> get props => [
    contacts,
  ];
}

// This state is used to release RefreshIndicator
class ContactsLoadUnchangedSuccess extends ContactsLoadSuccess {
  const ContactsLoadUnchangedSuccess();

  @override
  bool operator ==(Object other) => identical(this, other);
}

abstract class ContactsLoadFailure extends ContactsState {
  const ContactsLoadFailure();

  @override
  bool operator ==(Object other) => identical(this, other);
}

class ContactsInitialLoadFailure extends ContactsLoadFailure {
  const ContactsInitialLoadFailure();
}

class ContactsRefreshFailure extends ContactsLoadFailure {
  const ContactsRefreshFailure();
}
