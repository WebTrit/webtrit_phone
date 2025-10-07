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

  init() async {
    // Uncomment to wipe local CDRs data on each start (for testing purposes)
    // await localRepo.wipeData();
    _logger.info('Initializing CDRs sync worker');
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  forceSync(Duration? delay) async {
    _logger.info('Forcing CDRs sync');
    _syncSub?.cancel();
    if (delay != null) await Future.delayed(delay);
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  Stream<dynamic> _syncStream() async* {
    while (!_disposed) {
      try {
        // Check connectivity before processing
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) continue;

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
      } catch (e, s) {
        yield (e, s);
      } finally {
        yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
      }
    }
  }

  void _handleSyncEvent(event) {
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
    _disposed = true;
  }
}

const _kRetryEventStub = 'retry';
