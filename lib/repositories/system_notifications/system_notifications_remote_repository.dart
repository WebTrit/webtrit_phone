import 'package:webtrit_api/webtrit_api.dart' show WebtritApiClient, UnauthorizedException;

import 'package:webtrit_phone/mappers/api/system_notification_mapper.dart';
import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/app/session/session.dart';

abstract class SystemNotificationsRemoteRepository {
  /// Fetches the history of system notifications.
  /// [since] - Optional parameter to filter notifications `before` this date.
  /// [limit] - Optional parameter to limit the number of notifications returned. Defaults to `20`.
  Future<List<SystemNotification>> getHistory({DateTime? since, int limit = 20});

  /// Fetches the updates of system notifications.
  /// [since] - Optional parameter to filter notifications created `after` this date.
  /// [limit] - Optional parameter to limit the number of notifications returned. Defaults to `20`.
  Future<List<SystemNotification>> getUpdates({required DateTime since, int limit = 20});

  /// Marks a system notification as seen.
  Future<void> markSystemNotificationAsSeen(int notificationId);
}

class SystemNotificationsRemoteRepositoryApiImpl
    with SystemNotificationApiMapper
    implements SystemNotificationsRemoteRepository {
  SystemNotificationsRemoteRepositoryApiImpl(this._webtritApiClient, this._token, this._sessionGuard);

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<List<SystemNotification>> getHistory({DateTime? since, int limit = 20}) async {
    try {
      final response = await _webtritApiClient.getSystemNotificationsHistory(_token, since: since, limit: limit);
      return response.items.map(systemNotificationFromApi).toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }

  @override
  Future<List<SystemNotification>> getUpdates({required DateTime since, int limit = 20}) async {
    try {
      final response = await _webtritApiClient.getSystemNotificationsUpdates(_token, since: since, limit: limit);
      return response.items.map(systemNotificationFromApi).toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }

  @override
  Future<void> markSystemNotificationAsSeen(int notificationId) async {
    try {
      await _webtritApiClient.markSystemNotificationAsSeen(_token, notificationId);
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }
}
