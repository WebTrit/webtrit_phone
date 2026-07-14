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

  test('reports the database size as bytes', () async {
    final usage = await section.usage();

    expect(usage.unit, CacheUsageUnit.bytes);
    expect(usage.amount, greaterThan(0));
  });

  test('clear wipes every table and shrinks the database', () async {
    await appDatabase.cdrsDao.upsertCdrs([for (var i = 0; i < 500; i++) createCdr('$i')]);
    await appDatabase.voicemailDao.insertVoicemail(createVoicemail('vm-1'));
    final populatedSize = (await section.usage()).amount;

    await section.clear();

    expect(await appDatabase.cdrsDao.getHistory(), isEmpty);
    expect(await appDatabase.voicemailDao.getAllVoicemails(), isEmpty);
    expect((await section.usage()).amount, lessThan(populatedSize));
  });

  test('clear notifies listeners holding call history records in memory', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1')]);
    final events = expectLater(cdrsRepository.events, emits(isA<CdrRecordsWiped>()));

    await section.clear();

    await events;
  });
}
