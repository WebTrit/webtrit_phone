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

class LocalContactsSyncBloc extends Bloc<LocalContactsSyncEvent, LocalContactsSyncState> with WidgetsBindingObserver {
  LocalContactsSyncBloc({
    required this.localContactsRepository,
    required this.appDatabase,
  }) : super(const LocalContactsSyncInitial()) {
    on<LocalContactsSyncStarted>(_onStarted, transformer: restartable());
    on<LocalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_LocalContactsSyncUpdated>(_onUpdated, transformer: droppable());

    WidgetsBinding.instance.addObserver(this);
  }

  final LocalContactsRepository localContactsRepository;
  final AppDatabase appDatabase;

  @override
  Future<void> close() async {
    _logger.info('close');

    WidgetsBinding.instance.removeObserver(this);
    await super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.info('didChangeAppLifecycleState: $state');

    if (PlatformInfo().isAndroid) {
      if (state == AppLifecycleState.resumed && this.state is LocalContactsSyncPermissionFailure) {
        add(const LocalContactsSyncStarted());
      }
    }
  }

  void _onStarted(LocalContactsSyncStarted event, Emitter<LocalContactsSyncState> emit) async {
    _logger.info('_onStarted');

    if (!await localContactsRepository.requestPermission()) {
      _logger.warning('_onStarted permission failure');
      emit(const LocalContactsSyncPermissionFailure());
    } else {
      final localContactsForEachFuture = emit.onEach<List<LocalContact>>(
        localContactsRepository.contacts(),
        onData: (contacts) => add(_LocalContactsSyncUpdated(contacts: contacts)),
        onError: (error, stackTrace) => _logger.warning('_onStarted', error, stackTrace),
      );

      add(const LocalContactsSyncRefreshed());

      await localContactsForEachFuture;
    }
  }

  void _onRefreshed(LocalContactsSyncRefreshed event, Emitter<LocalContactsSyncState> emit) async {
    _logger.info('_onRefreshed');

    emit(const LocalContactsSyncRefreshInProgress());
    try {
      await localContactsRepository.load();
    } catch (error) {
      _logger.warning('_onRefreshed error: ', error);
      emit(const LocalContactsSyncRefreshFailure());
    }
  }

  Future _onUpdated(_LocalContactsSyncUpdated event, Emitter<LocalContactsSyncState> emit, {int retryCount = 0}) async {
    _logger.info('_onUpdated contacts count:${event.contacts.length}');

    try {
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
            firstName: Value(localContact.firstName),
            lastName: Value(localContact.lastName),
            aliasName: Value(localContact.displayName),
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
}
