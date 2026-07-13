import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CdrsSyncWorker');

class CdrsSyncWorker {
  CdrsSyncWorker(
    this.localRepo,
    this.remoteRepo, {
    this.pollingInterval = const Duration(seconds: 10),
    this.pageSize = 50,
  });

  final CdrsLocalRepository localRepo;
  final CdrsRemoteRepository remoteRepo;
  final connectivity = Connectivity();

  final Duration pollingInterval;
  final int pageSize;
  StreamSubscription? _syncSub;
  StreamSubscription? _eventsSub;

  Future<void> init() async {
    // Uncomment to wipe local CDRs data on each start (for testing purposes)
    // await localRepo.wipeData();
    _logger.info('Initializing CDRs sync worker');
    _eventsSub = localRepo.events.listen(_handleRepoEvent);
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  void _handleRepoEvent(CdrRecordsEvent event) {
    // A wipe clears the sync cursor together with the records; re-arm so the
    // next successful cycle rewrites it (and failures are reported again),
    // exactly as after a fresh start.
    if (event is CdrRecordsWiped) _syncMarked = false;
  }

  Future<void> forceSync(Duration? delay) async {
    _logger.info('Forcing CDRs sync');
    _syncSub?.cancel();
    if (delay != null) await Future.delayed(delay);
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  /// Whether this worker has already recorded a completed cycle, so the sync
  /// watermark is written (and failures reported) at most until the first
  /// success per app run instead of on every polling cycle.
  bool _syncMarked = false;

  Stream<dynamic> _syncStream() async* {
    while (!_disposed) {
      try {
        // Check connectivity before processing
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) {
          // Cannot sync now: let consumers stop waiting on the initial sync
          // (they would spin forever otherwise); the next poll self-heals.
          await _notifyInitialSyncFailed();
          continue;
        }

        // Fetch last sync time
        final lastUpdate = await localRepo.getLastUpdate();

        // If no last update, fetch initial history
        if (lastUpdate == null) {
          final initialCdrs = await remoteRepo.getHistory(limit: pageSize);
          yield 'Initial cdrs fetched: ${initialCdrs.length}';
          await localRepo.upsertCdrs(initialCdrs.reversed.toList());
        }

        // Fetch new cdrs since last update
        if (lastUpdate != null) {
          while (true) {
            final newCdrs = await remoteRepo.getHistory(from: lastUpdate, limit: pageSize);
            yield 'New cdrs fetched: ${newCdrs.length}';
            await localRepo.upsertCdrs(newCdrs);
            if (newCdrs.length < pageSize) break;
          }
        }

        // Mark the cycle as completed (even when it fetched zero records), so
        // consumers can tell a finished-but-empty sync from one still running.
        if (!_syncMarked) {
          await localRepo.markSyncCompleted(DateTime.now());
          _syncMarked = true;
        }
      } catch (e, s) {
        await _notifyInitialSyncFailed();
        yield (e, s);
      } finally {
        yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
      }
    }
  }

  Future<void> _notifyInitialSyncFailed() async {
    if (_syncMarked) return;
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

  Future dispose() async {
    _logger.info('Disposing');
    await _syncSub?.cancel();
    await _eventsSub?.cancel();
    _disposed = true;
  }
}

const _kRetryEventStub = 'retry';
