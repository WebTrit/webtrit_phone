import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'system_notifications_dao.g.dart';

@DriftAccessor(tables: [SystemNotificationsTable, SystemNotificationsOutboxTable])
class SystemNotificationsDao extends DatabaseAccessor<AppDatabase> with _$SystemNotificationsDaoMixin {
  SystemNotificationsDao(super.db);

  //
  // Notifications section
  //
  Future<List<SystemNotificationData>> getNotifications({DateTime? from, DateTime? to, int? limit}) {
    final query = select(systemNotificationsTable);
    query.orderBy([(t) => OrderingTerm.desc(t.createdAtRemoteUsec)]);

    if (from != null) query.where((tbl) => tbl.createdAtRemoteUsec.isBiggerThanValue(from.microsecondsSinceEpoch));
    if (to != null) query.where((tbl) => tbl.createdAtRemoteUsec.isSmallerThanValue(to.microsecondsSinceEpoch));
    if (limit != null) query.limit(limit);

    return query.get();
  }

  Future<SystemNotificationData?> getNotificationById(int id) {
    return (select(systemNotificationsTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<DateTime?> getLastUpdate() async {
    final query = select(systemNotificationsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAtRemoteUsec)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.updatedAtRemoteUsec != null
        ? DateTime.fromMicrosecondsSinceEpoch(result!.updatedAtRemoteUsec)
        : null;
  }

  Future<void> upsertNotification(SystemNotificationData notification) {
    return into(systemNotificationsTable).insertOnConflictUpdate(notification);
  }

  Future<void> upsertNotifications(List<SystemNotificationData> notifications) {
    return batch((batch) {
      batch.insertAllOnConflictUpdate(systemNotificationsTable, notifications);
    });
  }

  Future<int> deleteNotification(int id) {
    return (delete(systemNotificationsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  //
  // Outbox section
  //
  Future<List<SystemNotificationOutboxEntryData>> getOutboxNotifications(
    SnOutboxDataActionType actionType, {
    List<SnOutboxDataState> states = SnOutboxDataState.values,
  }) {
    final query = select(systemNotificationsOutboxTable);
    query.where((tbl) => tbl.actionType.equals(actionType.name));
    query.where((tbl) => tbl.state.isIn(states.map((e) => e.name).toList()));
    return query.get();
  }

  Stream<List<SystemNotificationOutboxEntryData>> watchOutboxNotifications() {
    return select(systemNotificationsOutboxTable).watch();
  }

  Future<void> upsertOutboxNotification(SystemNotificationOutboxEntryData notification) {
    return into(systemNotificationsOutboxTable).insertOnConflictUpdate(notification);
  }

  Future<int> deleteOutboxNotification(int id, SnOutboxDataActionType actionType) {
    return (delete(systemNotificationsOutboxTable)
          ..where((tbl) => tbl.notificationId.equals(id))
          ..where((tbl) => tbl.actionType.equals(actionType.name)))
        .go();
  }

  Future<void> wipeData() async {
    await transaction(() async {
      await delete(systemNotificationsTable).go();
      await delete(systemNotificationsOutboxTable).go();
    });
  }
}
