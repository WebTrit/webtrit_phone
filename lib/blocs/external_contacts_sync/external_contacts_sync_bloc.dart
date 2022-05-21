import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'external_contacts_sync_event.dart';

part 'external_contacts_sync_state.dart';

class ExternalContactsSyncBloc extends Bloc<ExternalContactsSyncEvent, ExternalContactsSyncState> {
  ExternalContactsSyncBloc({
    required this.externalContactsRepository,
    required this.appDatabase,
  }) : super(const ExternalContactsSyncInitial()) {
    on<ExternalContactsSyncStarted>(_onStarted, transformer: restartable());
    on<ExternalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_ExternalContactsSyncUpdated>(_onUpdated, transformer: droppable());
  }

  final ExternalContactsRepository externalContactsRepository;
  final AppDatabase appDatabase;

  void _onStarted(ExternalContactsSyncStarted event, Emitter<ExternalContactsSyncState> emit) async {
    final externalContactsForEachFuture = emit.onEach<List<ExternalContact>>(
      externalContactsRepository.contacts(),
      onData: (contacts) => add(_ExternalContactsSyncUpdated(contacts: contacts)),
    );

    add(const ExternalContactsSyncRefreshed());

    await externalContactsForEachFuture;
  }

  void _onRefreshed(ExternalContactsSyncRefreshed event, Emitter<ExternalContactsSyncState> emit) async {
    emit(const ExternalContactsSyncRefreshInProgress());
    try {
      await externalContactsRepository.load();
    } catch (error) {
      emit(const ExternalContactsSyncRefreshFailure());
    }
  }

  void _onUpdated(_ExternalContactsSyncUpdated event, Emitter<ExternalContactsSyncState> emit) async {
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

    emit(const ExternalContactsSyncSuccess());
  }
}
