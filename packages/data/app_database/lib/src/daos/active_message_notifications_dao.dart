import 'package:app_database/src/app_database.dart';
import 'package:drift/drift.dart';

part 'active_message_notifications_dao.g.dart';

@DriftAccessor(tables: [ActiveMessageNotificationsTable])
class ActiveMessageNotificationsDao extends DatabaseAccessor<AppDatabase> with _$ActiveMessageNotificationsDaoMixin {
  ActiveMessageNotificationsDao(super.db);

  Future<List<ActiveMessageNotificationData>> getAllByConversation(int conversationId) {
    return (select(activeMessageNotificationsTable)..where((t) => t.conversationId.equals(conversationId))).get();
  }

  Future<int> set(ActiveMessageNotificationData notification) {
    return into(activeMessageNotificationsTable).insertOnConflictUpdate(notification);
  }

  Future<int> deleteByNotification(String notificationId) {
    return (delete(activeMessageNotificationsTable)..where((t) => t.notificationId.equals(notificationId))).go();
  }

  Future<int> deleteByConversation(int conversationId) {
    return (delete(activeMessageNotificationsTable)..where((t) => t.conversationId.equals(conversationId))).go();
  }

  Future<int> deleteByMessage(int messageId) {
    return (delete(activeMessageNotificationsTable)..where((t) => t.messageId.equals(messageId))).go();
  }

  Future wipeData() async {
    await delete(activeMessageNotificationsTable).go();
  }
}
