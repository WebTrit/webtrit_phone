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
  ContactsExternalTabBloc({
    required this.contactsRepository,
    required this.contactsSearchBloc,
    required this.syncState,
    required this.syncRunner,
  }) : super(const ContactsExternalTabState()) {
    on<ContactsExternalTabStarted>(_onStarted, transformer: restartable());
    on<_ContactsExternalTabRefreshRequested>(_onRefreshRequested);
  }

  final ContactsRepository contactsRepository;
  final ContactsBloc contactsSearchBloc;
  final PollingTaskStateSource syncState;
  final PollingTaskRunner syncRunner;

  /// Requests a manual refresh and completes with its domain result.
  ///
  /// The private event routes state transitions through the BLoC, while the
  /// returned future gives the refresh UI an exact completion boundary.
  Future<bool> refresh() {
    final event = _ContactsExternalTabRefreshRequested();
    add(event);
    return event.completed;
  }

  Future<void> _onStarted(ContactsExternalTabStarted event, Emitter<ContactsExternalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.external),
      onData: (List<Contact> contacts) => state.copyWith(
        status: _mapSyncPhase(syncState.state.phase),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchStateOnEachFuture = emit.onEach(
      contactsSearchBloc.stream,
      onData: (state) => add(ContactsExternalTabStarted(search: state.search)),
    );

    final syncStateForEachFuture = emit.forEach(
      syncState.states,
      onData: (PollingTaskState taskState) => state.copyWith(status: _mapSyncPhase(taskState.phase)),
    );

    await Future.wait([watchContactsForEachFuture, contactsSearchStateOnEachFuture, syncStateForEachFuture]);
  }

  Future<void> _onRefreshRequested(
    _ContactsExternalTabRefreshRequested event,
    Emitter<ContactsExternalTabState> emit,
  ) async {
    emit(state.copyWith(status: ContactsExternalTabStatus.inProgress));

    var succeeded = false;
    try {
      await syncRunner.runNow();
      succeeded = true;
      if (!emit.isDone) {
        emit(state.copyWith(status: ContactsExternalTabStatus.success));
      }
    } catch (_) {
      if (!emit.isDone) {
        emit(state.copyWith(status: ContactsExternalTabStatus.failure));
      }
    } finally {
      event.complete(succeeded: succeeded);
    }
  }

  ContactsExternalTabStatus _mapSyncPhase(PollingTaskPhase phase) {
    return switch (phase) {
      // Idle still precedes the first leading cycle, so an empty cache remains loading.
      PollingTaskPhase.idle || PollingTaskPhase.running => ContactsExternalTabStatus.inProgress,
      PollingTaskPhase.succeeded => ContactsExternalTabStatus.success,
      PollingTaskPhase.waitingForConnectivity ||
      PollingTaskPhase.failed ||
      PollingTaskPhase.stopped => ContactsExternalTabStatus.failure,
    };
  }
}
