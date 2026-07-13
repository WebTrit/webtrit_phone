import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/view/cdrs_cache_section.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

void main() {
  late AppDatabase appDatabase;
  late CdrsLocalRepository repository;
  late CdrsCacheSection section;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    repository = CdrsLocalRepositoryDriftImpl(appDatabase);
    section = CdrsCacheSection(repository);
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

  test('reports the stored records count as items', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1'), createCdr('2'), createCdr('3')]);

    final usage = await section.usage();

    expect(usage.unit, CacheUsageUnit.items);
    expect(usage.amount, 3);
  });

  test('reports zero for an empty history', () async {
    final usage = await section.usage();

    expect(usage.amount, 0);
  });

  test('clear wipes the stored records', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1'), createCdr('2')]);

    await section.clear();

    expect((await section.usage()).amount, 0);
  });

  test('clear notifies listeners holding records in memory', () async {
    await appDatabase.cdrsDao.upsertCdrs([createCdr('1')]);
    final events = expectLater(repository.events, emits(isA<CdrRecordsWiped>()));

    await section.clear();

    await events;
  });
}
