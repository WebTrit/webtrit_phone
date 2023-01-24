import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'local_contacts_sync_event.dart';

part 'local_contacts_sync_state.dart';

class LocalContactsSyncBloc extends Bloc<LocalContactsSyncEvent, LocalContactsSyncState> {
  LocalContactsSyncBloc({
    required this.localContactsRepository,
    required this.appDatabase,
  }) : super(const LocalContactsSyncInitial()) {
    on<LocalContactsSyncStarted>(_onStarted, transformer: restartable());
    on<LocalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_LocalContactsSyncUpdated>(_onUpdated, transformer: droppable());
  }

  final LocalContactsRepository localContactsRepository;
  final AppDatabase appDatabase;

  void _onStarted(LocalContactsSyncStarted event, Emitter<LocalContactsSyncState> emit) async {
    final localContactsForEachFuture = emit.onEach<List<LocalContact>>(
      localContactsRepository.contacts(),
      onData: (contacts) => add(_LocalContactsSyncUpdated(contacts: contacts)),
      onError: (error, stackTrace) => add(const _LocalContactsSyncUpdated(contacts: [])),
    );

    add(const LocalContactsSyncRefreshed());

    await localContactsForEachFuture;
  }

  void _onRefreshed(LocalContactsSyncRefreshed event, Emitter<LocalContactsSyncState> emit) async {
    emit(const LocalContactsSyncRefreshInProgress());
    try {
      await localContactsRepository.load();
    } on LocalContactsRepositoryPermissionException {
      emit(const LocalContactsSyncPermissionFailure());
    } catch (error) {
      emit(const LocalContactsSyncRefreshFailure());
    }
  }

  void _onUpdated(_LocalContactsSyncUpdated event, Emitter<LocalContactsSyncState> emit) async {
    await appDatabase.transaction(() async {
      final localContacts = event.contacts;

      final contactDatas = await appDatabase.contactsDao.getAllContacts(ContactSourceTypeEnum.local);

      final syncedLocalContactsIds = contactDatas.map((contactData) => contactData.sourceId).toSet();

      final updatedLocalContactsIds = localContacts.map((localContact) => localContact.id).toSet();

      final delLocalContactsIds = syncedLocalContactsIds.difference(updatedLocalContactsIds);

      // to del
      for (final localContactsId in delLocalContactsIds) {
        await appDatabase.contactsDao.deleteContactBySource(ContactSourceTypeEnum.local, localContactsId);
      }

      // to add or update
      for (final localContact in localContacts) {
        final insertOrUpdateContactData =
            await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
          sourceType: const Value(ContactSourceTypeEnum.local),
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

        await appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(
            insertOrUpdateContactData.id, localContact.emails.map((email) => email.address));

        for (final localContactEmail in localContact.emails) {
          await appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
            address: Value(localContactEmail.address),
            label: Value(localContactEmail.label),
            contactId: Value(insertOrUpdateContactData.id),
          ));
        }
      }
    });

    emit(const LocalContactsSyncSuccess());
  }
}
