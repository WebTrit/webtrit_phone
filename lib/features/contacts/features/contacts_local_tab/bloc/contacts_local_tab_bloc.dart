import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../contacts.dart';

part 'contacts_local_tab_event.dart';

part 'contacts_local_tab_state.dart';

class ContactsLocalTabBloc extends Bloc<ContactsLocalTabEvent, ContactsLocalTabState> with WidgetsBindingObserver {
  ContactsLocalTabBloc({
    required this.contactsRepository,
    required this.contactsSearchBloc,
    required this.localContactsSyncBloc,
  }) : super(const ContactsLocalTabState()) {
    on<ContactsLocalTabStarted>(_handleContactsLocalTabStarted, transformer: restartable());
    on<ContactsLocalTabRefreshed>(_handleContactsLocalTabRefreshed, transformer: droppable());

    WidgetsBinding.instance.addObserver(this);
  }

  final ContactsRepository contactsRepository;
  final ContactsSearchBloc contactsSearchBloc;
  final LocalContactsSyncBloc localContactsSyncBloc;

  @override
  Future<void> close() async {
    WidgetsBinding.instance.removeObserver(this);
    await super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (PlatformInfo().isAndroid) {
      if (lifecycleState == AppLifecycleState.resumed && state.status == ContactsLocalTabStatus.permissionFailure) {
        localContactsSyncBloc.add(const LocalContactsSyncRefreshed());
      }
    }
  }

  Future<void> _handleContactsLocalTabStarted(
      ContactsLocalTabStarted event, Emitter<ContactsLocalTabState> emit) async {
    final watchContactsForEachFuture = emit.forEach(
      contactsRepository.watchContacts(event.search, ContactSourceType.local),
      onData: (List<Contact> contacts) => ContactsLocalTabState(
        status: _mapLocalContactsSyncStateToStatus(localContactsSyncBloc.state),
        contacts: contacts,
        searching: event.search.isNotEmpty,
      ),
    );

    final contactsSearchSateOnEachFuture = emit.onEach(contactsSearchBloc.stream, onData: (String value) {
      add(ContactsLocalTabStarted(search: value));
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

  Future<void> _handleContactsLocalTabRefreshed(
      ContactsLocalTabRefreshed event, Emitter<ContactsLocalTabState> emit) async {
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
