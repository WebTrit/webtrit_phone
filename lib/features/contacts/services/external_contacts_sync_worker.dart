import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('ExternalContactsSyncWorker');

/// How long a cycle waits for the user info it filters by before giving up.
const _userInfoTimeout = Duration(seconds: 10);

/// Owns the external-contacts worker and its polling registration.
///
/// Feature consumers receive this owner through the narrow polling capability
/// they need, so scheduled and manual refreshes share one registration without
/// exposing its lifecycle handle.
final class ExternalContactsSync extends PollingWorkerOwner<ExternalContactsSyncWorker> {
  ExternalContactsSync({required super.worker, required super.pollingService, required super.interval});
}

/// Synchronizes the external contact list into the local contacts store.
///
/// One [refresh] is the complete pipeline: fetch, filter out the current user,
/// and merge into the local store. [PollingService] owns single-flight,
/// scheduling, and observable state; feature consumers use the narrow
/// capabilities exposed by [ExternalContactsSync].
class ExternalContactsSyncWorker implements PollingWorker {
  ExternalContactsSyncWorker({
    required UserRepository userRepository,
    required ExternalContactsRepository externalContactsRepository,
    required ContactsRepository contactsRepository,
  }) : _userRepository = userRepository,
       _externalContactsRepository = externalContactsRepository,
       _contactsRepository = contactsRepository;

  final UserRepository _userRepository;
  final ExternalContactsRepository _externalContactsRepository;
  final ContactsRepository _contactsRepository;

  final _storeRetries = BackoffRetries(initialDelay: const Duration(seconds: 1));

  /// The list the last successful cycle merged, so a cycle that fetched the
  /// same data again skips the store transaction: rewriting an unchanged
  /// table would re-fire every contacts watcher and rebuild the screens on
  /// every polling tick for nothing.
  List<ExternalContact>? _lastSynced;

  @override
  bool get isActive => !_disposed;

  /// Runs one complete sync cycle.
  ///
  /// Errors are logged with their stack trace and rethrown so [PollingService]
  /// can apply scheduled backoff or complete a manual caller with the failure.
  @override
  Future<void> refresh() async {
    if (_disposed) {
      throw StateError('Cannot refresh disposed external contacts sync worker.');
    }

    try {
      final contacts = await _externalContactsRepository.fetchContacts();
      final userInfo =
          _userRepository.getLocalInfo() ?? await _userRepository.getAndListen().first.timeout(_userInfoTimeout);

      // TODO: Clarify this filtering logic. Comparing `externalContact.id`
      // with `userInfo.numbers.main` implies a type mismatch (ID vs Number).
      // This might be related to the legacy change: "fix(api): remove
      // overabundant SIP information from user information response"
      // (2023-08-08).
      final filteredContacts = contacts
          .where((externalContact) => externalContact.id != userInfo.numbers.main)
          .toList();

      if (!listEquals(filteredContacts, _lastSynced)) {
        await _syncWithRetry(filteredContacts);
        _lastSynced = List.unmodifiable(filteredContacts);
      }
    } catch (error, stackTrace) {
      _logger.warning('refresh failed', error, stackTrace);
      rethrow;
    }
  }

  /// Merges into the local store, retrying transient database errors a few
  /// times with a short backoff before giving up on this cycle.
  Future<void> _syncWithRetry(List<ExternalContact> contacts) async {
    await _storeRetries.execute(
      (_) => _contactsRepository.syncExternalContacts(contacts),
      shouldRetry: (e, attempt) => attempt < 3 && !_disposed,
    );
  }

  bool _disposed = false;

  @override
  Future<void> dispose() {
    if (_disposed) {
      return Future<void>.value();
    }

    _disposed = true;
    _storeRetries.cancel();
    return Future<void>.value();
  }
}
