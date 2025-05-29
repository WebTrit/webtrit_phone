import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_remote_repository.dart';

final _logger = Logger('SystemNotificationsSyncWorker');

class SystemNotificationsSyncWorker {
  SystemNotificationsSyncWorker(
    this.localRepo,
    this.remoteRepo, {
    this.pollingInterval = const Duration(seconds: 2),
    this.pageSize = 50,
  });

  final SystemNotificationsLocalRepository localRepo;
  final SystemNotificationsRemoteRepository remoteRepo;
  final connectivity = Connectivity();

  final Duration pollingInterval;
  final int pageSize;
  late final StreamSubscription _syncSub;

  void init() {
    _logger.info('Initializing');
    _syncSub = _syncStream().listen(_handleSync);
  }

  Stream<dynamic> _syncStream() async* {
    while (!_disposed) {
      try {
        // Check connectivity before processing
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) {
          yield 'No internet connection, skipping processing';
          yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
          continue;
        }

        // Fetch last sync time
        final lastUpdate = await localRepo.getLastUpdate();

        // If no last update, fetch initial history
        if (lastUpdate == null) {
          final (notifications, unseen) = await remoteRepo.getHistory(limit: pageSize);
          await Future.forEach(notifications, (n) => localRepo.upsertNotification(n));
          localRepo.setUnseenCount(unseen);
          yield 'Initial notifications fetched: ${notifications.length}';
        }

        // Fetch updates sequence e.g new notifications or updates(seen,delete)
        // since last update
        if (lastUpdate != null) {
          while (true) {
            final (updates, unseen) = await remoteRepo.getUpdates(since: lastUpdate, limit: pageSize);
            await Future.forEach(updates, (n) => localRepo.upsertNotification(n));
            localRepo.setUnseenCount(unseen);
            yield 'Updated notifications: ${updates.length}';
            if (updates.length < pageSize) break;
          }
        }
      } catch (e, s) {
        yield (e, s);
      } finally {
        yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
      }
    }
  }

  void _handleSync(event) {
    if (event is (Object, StackTrace)) {
      final (error, stackTrace) = event;
      _logger.warning(error, stackTrace);
    } else {
      _logger.fine(event);
    }
  }

  bool _disposed = false;

  Future dispose() async {
    _logger.info('Disposing');
    await _syncSub.cancel();
    _disposed = true;
  }
}

const _kRetryEventStub = 'retry';
