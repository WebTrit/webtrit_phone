import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('ExternalContactsSyncWorker');

/// How long a cycle waits for the user info it filters by before giving up
/// on this cycle; without a limit a user-info stream that never emits would
/// wedge the shared single-flight future forever.
const _userInfoTimeout = Duration(seconds: 10);

/// Progress of the external contacts sync, for the screens that show it.
enum ExternalContactsSyncStatus {
  /// A cycle is running and no earlier one has succeeded or failed since.
  syncing,

  /// The last cycle brought the local store up to date.
  synced,

  /// The last cycle failed; the next one retries on its own.
  failed,
}

/// Synchronizes the external contact list into the local contacts store.
///
/// An honest worker, not a bloc: the whole cycle - fetch, filter out the
/// current user, merge into the local store - is one [refresh], driven
/// exclusively by the schedule owner ([Refreshable] registered with the
/// polling service). Screens read the merged contacts reactively from the
/// local store and this worker's [status] for the progress indicator; a
/// user-driven pull calls the same single-flight [refresh], so it can never
/// overlap a scheduled cycle (see `docs/refresh_ownership.md`).
class ExternalContactsSyncWorker implements Refreshable, Disposable {
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

  final _statusController = StreamController<ExternalContactsSyncStatus>.broadcast();
  final _cycle = SingleFlight();
  final _storeRetries = BackoffRetries(initialDelay: const Duration(seconds: 1));

  ExternalContactsSyncStatus _status = ExternalContactsSyncStatus.syncing;

  /// The list the last successful cycle merged, so a cycle that fetched the
  /// same data again skips the store transaction: rewriting an unchanged
  /// table would re-fire every contacts watcher and rebuild the screens on
  /// every polling tick for nothing.
  List<ExternalContact>? _lastSynced;

  /// The current status; [statusStream] carries the changes.
  ExternalContactsSyncStatus get status => _status;

  /// Status changes; a new listener should read [status] first, the stream
  /// only carries transitions.
  Stream<ExternalContactsSyncStatus> get statusStream => _statusController.stream;

  @override
  bool get isActive => true;

  /// One full sync cycle. Errors are rethrown so the schedule owner applies
  /// its backoff and a manual caller can surface the failure. Single-flight:
  /// a call that lands while a cycle is running (a pull during a periodic
  /// tick) rides that cycle instead of starting a second download.
  @override
  Future<void> refresh() => _cycle.run(_runCycle);

  Future<void> _runCycle() async {
    _setStatus(ExternalContactsSyncStatus.syncing);
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
        _lastSynced = filteredContacts;
      }
      _setStatus(ExternalContactsSyncStatus.synced);
    } catch (e) {
      _logger.warning('refresh failed', e);
      _setStatus(ExternalContactsSyncStatus.failed);
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

  void _setStatus(ExternalContactsSyncStatus next) {
    if (_disposed || next == _status) return;
    _status = next;
    _statusController.add(next);
  }

  bool _disposed = false;

  @override
  Future<void> dispose() async {
    _disposed = true;
    _storeRetries.cancel();
    await _statusController.close();
  }
}
