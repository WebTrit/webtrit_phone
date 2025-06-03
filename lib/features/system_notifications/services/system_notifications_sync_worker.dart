import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_remote_repository.dart';

final _logger = Logger('SystemNotificationsSyncWorker');

/// A worker class responsible for synchronizing system notifications.
///
/// This class handles the logic required to keep system notifications up-to-date,
/// ensuring that any changes or updates are properly managed and reflected within
/// the application.
///
/// Fetches notifications sequentially, starting with the initial history
/// and then fetching updates based on the last update time using updatedAt property.
class SystemNotificationsSyncWorker {
  SystemNotificationsSyncWorker(
    this.localRepo,
    this.remoteRepo, {
    this.pollingInterval = const Duration(seconds: 10),
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
    _syncSub = _syncStream().listen(_handleSyncEvent);
  }

  /// Creates continuous cancellable sequence of system notifications sync process.
  /// Returns a [Stream] of logs and errors that occur during the sync.
  Stream<dynamic> _syncStream() async* {
    int successIterations = 0;
    while (!_disposed) {
      try {
        // Check connectivity before processing
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) continue;

        // Fetch last sync time
        final lastUpdate = await localRepo.getLastUpdate();

        // If no last update, fetch initial history
        if (lastUpdate == null) {
          final notifications = await remoteRepo.getHistory(limit: pageSize);
          yield 'Initial notifications fetched: ${notifications.length}';
          final isInitialData = successIterations == 0;
          await localRepo.upsertNotifications(notifications.reversed.toList(), initialData: isInitialData);
        }

        // Fetch updates sequence e.g new notifications or updates(seen,delete)
        // since last update
        if (lastUpdate != null) {
          while (true) {
            final updates = await remoteRepo.getUpdates(since: lastUpdate, limit: pageSize);
            yield 'Updated notifications: ${updates.length}';
            await localRepo.upsertNotifications(updates);
            if (updates.length < pageSize) break;
          }
        }
        successIterations++;
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
    await _syncSub.cancel();
    _disposed = true;
  }
}

const _kRetryEventStub = 'retry';
