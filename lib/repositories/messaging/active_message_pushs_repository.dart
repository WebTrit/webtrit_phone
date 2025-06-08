import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class ActiveMessagePushsRepository {
  /// Get all active message notifications for given conversation
  Future<List<ActiveMessagePush>> getAllByConversation(int conversationId);

  /// Set active message notification
  Future<void> set(ActiveMessagePush notification);

  /// Delete active message notifications by push-notification id
  Future<void> deleteByNotification(String notificationId);

  /// Delete active message notifications by conversation id
  Future<void> deleteByConversation(int conversationId);

  /// Delete active message notifications by conversation message id
  Future<void> deleteByMessage(int messageId);
}

/// Active message notifications repository implementation using Drift database
class ActiveMessagePushsRepositoryDriftImpl with ActiveMessagePushDriftMapper implements ActiveMessagePushsRepository {
  ActiveMessagePushsRepositoryDriftImpl({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  ActiveMessageNotificationsDao get _dao => _appDatabase.activeMessageNotificationsDao;

  @override
  Future<List<ActiveMessagePush>> getAllByConversation(int conversationId) async {
    final notificationsData = await _dao.getAllByConversation(conversationId);
    return notificationsData.map(notificationFromDrift).toList();
  }

  @override
  Future<void> set(ActiveMessagePush notification) async {
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
