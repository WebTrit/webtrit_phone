import 'dart:async';

import 'package:clock/clock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CdrsSyncWorker');

/// Synchronizes remote call history with the local CDR store.
///
/// One [refresh] is a finite domain sync cycle. The legacy timer and
/// connectivity lifecycle remain temporarily in this worker until scheduling
/// is migrated to the shared polling service.
class CdrsSyncWorker implements Refreshable, Disposable {
  CdrsSyncWorker(
    this.localRepo,
    this.remoteRepo, {
    this.pollingInterval = const Duration(seconds: 10),
    this.pageSize = 50,
  }) : assert(pageSize > 0, 'pageSize must be greater than zero');

  final CdrsLocalRepository localRepo;
  final CdrsRemoteRepository remoteRepo;
  final connectivity = Connectivity();

  final Duration pollingInterval;
  final int pageSize;
  StreamSubscription? _syncSub;

  /// Starts the transitional self-scheduled polling loop.
  Future<void> init() async {
    if (_disposed) {
      throw StateError('Cannot initialize a disposed CDR sync worker.');
    }

    // Uncomment to wipe local CDRs data on each start (for testing purposes)
    // await localRepo.wipeData();
    _logger.info('Initializing CDRs sync worker');
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  /// Restarts the transitional polling loop after an optional [delay].
  Future<void> forceSync(Duration? delay) async {
    if (_disposed) {
      throw StateError('Cannot force sync a disposed CDR sync worker.');
    }

    _logger.info('Forcing CDRs sync');
    _syncSub?.cancel();
    if (delay != null) await Future.delayed(delay);
    if (_disposed) return;
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  @override
  bool get isActive => !_disposed;

  /// Runs one complete CDR sync cycle and returns when local persistence has
  /// finished.
  ///
  /// Initial sync stores the newest page. Incremental sync drains every page
  /// from the last locally known update, advancing the page number after each
  /// full page. Failures are reported to initial-sync observers and rethrown so
  /// the caller can apply retry or backoff policy.
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

  Stream<dynamic> _syncStream() async* {
    while (!_disposed) {
      try {
        // Check connectivity before processing
        late final List<ConnectivityResult> connectivityResult;
        try {
          connectivityResult = await connectivity.checkConnectivity();
        } catch (_) {
          await _notifyInitialSyncFailed();
          rethrow;
        }
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) {
          // Cannot sync now: let consumers stop waiting on the initial sync
          // (they would spin forever otherwise); the next poll self-heals.
          await _notifyInitialSyncFailed();
          continue;
        }

        await refresh();
      } catch (e, s) {
        yield (e, s);
      } finally {
        yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
      }
    }
  }

  Future<void> _notifyInitialSyncFailed() async {
    try {
      await localRepo.notifyInitialSyncFailed();
    } catch (e, s) {
      // Never let the failure notification itself break the sync loop.
      _logger.warning('notifyInitialSyncFailed', e, s);
    }
  }

  void _handleSyncEvent(dynamic event) {
    if (event is (Object, StackTrace)) {
      final (error, stackTrace) = event;
      _logger.warning(error, stackTrace);
    } else if (event == _kRetryEventStub) {
      return;
    } else {
      _logger.fine(event);
    }
  }

  bool _disposed = false;

  @override
  Future<void> dispose() async {
    if (_disposed) return;

    _logger.info('Disposing');
    _disposed = true;
    await _syncSub?.cancel();
  }
}

const _kRetryEventStub = 'retry';
