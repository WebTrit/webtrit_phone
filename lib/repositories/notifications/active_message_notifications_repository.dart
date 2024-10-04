import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

import 'components/active_message_notifications_drift_mapper.dart';

abstract class ActiveMessageNotificationsRepository {
  Future<List<ActiveMessageNotification>> getAllByConversation(int conversationId);

  Future<void> set(ActiveMessageNotification notification);

  Future<void> deleteByNotification(String notificationId);

  Future<void> deleteByConversation(int conversationId);

  Future<void> deleteByMessage(int messageId);
}

class ActiveMessageNotificationsRepositoryDriftImpl
    with ActiveMessageNotificationDriftMapper
    implements ActiveMessageNotificationsRepository {
  ActiveMessageNotificationsRepositoryDriftImpl({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ActiveMessageNotificationsDao get _dao => _appDatabase.activeMessageNotificationsDao;

  @override
  Future<List<ActiveMessageNotification>> getAllByConversation(int conversationId) async {
    final notificationsData = await _dao.getAllByConversation(conversationId);
    return notificationsData.map(notificationFromDrift).toList();
  }

  @override
  Future<void> set(ActiveMessageNotification notification) async {
    await _dao.set(notificationToDrift(notification));
  }

  @override
  Future<void> deleteByNotification(String notificationId) async {
    await _dao.deleteByNotification(notificationId);
  }

  @override
  Future<void> deleteByConversation(int conversationId) async {
    await _dao.deleteByConversation(conversationId);
  }

  @override
  Future<void> deleteByMessage(int messageId) async {
    await _dao.deleteByMessage(messageId);
  }
}
