import 'package:drift/drift.dart';

import 'package:app_database/src/app_database.dart';

part 'sip_subscriptions_dao.g.dart';

@DriftAccessor(tables: [SipSubscriptionsTable, SipSubscriptionsOutboxTable])
class SipSubscriptionsDao extends DatabaseAccessor<AppDatabase> with _$SipSubscriptionsDaoMixin {
  SipSubscriptionsDao(super.db);

  Stream<List<SipSubscriptionData>> watchAll() {
    final query = select(sipSubscriptionsTable)..orderBy([(table) => OrderingTerm.asc(table.subscribedAtUsec)]);
    return query.watch();
  }

  Future<List<SipSubscriptionData>> getAll() {
    final query = select(sipSubscriptionsTable)..orderBy([(table) => OrderingTerm.asc(table.subscribedAtUsec)]);
    return query.get();
  }

  Future<void> upsert(SipSubscriptionData item) {
    return into(sipSubscriptionsTable).insertOnConflictUpdate(item);
  }

  Future<void> batchReplace(List<SipSubscriptionData> items, {bool removePrevious = false}) {
    return transaction(() async {
      if (removePrevious) {
        await delete(sipSubscriptionsTable).go();
      }
      await batch((batch) => batch.insertAllOnConflictUpdate(sipSubscriptionsTable, items));
    });
  }

  Future<int> remove(SipSubscriptionTypeData type, String number) {
    return (delete(sipSubscriptionsTable)
          ..where((table) => table.type.equals(type.name))
          ..where((table) => table.number.equals(number)))
        .go();
  }

  Future<void> setOutboxEntry(SipSubscriptionOutboxEntryData entry, {bool replacePrevAction = false}) {
    if (!replacePrevAction) {
      return into(sipSubscriptionsOutboxTable).insertOnConflictUpdate(entry);
    }

    return transaction(() async {
      await (delete(sipSubscriptionsOutboxTable)
            ..where((table) => table.type.equals(entry.type.name))
            ..where((table) => table.number.equals(entry.number)))
          .go();
      await into(sipSubscriptionsOutboxTable).insertOnConflictUpdate(entry);
    });
  }

  Future<int> removeOutboxEntry(SipSubscriptionOutboxActionData action, SipSubscriptionTypeData type, String number) {
    return (delete(sipSubscriptionsOutboxTable)
          ..where((table) => table.action.equals(action.name))
          ..where((table) => table.type.equals(type.name))
          ..where((table) => table.number.equals(number)))
        .go();
  }

  Future<List<SipSubscriptionOutboxEntryData>> getAllOutboxEntries() {
    final query = select(sipSubscriptionsOutboxTable)..orderBy([(table) => OrderingTerm.asc(table.timestampUsec)]);
    return query.get();
  }

  Future<void> wipe() async {
    await delete(sipSubscriptionsTable).go();
    await delete(sipSubscriptionsOutboxTable).go();
  }
}
