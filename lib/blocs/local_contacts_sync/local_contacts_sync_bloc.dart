import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'local_contacts_sync_event.dart';

part 'local_contacts_sync_state.dart';

final _logger = Logger('LocalContactsSyncBloc');

typedef AsyncCallback = Future<bool> Function();

class LocalContactsSyncBloc extends Bloc<LocalContactsSyncEvent, LocalContactsSyncState> {
  LocalContactsSyncBloc({
    required this.localContactsRepository,
    required this.appDatabase,
    required this.contactsAgreementStatusRepository,
    required this.isFeatureEnabled,
    required this.isAgreementAccepted,
    required this.isContactsPermissionGranted,
    required this.requestContactPermission,
  }) : super(const LocalContactsSyncInitial()) {
    on<LocalContactsSyncStarted>(_onStarted, transformer: sequential());
    on<LocalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_LocalContactsSyncUpdated>(_onUpdated, transformer: droppable());
  }

  final LocalContactsRepository localContactsRepository;
  final AppDatabase appDatabase;
  final ContactsAgreementStatusRepository contactsAgreementStatusRepository;
  final AsyncCallback isFeatureEnabled;
  final AsyncCallback isAgreementAccepted;
  final AsyncCallback isContactsPermissionGranted;
  final AsyncCallback requestContactPermission;

  StreamSubscription<List<LocalContact>>? _contactsSubscription;

  void _onStarted(LocalContactsSyncStarted event, Emitter<LocalContactsSyncState> emit) async {
    _logger.finer('_onStarted');

    if (!(await isFeatureEnabled())) {
      emit(const ContactsFeatureDisabledException());
      return;
    }

    if (!(await isAgreementAccepted())) {
      emit(const ContactsAgreementMissingException());
      return;
    }

    if (!await requestContactPermission()) {
      emit(const LocalContactsSyncPermissionFailure());
      return;
    }

    _initContactsSubscription();

    add(const LocalContactsSyncRefreshed());
  }

  void _onRefreshed(LocalContactsSyncRefreshed event, Emitter<LocalContactsSyncState> emit) async {
    _logger.finer('_onRefreshed');

    if (!(await isFeatureEnabled())) {
      emit(const ContactsFeatureDisabledException());
      return;
    }

    if (!(await isAgreementAccepted())) {
      emit(const ContactsAgreementMissingException());
      return;
    }

    if (!await isContactsPermissionGranted()) {
      emit(const LocalContactsSyncPermissionFailure());
      return;
    }

    _initContactsSubscription();

    emit(const LocalContactsSyncRefreshInProgress());
    try {
      await localContactsRepository.load();
    } catch (error) {
      _logger.warning('_onRefreshed error: ', error);
      emit(const LocalContactsSyncRefreshFailure());
    }
  }

  Future _onUpdated(_LocalContactsSyncUpdated event, Emitter<LocalContactsSyncState> emit, {int retryCount = 0}) async {
    _logger.finer('_onUpdated contacts count:${event.contacts.length}');

    try {
      await appDatabase.transaction(() async {
        final localContacts = event.contacts;

        final syncedLocalContactsIds = await appDatabase.contactsDao.getContactsSourceIds(ContactSourceTypeEnum.local);
        final updatedLocalContactsIds = localContacts.map((localContact) => localContact.id).toSet();
        final delLocalContactsIds = syncedLocalContactsIds.difference(updatedLocalContactsIds);

        // to del
        for (final localContactsId in delLocalContactsIds) {
          await appDatabase.contactsDao.deleteContactBySource(ContactSourceTypeEnum.local, localContactsId);
        }

        // to add or update
        for (final localContact in localContacts) {
          final insertOrUpdateContactData = await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
            ContactDataCompanion(
              sourceType: const Value(ContactSourceTypeEnum.local),
              sourceId: Value(localContact.id),
              firstName: Value(localContact.firstName),
              lastName: Value(localContact.lastName),
              aliasName: Value(localContact.displayName),
              thumbnail: Value(localContact.thumbnail),
            ),
          );

          await appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(
            insertOrUpdateContactData.id,
            localContact.phones.map((phone) => phone.rawNumber),
          );

          for (final localContactPhone in localContact.phones) {
            await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
              ContactPhoneDataCompanion(
                rawNumber: Value(localContactPhone.rawNumber),
                sanitizedNumber: Value(localContactPhone.sanitizedNumber),
                label: Value(localContactPhone.label),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }

          await appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(
            insertOrUpdateContactData.id,
            localContact.emails.map((email) => email.address),
          );

          for (final localContactEmail in localContact.emails) {
            await appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
              ContactEmailDataCompanion(
                address: Value(localContactEmail.address),
                label: Value(localContactEmail.label),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }
        }
      });
      emit(const LocalContactsSyncSuccess());
    } on Exception catch (e) {
      _logger.warning('_onUpdated retry: $retryCount, error: ', e);

      if (retryCount < 3) {
        await Future<void>.delayed(const Duration(seconds: 1));
        if (isClosed) return;
        await _onUpdated(event, emit, retryCount: retryCount + 1);
      } else {
        emit(const LocalContactsSyncUpdateFailure());
      }
    }
  }

  void _initContactsSubscription() {
    if (_contactsSubscription != null) return;

    _logger.info('_initContactsSubscription: subscribing to contacts stream');
    _contactsSubscription = localContactsRepository.contacts().listen(
      (contacts) => add(_LocalContactsSyncUpdated(contacts: contacts)),
      onError: (error, stackTrace) => _logger.warning('Contacts stream error', error, stackTrace),
    );
  }

  @override
  Future<void> close() {
    _contactsSubscription?.cancel();
    return super.close();
  }
}
