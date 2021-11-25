import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'local_contacts_sync_event.dart';

part 'local_contacts_sync_state.dart';

class LocalContactsSyncBloc extends Bloc<LocalContactsSyncEvent, LocalContactsSyncState> {
  LocalContactsSyncBloc({
    required this.localContactsRepository,
    required this.appDatabase,
  }) : super(const LocalContactsSyncInitial());

  final LocalContactsRepository localContactsRepository;
  final AppDatabase appDatabase;

  StreamSubscription? _localContactsSubscription;

  @override
  Stream<LocalContactsSyncState> mapEventToState(LocalContactsSyncEvent event) async* {
    if (event is LocalContactsSyncStarted) {
      yield* _mapLocalContactsSyncStartedToState(event);
    } else if (event is LocalContactsSyncRefreshed) {
      yield* _mapLocalContactsSyncRefreshedToState(event);
    } else if (event is _LocalContactsSyncUpdated) {
      yield* _mapLocalContactsSyncUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _localContactsSubscription?.cancel();
    return super.close();
  }

  Stream<LocalContactsSyncState> _mapLocalContactsSyncStartedToState(LocalContactsSyncStarted event) async* {
    _localContactsSubscription?.cancel();
    _localContactsSubscription = localContactsRepository.contacts().listen(
          (contacts) => add(_LocalContactsSyncUpdated(contacts: contacts)),
          onError: (error, stackTrace) => add(const _LocalContactsSyncUpdated(contacts: [])),
          cancelOnError: false,
        );

    yield const LocalContactsSyncRefreshInProgress();
    try {
      await localContactsRepository.load();
    } on LocalContactsRepositoryPermissionException {
      yield const LocalContactsSyncPermissionFailure();
    } catch (error) {
      yield const LocalContactsSyncRefreshFailure();
    }
  }

  Stream<LocalContactsSyncState> _mapLocalContactsSyncRefreshedToState(LocalContactsSyncRefreshed event) async* {
    yield const LocalContactsSyncRefreshInProgress();
    try {
      await localContactsRepository.load();
    } on LocalContactsRepositoryPermissionException {
      yield const LocalContactsSyncPermissionFailure();
    } catch (error) {
      yield const LocalContactsSyncRefreshFailure();
    }
  }

  Stream<LocalContactsSyncState> _mapLocalContactsSyncUpdatedToState(_LocalContactsSyncUpdated event) async* {
    final localContacts = event.contacts;

    final contactDatas = await appDatabase.contactsDao.getAllContacts(ContactSourceType.local);

    final syncedLocalContactsIds = contactDatas.map((contactData) => contactData.sourceId).toSet();

    final updatedLocalContactsIds = localContacts.map((localContact) => localContact.id).toSet();

    final delLocalContactsIds = syncedLocalContactsIds.difference(updatedLocalContactsIds);

    // to del
    for (final localContactsId in delLocalContactsIds) {
      await appDatabase.contactsDao.deleteContactBySource(ContactSourceType.local, localContactsId);
    }

    // to add or update
    for (final localContact in localContacts) {
      final insertOrUpdateContactData =
          await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
        sourceType: const Value(ContactSourceType.local),
        sourceId: Value(localContact.id),
        displayName: Value(localContact.displayName),
        firstName: Value(localContact.firstName),
        lastName: Value(localContact.lastName),
      ));

      await appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(
          insertOrUpdateContactData.id, localContact.phones.map((phone) => phone.number));

      for (final localContactPhone in localContact.phones) {
        await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
          number: Value(localContactPhone.number),
          label: Value(localContactPhone.label),
          contactId: Value(insertOrUpdateContactData.id),
        ));
      }
    }

    yield const LocalContactsSyncSuccess();
  }
}
