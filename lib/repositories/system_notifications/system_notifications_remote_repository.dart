import 'package:webtrit_api/webtrit_api.dart' show WebtritApiClient;

import 'package:webtrit_phone/mappers/api/system_notification_mapper.dart';
import 'package:webtrit_phone/models/system_notification.dart';

typedef SystemNotificationsWithUnseen = (List<SystemNotification> notifications, int unseenCount);

abstract class SystemNotificationsRemoteRepository {
  /// Fetches the history of system notifications.
  /// [since] - Optional parameter to filter notifications `before` this date.
  /// [limit] - Optional parameter to limit the number of notifications returned. Defaults to `20`.
  Future<SystemNotificationsWithUnseen> getHistory({DateTime? since, int limit = 20});

  /// Fetches the updates of system notifications.
  /// [since] - Optional parameter to filter notifications created `after` this date.
  /// [limit] - Optional parameter to limit the number of notifications returned. Defaults to `20`.
  Future<SystemNotificationsWithUnseen> getUpdates({required DateTime since, int limit = 20});

  /// Marks a system notification as seen.
  /// Returns the updated notificatio, with `seen` set to `true` and new `updatedAt`.
  Future<SystemNotification> markSystemNotificationAsSeen(int notificationId);
}

class SystemNotificationsRemoteRepositoryApiImpl
    with SystemNotificationApiMapper
    implements SystemNotificationsRemoteRepository {
  SystemNotificationsRemoteRepositoryApiImpl(this._webtritApiClient, this._token);
  final WebtritApiClient _webtritApiClient;
  final String _token;

  @override
  Future<SystemNotificationsWithUnseen> getHistory({DateTime? since, int limit = 20}) async {
    final response = await _webtritApiClient.getSystemNotificationsHistory(_token, since: since, limit: limit);
    final notifications = response.items.map(systemNotificationFromApi).toList();
    return (notifications, response.unseenCount);
  }

  @override
  Future<SystemNotificationsWithUnseen> getUpdates({required DateTime since, int limit = 20}) async {
    final response = await _webtritApiClient.getSystemNotificationsUpdates(_token, since: since, limit: limit);
    final notifications = response.items.map(systemNotificationFromApi).toList();
    return (notifications, response.unseenCount);
  }

  @override
  Future<SystemNotification> markSystemNotificationAsSeen(int notificationId) async {
    final response = await _webtritApiClient.markSystemNotificationAsSeen(_token, notificationId);
    final updatedNotification = systemNotificationFromApi(response);
    return updatedNotification;
  }
}
