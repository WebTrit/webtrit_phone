import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../contacts.dart';

part 'contacts_external_tab_event.dart';

part 'contacts_external_tab_state.dart';

class ContactsExternalTabBloc extends Bloc<ContactsExternalTabEvent, ContactsExternalTabState> {
  ContactsExternalTabBloc({
    required this.contactsRepository,
    required this.contactsSearchBloc,
    required this.syncWorker,
  }) : super(const ContactsExternalTabState()) {
    on<ContactsExternalTabStarted>(_onStarted, transformer: restartable());
  }

  final ContactsRepository contactsRepository;
  final ContactsBloc contactsSearchBloc;
  final ExternalContactsSyncWorker syncWorker;

  Future<void> _onStarted(ContactsExternalTabStarted event, Emitter<ContactsExternalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.external),
      onData: (List<Contact> contacts) => state.copyWith(
        status: _mapSyncStatus(syncWorker.status),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchSateOnEachFuture = emit.onEach(
      contactsSearchBloc.stream,
      onData: (state) {
        add(ContactsExternalTabStarted(search: state.search));
      },
    );

    final syncStatusForEachFuture = emit.forEach(
      syncWorker.statusStream,
      onData: (ExternalContactsSyncStatus syncStatus) => state.copyWith(status: _mapSyncStatus(syncStatus)),
    );

    await Future.wait([watchContactsForEachFuture, contactsSearchSateOnEachFuture, syncStatusForEachFuture]);
  }

  ContactsExternalTabStatus _mapSyncStatus(ExternalContactsSyncStatus syncStatus) {
    return switch (syncStatus) {
      // The first sync cycle is still running, so keep the loading state.
      ExternalContactsSyncStatus.syncing => ContactsExternalTabStatus.inProgress,
      ExternalContactsSyncStatus.synced => ContactsExternalTabStatus.success,
      ExternalContactsSyncStatus.failed => ContactsExternalTabStatus.failure,
    };
  }
}
