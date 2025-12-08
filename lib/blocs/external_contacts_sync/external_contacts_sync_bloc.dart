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
    _logger.finer('_onStarted');

    final externalContactsForEachFuture = emit.onEach<List<ExternalContact>>(
      externalContactsRepository.contacts(),
      onData: (contacts) {
        return add(_ExternalContactsSyncUpdated(contacts: contacts));
      },
      onError: (e, stackTrace) => _logger.warning('_onStarted', e, stackTrace),
    );

    add(const ExternalContactsSyncRefreshed());

    await externalContactsForEachFuture;
  }

  void _onRefreshed(ExternalContactsSyncRefreshed event, Emitter<ExternalContactsSyncState> emit) async {
    _logger.finer('_onRefreshed');

    emit(const ExternalContactsSyncRefreshInProgress());
    try {
      await externalContactsRepository.load();
    } catch (error) {
      _logger.warning('_onRefreshed error: ', error);
      emit(const ExternalContactsSyncRefreshFailure());
    }
  }

  Future _onUpdated(
    _ExternalContactsSyncUpdated event,
    Emitter<ExternalContactsSyncState> emit, {
    int retryCount = 0,
    UserInfo? userInfo,
  }) async {
    _logger.finer('_onUpdated contacts count:${event.contacts.length}');

    try {
      userInfo ??= await userRepository.getInfo();
    } catch (error) {
      _logger.warning('_onUpdated userInfo error: ', error);
      emit(const ExternalContactsSyncRefreshFailure());
      return;
    }

    try {
      await appDatabase.transaction(() async {
        // Remove legacy or invalid external contacts that were previously stored without a proper sourceId,
        // which may cause duplication or prevent accurate sync updates.
        await appDatabase.contactsDao.deleteContactsWithNullSourceId(ContactSourceTypeEnum.external);

        // skip external contact that represents own account
        final externalContacts = event.contacts.where(
          (externalContact) => externalContact.id != userInfo!.numbers.main,
        );

        final syncedExternalContactsIds = await appDatabase.contactsDao.getContactsSourceIds(
          ContactSourceTypeEnum.external,
        );

        final updatedExternalContactsIds = externalContacts.map((externalContact) => externalContact.id).toSet();
        final delExternalContactsIds = syncedExternalContactsIds.difference(updatedExternalContactsIds);

        // to del
        for (final externalContactsId in delExternalContactsIds) {
          await appDatabase.contactsDao.deleteContactBySource(ContactSourceTypeEnum.external, externalContactsId);
        }

        // to add or update
        for (final externalContact in externalContacts) {
          final insertOrUpdateContactData = await appDatabase.contactsDao.insertOnUniqueConflictUpdateContact(
            ContactDataCompanion(
              sourceType: const Value(ContactSourceTypeEnum.external),
              // Ensure a stable and unique sourceId for deduplication and upsert logic.
              // Falls back to contact number, email, or a hashed identity if no API-provided ID is available.
              sourceId: Value(externalContact.safeSourceId),
              firstName: Value(externalContact.firstName),
              lastName: Value(externalContact.lastName),
              aliasName: Value(externalContact.aliasName),
              registered: Value(externalContact.registered),
              userRegistered: Value(externalContact.userRegistered),
              isCurrentUser: Value(externalContact.isCurrentUser),
            ),
          );

          final externalContactNumber = externalContact.number;
          final externalContactExt = externalContact.ext;
          final externalContactAdditional = externalContact.additional;
          final externalSmsNumbers = externalContact.smsNumbers;

          final externalContactNumbers = [
            if (externalContactNumber != null) externalContactNumber,
            if (externalContactExt != null) externalContactExt,
            if (externalContactAdditional != null) ...externalContactAdditional,
            if (externalSmsNumbers != null) ...externalSmsNumbers,
          ];

          await appDatabase.contactPhonesDao.deleteOtherContactPhonesOfContactId(
            insertOrUpdateContactData.id,
            externalContactNumbers,
          );

          if (externalContactNumber != null) {
            await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
              ContactPhoneDataCompanion(
                number: Value(externalContactNumber),
                label: const Value('number'),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }
          if (externalContactExt != null) {
            await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
              ContactPhoneDataCompanion(
                number: Value(externalContactExt),
                label: const Value('ext'),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }
          if (externalSmsNumbers != null) {
            for (final externalSmsNumber in externalSmsNumbers) {
              await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
                ContactPhoneDataCompanion(
                  number: Value(externalSmsNumber),
                  label: const Value('sms'),
                  contactId: Value(insertOrUpdateContactData.id),
                ),
              );
            }
          }
          if (externalContactAdditional != null) {
            for (final externalContactAdditionalNumber in externalContactAdditional) {
              await appDatabase.contactPhonesDao.insertOnUniqueConflictUpdateContactPhone(
                ContactPhoneDataCompanion(
                  number: Value(externalContactAdditionalNumber),
                  label: const Value('additional'),
                  contactId: Value(insertOrUpdateContactData.id),
                ),
              );
            }
          }

          final externalContactEmail = externalContact.email;

          final externalContactEmails = [if (externalContactEmail != null) externalContactEmail];

          await appDatabase.contactEmailsDao.deleteOtherContactEmailsOfContactId(
            insertOrUpdateContactData.id,
            externalContactEmails,
          );

          if (externalContactEmail != null) {
            await appDatabase.contactEmailsDao.insertOnUniqueConflictUpdateContactEmail(
              ContactEmailDataCompanion(
                address: Value(externalContactEmail),
                label: const Value(''),
                contactId: Value(insertOrUpdateContactData.id),
              ),
            );
          }
        }
      });

      emit(const ExternalContactsSyncSuccess());
    } on Exception catch (e) {
      _logger.warning('_onUpdated retry: $retryCount, error: ', e);

      if (retryCount < 3) {
        await Future<void>.delayed(const Duration(seconds: 1));
        if (isClosed) return;
        await _onUpdated(event, emit, retryCount: retryCount + 1, userInfo: userInfo);
      } else {
        emit(const ExternalContactsSyncUpdateFailure());
      }
    }
  }
}

/// Extension to provide a stable sourceId for ExternalContact
extension ExternalContactExtensions on ExternalContact {
  /// Returns a stable, non-null sourceId for synchronization and deduplication purposes.
  /// Priority:
  ///   1. `id` (API-provided unique identifier)
  ///   2. `number`, `mobile`, `email`
  ///   3. deterministic hash of name/email
  ///   4. fallback hash for anonymous or incomplete contacts (e.g. empty fields)
  String get safeSourceId {
    if (id?.trim().isNotEmpty ?? false) {
      return id!;
    }

    if (number?.trim().isNotEmpty ?? false) {
      return 'number_${number!.trim()}';
    }

    if (email?.trim().isNotEmpty ?? false) {
      return 'email_${email!.trim()}';
    }

    // Generate a deterministic fallback sourceId based on contact's name and email.
    // Ensures stable identity across syncs when no ID, number, mobile, or email is available.
    // May still produce collisions if fields are empty or identical across multiple contacts.
    final stableKey = '${firstName ?? ''}_${lastName ?? ''}_${email ?? ''}'.toLowerCase().trim();
    final hash = stableKey.hashCode;

    return 'hash_$hash';
  }
}
