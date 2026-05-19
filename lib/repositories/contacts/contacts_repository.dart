import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'contacts_local_data_source.dart';
import 'contacts_remote_datasource.dart';

final _logger = Logger('ContactsRepository');

/// Repository responsible for managing contact data and orchestrating synchronization.
///
/// **Architecture Note:**
/// This repository currently holds a direct dependency on [AppDatabase].
///
/// **TODO(Refactoring):**
/// The goal is to migrate all direct database interactions (Drift logic) into
/// the [ContactsLocalDataSource]. The Repository should strictly act as a mediator
/// between the Local and Remote data sources, without knowing about the underlying
/// database implementation.
///
/// Once all logic is migrated, the [AppDatabase] dependency and related mappers
/// should be removed from this class.
class ContactsRepository
    with PresenceInfoDriftMapper, DialogInfoDriftMapper, ContactsDriftMapper, ExternalContactApiMapper {
  ContactsRepository({
    // TODO: Remove this dependency after migrating logic to ContactsLocalDataSource
    required AppDatabase appDatabase,
    required ContactsRemoteDataSource? contactsRemoteDataSource,
    required ContactsLocalDataSource? contactsLocalDataSource,
  }) : _appDatabase = appDatabase,
       _contactsRemoteDataSource = contactsRemoteDataSource,
       _contactsLocalDataSource = contactsLocalDataSource;

  final AppDatabase _appDatabase;
  final ContactsRemoteDataSource? _contactsRemoteDataSource;
  final ContactsLocalDataSource? _contactsLocalDataSource;

  /// Pool of [Completer] objects used to manage concurrent network fetching for the same contact source ID.
  ///
  /// This avoids **redundant network requests** if a contact is requested multiple times
  /// before the initial fetch completes. When a fetch is triggered for a specific [sourceId],
  /// a [Completer] is created and stored. Subsequent requests for the same [sourceId] will
  /// simply await the existing [Completer]'s future instead of initiating a new network call.
  final _externalContactFetchLocks = <String, Completer<void>>{};

  Stream<List<Contact>> watchContacts(String search, [ContactSourceType? sourceType]) {
    final searchBits = search.split(' ').where((value) => value.isNotEmpty);
    if (searchBits.isEmpty) {
      return _appDatabase.contactsDao
          .watchAllContacts(null, sourceType?.toData())
          .map(
            ((contactDatas) => contactDatas
                .map(
                  (data) => contactFromDrift(
                    data.contact,
                    phones: data.phones,
                    emails: data.emails,
                    favorites: data.favorites,
                    presenceInfo: data.presenceInfo,
                    dialogInfo: data.dialogInfo,
                  ),
                )
                .toList()),
          );
    } else {
      return _appDatabase.contactsDao
          .watchAllContacts(searchBits, sourceType?.toData())
          .map(
            ((contactDatas) => contactDatas
                .map(
                  (data) => contactFromDrift(
                    data.contact,
                    phones: data.phones,
                    emails: data.emails,
                    favorites: data.favorites,
                    presenceInfo: data.presenceInfo,
                    dialogInfo: data.dialogInfo,
                  ),
                )
                .toList()),
          );
    }
  }

  Stream<Contact?> watchContact(ContactId contactId, {bool includeSipSubscriptions = false}) {
    return _appDatabase.contactsDao.watchContact(contactId, includeSipSubscriptions: includeSipSubscriptions).map((
      data,
    ) {
      if (data == null) return null;
      return contactFromDrift(
        data.contact,
        phones: data.phones,
        emails: data.emails,
        favorites: data.favorites,
        presenceInfo: data.presenceInfo,
        dialogInfo: data.dialogInfo,
        sipSubscriptions: data.sipSubscriptions,
      );
    });
  }

  /// Watches a contact by its [sourceType] and [sourceId].
  ///
  /// This method provides a stream of the contact's data, which will automatically
  /// update when the underlying data changes in the local database.
  ///
  /// If [fetchIfMissing] is `true` (the default) and the contact is not found locally,
  /// this method will trigger a one-time fetch from the remote source if the [sourceType] is `external`.
  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(
    ContactSourceType sourceType,
    String sourceId, {
    bool fetchIfMissing = false,
  }) {
    const skipSymbol = -1;
    return _appDatabase.contactsDao
        .watchContactBySource(sourceType.toData(), sourceId)
        .asyncMap((data) async {
          if (data != null) {
            return contactFromDrift(
              data.contact,
              phones: data.phones,
              emails: data.emails,
              favorites: data.favorites,
              presenceInfo: data.presenceInfo,
              dialogInfo: data.dialogInfo,
            );
          }

          // After full migration, _contactsRemoteDataSource shouldn't be null and can be removed from the condition.
          if (fetchIfMissing && sourceType == ContactSourceType.external && _contactsRemoteDataSource != null) {
            try {
              await _fetchContact(sourceId, _contactsRemoteDataSource);

              return skipSymbol;
            } catch (e) {
              _logger.warning('Failed to fetch contact from remote source: $e');
            }
          }

          return null;
        })
        .skipWhile((event) => event == skipSymbol)
        .cast<Contact?>()
        .distinct();
  }

  /// Fetches a single external contact by its [sourceId] from the remote data source
  /// and stores it in the local database.
  ///
  /// This method implements a **single-flight** concurrency pattern using the
  /// [_externalContactFetchLocks] pool. If a request for the same [sourceId] is already
  /// in progress, subsequent callers will simply await the existing Future
  /// instead of initiating a redundant network request.
  Future<void> _fetchContact(String sourceId, ContactsRemoteDataSource contactsRemoteDataSource) async {
    if (_externalContactFetchLocks.containsKey(sourceId)) {
      return _externalContactFetchLocks[sourceId]!.future;
    }

    final externalContactFetchCompleter = Completer<void>();
    _externalContactFetchLocks[sourceId] = externalContactFetchCompleter;

    try {
      final contact = await contactsRemoteDataSource.getContact(sourceId);
      await _contactsLocalDataSource?.upsertContact(externalContactFromApi(contact), ContactKindTypeEnum.service);
      // No need to return data here; the database watcher will automatically emit the updated contact.
      externalContactFetchCompleter.complete();
    } catch (e, s) {
      externalContactFetchCompleter.completeError(e, s);
    } finally {
      _externalContactFetchLocks.remove(sourceId);
    }

    return externalContactFetchCompleter.future;
  }

  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    final data = await _appDatabase.contactsDao.getContactBySource(sourceType.toData(), sourceId);
    if (data == null) return null;
    return contactFromDrift(
      data.contact,
      phones: data.phones,
      emails: data.emails,
      favorites: data.favorites,
      presenceInfo: data.presenceInfo,
      dialogInfo: data.dialogInfo,
    );
  }

  Future<Contact?> getContactByPhoneNumber(String number) async {
    final data = await _appDatabase.contactsDao.getContactByPhoneNumber(number);
    if (data == null) return null;
    return contactFromDrift(
      data.contact,
      phones: data.phones,
      emails: data.emails,
      favorites: data.favorites,
      presenceInfo: data.presenceInfo,
      dialogInfo: data.dialogInfo,
    );
  }

  Stream<Contact?> watchContactByPhoneNumber(String number) async* {
    await for (var data in _appDatabase.contactsDao.watchContactByPhoneNumber(number)) {
      // In case if exact phone number is not found try to find by national significant number (NSN)
      //
      // Case 1: if user has local contact like '0507259336', but after call PBX automatically appends country code `+380`
      // and CDR record becomes `+380507259336`, but local contact number stays `0507259336`.
      // Case 2: if user just called using full international number `+380507259336` from keypad but local contact saved as `0507259336`.
      //
      // In these cases we need to find contact by national significant number `0507259336`.
      // To do it we verify if that number is truly valid full number and only than extract NSN part.
      //
      // Also check length to reduce libphonenumbers evaluation
      if (data == null && number.length >= 6) {
        final nsnPart = number.nationalPhoneIfValid;
        if (nsnPart != null && nsnPart != number) {
          data = await _appDatabase.contactsDao.getContactByPhoneMatchedEnding(nsnPart);
        }
      }

      if (data != null) {
        yield contactFromDrift(
          data.contact,
          phones: data.phones,
          emails: data.emails,
          favorites: data.favorites,
          presenceInfo: data.presenceInfo,
          dialogInfo: data.dialogInfo,
        );
      } else {
        yield null;
      }
    }
  }

  /// Synchronizes a list of external contacts.
  /// Handles deletion of missing contacts and batch upsert of new/updated ones.
  Future<void> syncExternalContacts(List<ExternalContact> contacts) async {
    if (_contactsLocalDataSource == null) {
      throw StateError('ContactsLocalDataSource is not initialized for external contacts sync');
    }

    return _contactsLocalDataSource.syncExternalContacts(contacts);
  }

  /// Synchronizes a list of local device contacts.
  Future<void> syncLocalContacts(List<LocalContact> contacts) async {
    if (_contactsLocalDataSource == null) {
      throw StateError('ContactsLocalDataSource is not initialized for local contacts sync');
    }

    return _contactsLocalDataSource.syncLocalContacts(contacts);
  }
}
