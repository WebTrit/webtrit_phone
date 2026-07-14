import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/cubit/database_cache_section.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

void main() {
  late AppDatabase appDatabase;
  late CdrsLocalRepository cdrsRepository;
  late DatabaseCacheSection section;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    cdrsRepository = CdrsLocalRepositoryDriftImpl(appDatabase);
    section = DatabaseCacheSection(appDatabase, cdrsRepository);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  CdrRecordData createCdr(String callId) {
    return CdrRecordData(
      callId: callId,
      direction: CallDirectionData.incoming,
      status: CdrStatusData.accepted,
      callee: '555001',
      caller: '555002',
      connectTimeUsec: 1000,
      disconnectTimeUsec: 2000,
      disconnectReason: 'normal',
      durationSeconds: 1,
    );
  }

  VoicemailData createVoicemail(String id) {
    return VoicemailData(
      id: id,
      date: '2026-07-14',
      duration: 5.0,
      sender: '555002',
      receiver: '555001',
      seen: false,
      size: 100,
      type: 'audio/wav',
    );
  }

  test('reports the rows of every table as items', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1'), createCdr('2')]);
    await appDatabase.voicemailDao.insertVoicemail(createVoicemail('vm-1'));

    final usage = await section.usage();

    expect(usage.unit, CacheUsageUnit.items);
    expect(usage.amount, 3);
  });

  test('reports zero for an empty database', () async {
    final usage = await section.usage();

    expect(usage.amount, 0);
  });

  test('clear wipes every table', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1'), createCdr('2')]);
    await appDatabase.voicemailDao.insertVoicemail(createVoicemail('vm-1'));

    await section.clear();

    expect((await section.usage()).amount, 0);
  });

  test('clear notifies listeners holding call history records in memory', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1')]);
    final events = expectLater(cdrsRepository.events, emits(isA<CdrRecordsWiped>()));

    await section.clear();

    await events;
  });
}
