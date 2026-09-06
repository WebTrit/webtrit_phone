import 'package:clock/clock.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

final _logger = Logger('CdrsSyncWorker');

const _postCallRefreshDelay = Duration(seconds: 1);

/// Owns the CDR worker and its polling registration.
///
/// Scheduled refreshes and call-ended invalidations use the same polling task,
/// so they share one lifecycle, single-flight boundary, and backoff policy.
final class CdrsSync extends PollingWorkerOwner<CdrsSyncWorker> {
  CdrsSync({required super.worker, required super.pollingService, required super.interval});

  /// Requests one refresh after the backend has had time to publish the CDR.
  ///
  /// Repeated call-ended events use the task's trailing-edge debounce instead
  /// of cancelling and recreating the polling schedule.
  void requestPostCallRefresh() {
    invalidatePollingTask(after: _postCallRefreshDelay);
  }
}

/// Synchronizes remote call history with the local CDR store.
///
/// One [refresh] is a finite domain sync cycle. [PollingService] owns
/// scheduling, connectivity, lifecycle, single-flight, and backoff. Feature
/// consumers request additional work through [CdrsSync].
class CdrsSyncWorker implements PollingWorker {
  CdrsSyncWorker(this.localRepo, this.remoteRepo, {this.pageSize = 50})
    : assert(pageSize > 0, 'pageSize must be greater than zero');

  final CdrsLocalRepository localRepo;
  final CdrsRemoteRepository remoteRepo;

  final int pageSize;

  @override
  bool get isActive => !_disposed;

  /// Runs one complete CDR sync cycle and returns when local persistence has
  /// finished.
  ///
  /// Initial sync stores the newest page. Incremental sync drains every page
  /// from the last locally known update, advancing the page number after each
  /// full page. Failures are offered to the local repository, which notifies
  /// initial-sync observers only while its durable sync cursor is absent, and
  /// are rethrown so the caller can apply retry or backoff policy.
  @override
  Future<void> refresh() async {
    if (_disposed) {
      throw StateError('Cannot refresh a disposed CDR sync worker.');
    }

    try {
      final lastUpdate = await localRepo.getLastUpdate();

      if (lastUpdate == null) {
        await _refreshInitialHistory();
      } else {
        await _refreshIncrementalHistory(lastUpdate);
      }

      // The persisted marker is the source of truth. A cache wipe clears it,
      // so the next successful cycle naturally marks initial sync again without
      // mirroring that state in the worker.
      if (await localRepo.getLastSyncTime() == null) {
        await localRepo.markSyncCompleted(clock.now());
      }
    } catch (_) {
      await _notifyInitialSyncFailed();
      rethrow;
    }
  }

  Future<void> _refreshInitialHistory() async {
    final initialCdrs = await remoteRepo.getHistory(page: 1, limit: pageSize);
    _logger.fine('Initial CDRs fetched: ${initialCdrs.length}');
    await localRepo.upsertCdrs(initialCdrs.reversed.toList());
  }

  Future<void> _refreshIncrementalHistory(DateTime lastUpdate) async {
    var page = 1;
    final fetchedCdrs = <CdrRecord>[];

    while (true) {
      final newCdrs = await remoteRepo.getHistory(from: lastUpdate, page: page, limit: pageSize);
      _logger.fine('New CDRs fetched from page $page: ${newCdrs.length}');
      fetchedCdrs.addAll(newCdrs);

      if (newCdrs.length < pageSize) break;
      page++;
    }

    // Persist only after every page has been fetched. If a later request fails,
    // the local last-update anchor must not advance past records that were not
    // fetched yet.
    // Repository events update in-memory lists one record at a time by
    // prepending new records, so emit oldest-to-newest to preserve descending
    // chronology in consumers (the API pages are newest-first).
    await localRepo.upsertCdrs(fetchedCdrs.reversed.toList());
  }

  Future<void> _notifyInitialSyncFailed() async {
    try {
      await localRepo.notifyInitialSyncFailed();
    } catch (e, s) {
      // Preserve the original cycle failure when notifying observers also
      // fails, so PollingService applies backoff to the real sync error.
      _logger.warning('notifyInitialSyncFailed', e, s);
    }
  }

  bool _disposed = false;

  @override
  Future<void> dispose() async {
    if (_disposed) return;

    _logger.info('Disposing');
    _disposed = true;
  }
}
