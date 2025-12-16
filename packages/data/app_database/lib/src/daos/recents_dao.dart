import 'package:app_database/src/app_database.dart';
import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

part 'recents_dao.g.dart';

class RecentData {
  RecentData({
    required this.callLogEntry,
    required this.contactData,
    required this.contactPhones,
    required this.contactEmails,
    required this.presenceInfo,
  });

  final CallLogData callLogEntry;
  final ContactData? contactData;
  final Set<ContactPhoneData> contactPhones;
  final Set<ContactEmailData> contactEmails;
  final Set<PresenceInfoData> presenceInfo;
}

@DriftAccessor(
  tables: [CallLogsTable, ContactPhonesTable, ContactsTable, ContactPhonesTable, ContactEmailsTable, PresenceInfoTable],
)
class RecentsDao extends DatabaseAccessor<AppDatabase> with _$RecentsDaoMixin {
  RecentsDao(super.db);

  Stream<List<RecentData>> watchLastRecents([Duration period = const Duration(days: 14)]) {
    final callsQuery = select(callLogsTable)
      ..where((t) => t.createdAt.isBiggerOrEqualValue(clock.agoBy(period)))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    final sourcePhone = alias(contactPhonesTable, 'source_phone');
    final contactPhones = alias(contactPhonesTable, 'contact_phones');

    final recentsQuery = callsQuery.join([
      leftOuterJoin(
        sourcePhone,
        callLogsTable.number.equalsExp(sourcePhone.rawNumber) |
            callLogsTable.number.equalsExp(sourcePhone.sanitizedNumber),
        useColumns: false,
      ),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(sourcePhone.contactId)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(contactPhones, contactPhones.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(
        presenceInfoTable,
        presenceInfoTable.number.equalsExp(contactPhonesTable.rawNumber) |
            presenceInfoTable.number.equalsExp(contactPhonesTable.sanitizedNumber),
      ),
    ]);

    return recentsQuery.watch().map(_rowsToRecent);
  }

  Future<RecentData> getRecentByCallId(int id) {
    final q = (select(callLogsTable)..where((t) => t.id.equals(id))).join([
      leftOuterJoin(
        contactPhonesTable,
        contactPhonesTable.rawNumber.equalsExp(callLogsTable.number) |
            contactPhonesTable.sanitizedNumber.equalsExp(callLogsTable.number),
      ),
      leftOuterJoin(contactsTable, contactsTable.id.equalsExp(contactPhonesTable.contactId)),
      leftOuterJoin(contactEmailsTable, contactEmailsTable.contactId.equalsExp(contactsTable.id)),
      leftOuterJoin(
        presenceInfoTable,
        presenceInfoTable.number.equalsExp(contactPhonesTable.rawNumber) |
            presenceInfoTable.number.equalsExp(contactPhonesTable.sanitizedNumber),
      ),
    ]);
    return q.get().then((rows) => _rowsToRecent(rows).first);
  }

  Future deleteRecent(int id) {
    return (delete(callLogsTable)..where((t) => t.id.equals(id))).go();
  }

  List<RecentData> _rowsToRecent(Iterable<TypedResult> rows) {
    Map<int, RecentData> recents = {};

    for (final row in rows) {
      final callLogEntry = row.readTable(callLogsTable);
      final contactData = row.readTableOrNull(contactsTable);
      final contactPhone = row.readTableOrNull(contactPhonesTable);
      final contactEmail = row.readTableOrNull(contactEmailsTable);
      final presenceInfo = row.readTableOrNull(presenceInfoTable);

      recents.putIfAbsent(
        callLogEntry.id,
        () => RecentData(
          callLogEntry: callLogEntry,
          contactData: contactData,
          contactPhones: {},
          contactEmails: {},
          presenceInfo: {},
        ),
      );

      if (contactPhone != null) recents[callLogEntry.id]!.contactPhones.add(contactPhone);
      if (contactEmail != null) recents[callLogEntry.id]!.contactEmails.add(contactEmail);
      if (presenceInfo != null) recents[callLogEntry.id]!.presenceInfo.add(presenceInfo);
    }

    return recents.values.toList();
  }
}
