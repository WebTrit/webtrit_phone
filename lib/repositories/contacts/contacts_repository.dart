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
    with PresenceInfoDriftMapper, ContactsDriftMapper, ExternalContactApiMapper, AsyncKeyLockMixin {
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
                  ),
                )
                .toList()),
          );
    }
  }

  Stream<Contact?> watchContact(ContactId contactId) {
    return _appDatabase.contactsDao.watchContact(contactId).map((data) {
      if (data == null) return null;
      return contactFromDrift(
        data.contact,
        phones: data.phones,
        emails: data.emails,
        favorites: data.favorites,
        presenceInfo: data.presenceInfo,
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
    return _appDatabase.contactsDao
        .watchContactBySource(sourceType.toData(), sourceId)
        .map((it) => contactFromFullDataOrNull(it))
        .doOnData((contact) => _handleAutoFetch(contact, sourceType, sourceId, canFetch: fetchIfMissing));
  }

  /// Triggers a network fetch for a missing external contact.
  ///
  /// If a contact is null (not found locally), and it's an `external` type,
  /// this method initiates a fetch from the remote API. It uses an `AsyncKeyLockMixin`
  /// to prevent duplicate network requests for the same `sourceId`.
  void _handleAutoFetch(Contact? contact, ContactSourceType type, String sourceId, {required bool canFetch}) {
    if (!canFetch) return;

    if (contact == null && type == ContactSourceType.external) {
      runExclusive(sourceId, () => _fetchAndUpsertContact(sourceId));
    }
  }

  /// Fetches an external contact and upserts it into the local database.
  ///
  /// Retrieves contact details from the remote source using [sourceId],
  /// maps the API response, and saves it locally. Exceptions are logged and
  /// swallowed to prevent crashing the stream that triggered this fetch.
  Future<void> _fetchAndUpsertContact(String sourceId) async {
    try {
      final apiContact = await _contactsRemoteDataSource?.getContact(sourceId);
      if (apiContact == null) return;
      final external = externalContactFromApi(apiContact);
      await _contactsLocalDataSource?.upsertContact(external);
    } catch (e, s) {
      _logger.warning('Failed to auto-fetch contact $sourceId', e, s);
    }
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
    );
  }

  Stream<Contact?> watchContactByPhoneNumber(String number) {
    return _appDatabase.contactsDao.watchContactByPhoneNumber(number).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Stream<Contact?> watchContactByPhoneNumberMatch(String number) {
    number = number.replaceAll(RegExp(numberSanitizeRegex), '');
    if (number.isEmpty) return Stream.value(null);

    // For short numbers(services numbers, extensions) do exact match only
    // to avoid mismatches like matching "111" to "001234567111"
    if (number.length <= 4) return watchContactByPhoneNumber(number);

    // Try to get national format if possible to improve matching
    // for cases when contact stored in national format "123456789" but
    // remote system automaticaly appends country code "+00123456789" after calling
    // so only way to find such contact is to search by extract national part
    final nationalNumber = number.nationalPhoneIfValid;
    return _appDatabase.contactsDao.watchContactByPhoneMatchedEnding(nationalNumber ?? number).map((data) {
      if (data == null) return null;
      return contactFromDrift(data.contact, phones: data.phones, emails: data.emails, favorites: data.favorites);
    });
  }

  Future<int> addContactPhoneToFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.insertFavoriteByContactPhoneId(contactPhone.id);
  }

  Future<int> removeContactPhoneFromFavorites(ContactPhone contactPhone) {
    return _appDatabase.favoritesDao.deleteByContactPhoneId(contactPhone.id);
  }
}
