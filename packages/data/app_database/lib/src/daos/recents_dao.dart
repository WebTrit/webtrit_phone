import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'recents_dao.g.dart';

class RecentData {
  RecentData({
    required this.callLog,
    required this.contactData,
    required this.contactPhones,
    required this.contactEmails,
  });

  final CallLogData callLog;
  final ContactData? contactData;
  final Set<ContactPhoneData> contactPhones;
  final Set<ContactEmailData> contactEmails;
}

@DriftAccessor(tables: [CallLogsTable, ContactPhonesTable, ContactsTable, ContactPhonesTable, ContactEmailsTable])
class RecentsDao extends DatabaseAccessor<AppDatabase> with _$RecentsDaoMixin {
  RecentsDao(super.db);

  Stream<List<RecentData>> watchLastRecents([Duration period = const Duration(days: 14)]) {
    final callsQuery = select(callLogsTable)
      ..where((t) => t.createdAt.isBiggerOrEqualValue(clock.agoBy(period)))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    final sourcePhone = alias(contactPhonesTable, 'source_phone');
    final contactPhones = alias(contactPhonesTable, 'contact_phones');

    final recentsQuery = callsQuery.join([
      leftOuterJoin(sourcePhone, callLogsTable.number.equalsExp(sourcePhone.number), useColumns: false),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(sourcePhone.contactId)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(contactPhones, contactPhones.contactId.equalsExp(contactsTable.id)),
    ]);

    return recentsQuery.watch().map(_rowsToRecent);
  }

  Future<RecentData> getRecentByCallId(int id) {
    final q = (select(callLogsTable)..where((t) => t.id.equals(id))).join([
      leftOuterJoin(contactPhonesTable, contactPhonesTable.number.equalsExp(callLogsTable.number)),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
    ]);
    return q.get().then((rows) => _rowsToRecent(rows).first);
  }

  Future deleteRecent(int id) {
    return (delete(callLogsTable)..where((t) => t.id.equals(id))).go();
  }

  List<RecentData> _rowsToRecent(Iterable<TypedResult> rows) {
    Map<int, RecentData> recents = {};

    for (final row in rows) {
      final callLog = row.readTable(callLogsTable);
      final contactData = row.readTableOrNull(contactsTable);
      final contactPhone = row.readTableOrNull(contactPhonesTable);
      final contactEmail = row.readTableOrNull(contactEmailsTable);

      recents.putIfAbsent(
        callLog.id,
        () => RecentData(callLog: callLog, contactData: contactData, contactPhones: {}, contactEmails: {}),
      );

      if (contactPhone != null) recents[callLog.id]!.contactPhones.add(contactPhone);
      if (contactEmail != null) recents[callLog.id]!.contactEmails.add(contactEmail);
    }

    return recents.values.toList();
  }
}
