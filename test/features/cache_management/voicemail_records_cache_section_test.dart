import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/view/voicemail_records_cache_section.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../mocks/voicemails_fixture_factory.dart';

void main() {
  late AppDatabase appDatabase;
  late VoicemailRecordsCacheSection section;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    section = VoicemailRecordsCacheSection(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  test('reports the stored records count as items', () async {
    for (final id in ['1', '2', '3']) {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(VoicemailsFixtureFactory.createVoicemail(id: id));
    }

    final usage = await section.usage();

    expect(usage.unit, CacheUsageUnit.items);
    expect(usage.amount, 3);
  });

  test('reports zero for an empty list', () async {
    final usage = await section.usage();

    expect(usage.amount, 0);
  });

  test('clear wipes the stored records', () async {
    await appDatabase.voicemailDao.insertOrUpdateVoicemail(VoicemailsFixtureFactory.createVoicemail(id: '1'));

    await section.clear();

    expect((await section.usage()).amount, 0);
  });
}
