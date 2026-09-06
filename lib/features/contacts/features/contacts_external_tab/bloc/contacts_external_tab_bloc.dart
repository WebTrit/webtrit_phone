import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../contacts.dart';

part 'contacts_external_tab_event.dart';

part 'contacts_external_tab_state.dart';

class ContactsExternalTabBloc extends Bloc<ContactsExternalTabEvent, ContactsExternalTabState> {
  ContactsExternalTabBloc({required this.contactsRepository, required this.contactsSearchBloc, required this.syncTask})
    : super(const ContactsExternalTabState()) {
    on<ContactsExternalTabStarted>(_onStarted, transformer: restartable());
  }

  final ContactsRepository contactsRepository;
  final ContactsBloc contactsSearchBloc;
  final PollingTaskHandle syncTask;

  Future<void> _onStarted(ContactsExternalTabStarted event, Emitter<ContactsExternalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.external),
      onData: (List<Contact> contacts) => state.copyWith(
        status: _mapSyncPhase(syncTask.state.phase),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchStateOnEachFuture = emit.onEach(
      contactsSearchBloc.stream,
      onData: (state) => add(ContactsExternalTabStarted(search: state.search)),
    );

    final syncStateForEachFuture = emit.forEach(
      syncTask.states,
      onData: (PollingTaskState syncState) => state.copyWith(status: _mapSyncPhase(syncState.phase)),
    );

    await Future.wait([watchContactsForEachFuture, contactsSearchStateOnEachFuture, syncStateForEachFuture]);
  }

  ContactsExternalTabStatus _mapSyncPhase(PollingTaskPhase phase) {
    return switch (phase) {
      // Idle still precedes the first leading cycle, so an empty cache remains loading.
      PollingTaskPhase.idle || PollingTaskPhase.running => ContactsExternalTabStatus.inProgress,
      PollingTaskPhase.succeeded => ContactsExternalTabStatus.success,
      PollingTaskPhase.failed || PollingTaskPhase.stopped => ContactsExternalTabStatus.failure,
    };
  }
}
