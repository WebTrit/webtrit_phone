import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../contacts.dart';

part 'contacts_local_tab_bloc.freezed.dart';

part 'contacts_local_tab_event.dart';

part 'contacts_local_tab_state.dart';

class ContactsLocalTabBloc extends Bloc<ContactsLocalTabEvent, ContactsLocalTabState> {
  ContactsLocalTabBloc({
    required this.contactsRepository,
    required this.contactsSearchBloc,
    required this.localContactsSyncBloc,
  }) : super(const ContactsLocalTabState()) {
    on<ContactsLocalTabStarted>(_onStarted, transformer: restartable());
    on<ContactsLocalTabRefreshed>(_onRefreshed, transformer: droppable());
  }

  final ContactsRepository contactsRepository;
  final ContactsBloc contactsSearchBloc;
  final LocalContactsSyncBloc localContactsSyncBloc;

  Future<void> _onStarted(ContactsLocalTabStarted event, Emitter<ContactsLocalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.local),
      onData: (List<Contact> contacts) => ContactsLocalTabState(
        status: _mapLocalContactsSyncStateToStatus(localContactsSyncBloc.state),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchSateOnEachFuture = emit.onEach(contactsSearchBloc.stream, onData: (state) {
      add(ContactsLocalTabStarted(search: state.search));
    });

    final localContactsSyncStateForEachFuture = emit.forEach(
      localContactsSyncBloc.stream,
      onData: (LocalContactsSyncState localContactsSyncState) => state.copyWith(
        status: _mapLocalContactsSyncStateToStatus(localContactsSyncState),
      ),
    );

    await Future.wait([
      watchContactsForEachFuture,
      contactsSearchSateOnEachFuture,
      localContactsSyncStateForEachFuture,
    ]);
  }

  Future<void> _onRefreshed(ContactsLocalTabRefreshed event, Emitter<ContactsLocalTabState> emit) async {
    localContactsSyncBloc.add(const LocalContactsSyncRefreshed());
  }

  ContactsLocalTabStatus _mapLocalContactsSyncStateToStatus(LocalContactsSyncState localContactsSyncState) {
    if (localContactsSyncState is LocalContactsSyncRefreshInProgress) {
      return ContactsLocalTabStatus.inProgress;
    } else if (localContactsSyncState is LocalContactsSyncSuccess) {
      return ContactsLocalTabStatus.success;
    } else if (localContactsSyncState is LocalContactsSyncPermissionFailure) {
      return ContactsLocalTabStatus.permissionFailure;
    } else {
      return ContactsLocalTabStatus.failure;
    }
  }
}
