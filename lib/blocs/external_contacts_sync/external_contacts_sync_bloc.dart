import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'external_contacts_sync_event.dart';

part 'external_contacts_sync_state.dart';

final _logger = Logger('ExternalContactsSyncBloc');

class ExternalContactsSyncBloc extends Bloc<ExternalContactsSyncEvent, ExternalContactsSyncState> {
  ExternalContactsSyncBloc({
    required this.userRepository,
    required this.externalContactsRepository,
    required this.appDatabase,
  }) : super(const ExternalContactsSyncInitial()) {
    on<ExternalContactsSyncStarted>(_onStarted, transformer: restartable());
    on<ExternalContactsSyncRefreshed>(_onRefreshed, transformer: droppable());
    on<_ExternalContactsSyncUpdated>(_onUpdated, transformer: droppable());
  }

  final UserRepository userRepository;
  final ExternalContactsRepository externalContactsRepository;
  final AppDatabase appDatabase;

  void _onStarted(ExternalContactsSyncStarted event, Emitter<ExternalContactsSyncState> emit) async {
    final externalContactsForEachFuture = emit.onEach<List<ExternalContact>>(
      externalContactsRepository.contacts(),
      onData: (contacts) => add(_ExternalContactsSyncUpdated(contacts: contacts)),
      onError: (e, stackTrace) => _logger.warning('_onStarted', e, stackTrace),
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

  Future _onUpdated(
    _ExternalContactsSyncUpdated event,
    Emitter<ExternalContactsSyncState> emit, {
    int retryCount = 0,
    UserInfo? userInfo,
  }) async {
    try {
      userInfo ??= await userRepository.getInfo();
    } catch (error) {
      emit(const ExternalContactsSyncRefreshFailure());
      return;
    }

    try {
      await appDatabase.transaction(() async {
        // skip external contact that represents own account
        final externalContacts =
            event.contacts.where((externalContact) => externalContact.id != userInfo!.numbers.main);

        final syncedExternalContactsIds =
            await appDatabase.contactsDao.getIdsBySourceType(ContactSourceTypeEnum.external);

        final updatedExternalContactsIds = externalContacts.map((externalContact) => externalContact.id).toSet();

        final delExternalContactsIds = syncedExternalContactsIds.difference(updatedExternalContactsIds);

        // to del
        for (final externalContactsId in delExternalContactsIds) {
          await appDatabase.contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, externalContactsId);
        }

        // to add or update
        for (final externalContact in externalContacts) {
          final insertOrUpdateContactData =
              await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(ContactDataCompanion(
            sourceType: const Value(ContactSourceTypeEnum.external),
            sourceId: Value(externalContact.id),
            firstName: Value(externalContact.firstName),
            lastName: Value(externalContact.lastName),
            aliasName: Value(externalContact.aliasName),
          ));

          final externalContactNumber = externalContact.number;
          final externalContactExt = externalContact.ext;
          final externalContactMobile = externalContact.mobile;

          final externalContactNumbers = [
            if (externalContactNumber != null) externalContactNumber,
            if (externalContactExt != null) externalContactExt,
            if (externalContactMobile != null) externalContactMobile,
          ];

          await appDatabase.contactPhonesDao
              .deleteOtherContactPhonesOfContactId(insertOrUpdateContactData.id, externalContactNumbers);

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

          final externalContactEmail = externalContact.email;

          final externalContactEmails = [
            if (externalContactEmail != null) externalContactEmail,
          ];

          await appDatabase.contactEmailsDao
              .deleteOtherContactEmailsOfContactId(insertOrUpdateContactData.id, externalContactEmails);

          if (externalContactEmail != null) {
            await appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(ContactEmailDataCompanion(
              address: Value(externalContactEmail),
              label: const Value(''),
              contactId: Value(insertOrUpdateContactData.id),
            ));
          }
        }
      });

      emit(const ExternalContactsSyncSuccess());
    } on Exception catch (_) {
      if (retryCount < 3) {
        await Future<void>.delayed(const Duration(seconds: 1));
        if (isClosed) return;
        await _onUpdated(event, emit, retryCount: retryCount + 1, userInfo: userInfo);
      } else {
        emit(const ExternalContactsSyncRefreshFailure());
      }
    }
  }
}
