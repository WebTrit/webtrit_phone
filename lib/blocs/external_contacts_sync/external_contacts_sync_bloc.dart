import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'external_contacts_sync_event.dart';

part 'external_contacts_sync_state.dart';

class ExternalContactsSyncBloc extends Bloc<ExternalContactsSyncEvent, ExternalContactsSyncState> {
  ExternalContactsSyncBloc({
    required this.externalContactsRepository,
    required this.appDatabase,
  }) : super(const ExternalContactsSyncInitial());

  final ExternalContactsRepository externalContactsRepository;
  final AppDatabase appDatabase;

  StreamSubscription? _externalContactsSubscription;

  @override
  Stream<ExternalContactsSyncState> mapEventToState(ExternalContactsSyncEvent event) async* {
    if (event is ExternalContactsSyncStarted) {
      yield* _mapExternalContactsSyncStartedToState(event);
    } else if (event is ExternalContactsSyncRefreshed) {
      yield* _mapExternalContactsSyncRefreshedToState(event);
    } else if (event is _ExternalContactsSyncUpdated) {
      yield* _mapExternalContactsSyncUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _externalContactsSubscription?.cancel();
    return super.close();
  }

  Stream<ExternalContactsSyncState> _mapExternalContactsSyncStartedToState(ExternalContactsSyncStarted event) async* {
    _externalContactsSubscription?.cancel();
    _externalContactsSubscription = externalContactsRepository.contacts().listen(
          (contacts) => add(_ExternalContactsSyncUpdated(contacts: contacts)),
        );

    yield const ExternalContactsSyncRefreshInProgress();
    try {
      await externalContactsRepository.load();
    } catch (error) {
      yield const ExternalContactsSyncRefreshFailure();
    }
  }

  Stream<ExternalContactsSyncState> _mapExternalContactsSyncRefreshedToState(
      ExternalContactsSyncRefreshed event) async* {
    yield const ExternalContactsSyncRefreshInProgress();
    try {
      await externalContactsRepository.load();
    } catch (error) {
      yield const ExternalContactsSyncRefreshFailure();
    }
  }

  Stream<ExternalContactsSyncState> _mapExternalContactsSyncUpdatedToState(_ExternalContactsSyncUpdated event) async* {
    final externalContacts = event.contacts;

    final contactDatas = await appDatabase.contactsDao.getAllContacts(ContactSourceType.external);

    final syncedExternalContactsIds = contactDatas.map((contactData) => contactData.sourceId).toSet();
    final updatedExternalContactsIds = externalContacts.map((externalContact) => externalContact.id).toSet();

    final delExternalContactsIds = syncedExternalContactsIds.difference(updatedExternalContactsIds);

    // to del
    for (final externalContactsId in delExternalContactsIds) {
      await appDatabase.contactsDao.deleteContactBySource(ContactSourceType.external, externalContactsId);
    }

    // to add or update
    for (final externalContact in externalContacts) {
      final insertOrUpdateContactData =
          await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
        sourceType: const Value(ContactSourceType.external),
        sourceId: Value(externalContact.id),
        displayName: Value(externalContact.displayName),
        firstName: Value(externalContact.firstName),
        lastName: Value(externalContact.lastName),
      ));

      final externalContactNumber = externalContact.number;
      final externalContactExt = externalContact.ext;
      final externalContactMobile = externalContact.mobile;

      final localContactNumbers = [
        if (externalContactNumber != null) externalContactNumber,
        if (externalContactExt != null) externalContactExt,
        if (externalContactMobile != null) externalContactMobile,
      ];

      await appDatabase.contactPhonesDao
          .deleteOtherContactPhonesOfContactId(insertOrUpdateContactData.id, localContactNumbers);

      if (externalContactNumber != null) {
        await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
          number: Value(externalContactNumber),
          label: const Value('number'),
          contactId: Value(insertOrUpdateContactData.id),
        ));
      }
      if (externalContactExt != null) {
        await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
          number: Value(externalContactExt),
          label: const Value('ext'),
          contactId: Value(insertOrUpdateContactData.id),
        ));
      }
      if (externalContactMobile != null) {
        await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(ContactPhoneDataCompanion(
          number: Value(externalContactMobile),
          label: const Value('mobile'),
          contactId: Value(insertOrUpdateContactData.id),
        ));
      }
    }

    yield const ExternalContactsSyncSuccess();
  }
}
