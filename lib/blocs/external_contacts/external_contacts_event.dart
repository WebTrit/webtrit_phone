import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/external_contact.dart';

@immutable
abstract class ExternalContactsEvent extends Equatable {
  const ExternalContactsEvent();

  @override
  List<Object> get props => [];
}

class ExternalContactsInitialLoaded extends ExternalContactsEvent {
  const ExternalContactsInitialLoaded();
}

class ExternalContactsRefreshed extends ExternalContactsEvent {
  const ExternalContactsRefreshed();
}

class ExternalContactsUpdated extends ExternalContactsEvent {
  final List<ExternalContact> contacts;

  const ExternalContactsUpdated({
    @required this.contacts,
  });

  @override
  List<Object> get props => [
    contacts,
  ];
}
