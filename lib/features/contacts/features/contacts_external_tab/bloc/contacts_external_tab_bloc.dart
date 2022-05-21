import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../../contacts.dart';

part 'contacts_external_tab_event.dart';

part 'contacts_external_tab_state.dart';

class ContactsExternalTabBloc extends Bloc<ContactsExternalTabEvent, ContactsExternalTabState> {
  ContactsExternalTabBloc({
    required this.contactsRepository,
    required this.contactsSearchBloc,
    required this.externalContactsSyncBloc,
  }) : super(const ContactsExternalTabState()) {
    on<ContactsExternalTabStarted>(_handleContactsExternalTabStarted, transformer: restartable());
    on<ContactsExternalTabRefreshed>(_handleContactsExternalTabRefreshed, transformer: droppable());
  }

  final ContactsRepository contactsRepository;
  final ContactsSearchBloc contactsSearchBloc;
  final ExternalContactsSyncBloc externalContactsSyncBloc;

  Future<void> _handleContactsExternalTabStarted(
      ContactsExternalTabStarted event, Emitter<ContactsExternalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.external),
      onData: (List<Contact> contacts) => state.copyWith(
        status: _mapExternalContactsSyncStateToStatus(externalContactsSyncBloc.state),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchSateOnEachFuture = emit.onEach(contactsSearchBloc.stream, onData: (String value) {
      add(ContactsExternalTabStarted(search: value));
    });

    final externalContactsSyncStateForEachFuture = emit.forEach(
      externalContactsSyncBloc.stream,
      onData: (ExternalContactsSyncState externalContactsSyncState) => state.copyWith(
        status: _mapExternalContactsSyncStateToStatus(externalContactsSyncState),
      ),
    );

    await Future.wait([
      watchContactsForEachFuture,
      contactsSearchSateOnEachFuture,
      externalContactsSyncStateForEachFuture,
    ]);
  }

  Future<void> _handleContactsExternalTabRefreshed(
      ContactsExternalTabRefreshed event, Emitter<ContactsExternalTabState> emit) async {
    externalContactsSyncBloc.add(const ExternalContactsSyncRefreshed());
  }

  ContactsExternalTabStatus _mapExternalContactsSyncStateToStatus(ExternalContactsSyncState externalContactsSyncState) {
    if (externalContactsSyncState is ExternalContactsSyncRefreshInProgress) {
      return ContactsExternalTabStatus.inProgress;
    } else if (externalContactsSyncState is ExternalContactsSyncSuccess) {
      return ContactsExternalTabStatus.success;
    } else {
      return ContactsExternalTabStatus.failure;
    }
  }
}
