import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/system_notification_event.dart';
import 'package:webtrit_phone/models/system_notification_outbox_entry.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_local_repository.dart';
import 'package:webtrit_phone/repositories/system_notifications/system_notifications_remote_repository.dart';

final _logger = Logger('SystemNotificationsOutboxWorker');

/// A worker class responsible for handling the outbox of async operations
/// related to system notifications. This may include queuing,
/// sending, and managing notifications that need to be delivered
/// by the system.
class SystemNotificationsOutboxWorker {
  SystemNotificationsOutboxWorker(
    this.localRepo,
    this.remoteRepo, {
    this.pollingInterval = const Duration(seconds: 1),
  });

  final SystemNotificationsLocalRepository localRepo;
  final SystemNotificationsRemoteRepository remoteRepo;
  final connectivity = Connectivity();

  final Duration pollingInterval;
  late final StreamSubscription _processingSub;
  late final StreamSubscription _localEventSub;

  void init() {
    _logger.info('Initializing');
    _processingSub = _processingStream().listen(_handleProcessing);
    _localEventSub = localRepo.eventBus.listen(_handleLocalEvent);
  }

  Stream<dynamic> _processingStream() async* {
    while (!_disposed) {
      try {
        // Check connectivity before processing
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult.every((r) => r == ConnectivityResult.none)) {
          yield 'No internet connection, skipping processing';
          yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
          continue;
        }

        // Process pending outbox notifications
        final seenEntries = await localRepo.getOutboxNotifications(
          actionType: SnOutboxActionType.seen,
          states: [SnOutboxState.pending],
        );

        if (seenEntries.isNotEmpty) {
          yield 'Pending seen entries: ${seenEntries.length}';
          for (final entry in seenEntries) {
            try {
              await remoteRepo.markSystemNotificationAsSeen(entry.notificationId);
              await localRepo.upsertOutboxNotification(entry.toSent());
              yield 'Seen notification sent: ${entry.notificationId}';
            } catch (e, s) {
              yield (e, s);
              if (entry.sendAttempts > 5) {
                await localRepo.upsertOutboxNotification(entry.toFailed());
                yield 'Failed to send seen notification after 3 attempts: ${entry.notificationId}';
              } else {
                await localRepo.upsertOutboxNotification(entry.incAttempts());
                yield 'Retrying seen notification: ${entry.notificationId}, attempt: ${entry.sendAttempts}';
              }
            }
          }
        }
      } catch (e, s) {
        yield (e, s);
      } finally {
        yield await Future.delayed(pollingInterval, () => _kRetryEventStub);
      }
    }
  }

  void _handleProcessing(event) {
    if (event is (Object, StackTrace)) {
      final (error, stackTrace) = event;
      _logger.warning(error, stackTrace);
    } else if (event == _kRetryEventStub) {
      return;
    } else {
      _logger.fine(event);
    }
  }

  void _handleLocalEvent(SystemNotificationEvent event) {
    if (event is SystemNotificationUpdate && event.notification.seen) {
      localRepo.deleteOutboxNotification(event.notification.id, SnOutboxActionType.seen);
    }
  }

  bool _disposed = false;

  Future dispose() async {
    _logger.info('Disposing');
    await Future.wait([
      _processingSub.cancel(),
      _localEventSub.cancel(),
    ]);
    _disposed = true;
  }
}

const _kRetryEventStub = 'retry';
