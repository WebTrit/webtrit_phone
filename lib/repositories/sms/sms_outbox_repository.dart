import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'components/sms_outbox_drift_mapper.dart';

class SmsOutboxRepository with SmsOutboxDriftMapper {
  SmsOutboxRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;
  SmsDao get _smsDao => _appDatabase.smsDao;

  Future<List<SmsOutboxMessageEntry>> getOutboxMessages() async {
    final entriesData = await _smsDao.getOutboxMessages();
    return entriesData.map(smsOutboxMessageEntryFromDrift).toList();
  }

  Stream<List<SmsOutboxMessageEntry>> watchOutboxMessages() {
    return _smsDao.watchOutboxMessages().map((entriesData) {
      return entriesData.map(smsOutboxMessageEntryFromDrift).toList();
    });
  }

  Future<int> upsertOutboxMessage(SmsOutboxMessageEntry entry) {
    final entryData = smsOutboxMessageDataFromEntry(entry);
    return _smsDao.upsertOutboxMessage(entryData);
  }

  Future<int> deleteOutboxMessage(String idKey) {
    return _smsDao.deleteOutboxMessage(idKey);
  }

  Future<void> wipeOutboxData() async {
    await _smsDao.wipeOutboxData();
  }
}
