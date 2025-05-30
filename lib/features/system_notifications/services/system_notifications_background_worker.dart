import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/secure_storage.dart';
import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/push_notification/app_local_push.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('SystemNotificationBackgroundWorker');

class SystemNotificationBackgroundWorker {
  SystemNotificationBackgroundWorker({
    required SecureStorage secureStorage,
    required SystemNotificationsLocalRepository localRepo,
    required SystemNotificationsRemoteRepository remoteRepo,
    required LocalPushRepository pushRepo,
  })  : _secureStorage = secureStorage,
        _localRepo = localRepo,
        _remoteRepo = remoteRepo,
        _pushRepo = pushRepo {
    _logger.info('SystemNotificationBackgroundWorker initialized');
  }

  final SecureStorage _secureStorage;
  final SystemNotificationsLocalRepository _localRepo;
  final SystemNotificationsRemoteRepository _remoteRepo;
  final LocalPushRepository _pushRepo;

  Future<bool> execute() async {
    try {
      final coreUrl = _secureStorage.readCoreUrl();
      final tenantId = _secureStorage.readTenantId();
      final token = _secureStorage.readToken();
      if (coreUrl == null || tenantId == null || token == null) {
        _logger.info('Core URL, Tenant ID, or Token is not set. Skipping API client initialization.');
        return true;
      }

      final lastUpdate = await _localRepo.getLastUpdate();
      _logger.info('Last update: $lastUpdate');

      List<SystemNotification> newNotifications;
      if (lastUpdate == null) {
        final result = await _remoteRepo.getHistory();
        (newNotifications, _) = result;
      } else {
        final result = await _remoteRepo.getUpdates(since: lastUpdate);
        (newNotifications, _) = result;
      }

      _logger.info('Fetched ${newNotifications.length} new notifications');
      await _localRepo.upsertNotifications(newNotifications);

      for (final notification in newNotifications) {
        final push = AppLocalPush(notification.id, notification.title, notification.content);
        await _pushRepo.displayPush(push);
      }

      return true;
    } catch (e, stackTrace) {
      _logger.severe('Unexpected error in SystemNotificationBackgroundWorker', e, stackTrace);
      return false;
    }
  }
}
