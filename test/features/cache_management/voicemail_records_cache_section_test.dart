import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/cubit/voicemail_records_cache_section.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _FakeVoicemailRepository extends EmptyVoicemailRepository {
  _FakeVoicemailRepository({this.records = 0});

  int records;
  int wipeCalls = 0;

  @override
  Future<int> localRecordsCount() async => records;

  @override
  Future<void> wipeLocalRecords() async {
    wipeCalls++;
    records = 0;
  }
}

void main() {
  test('reports the stored records count as items', () async {
    final section = VoicemailRecordsCacheSection(_FakeVoicemailRepository(records: 3));

    final usage = await section.usage();

    expect(usage.unit, CacheUsageUnit.items);
    expect(usage.amount, 3);
  });

  test('clear wipes only the local records through the repository', () async {
    final repository = _FakeVoicemailRepository(records: 2);
    final section = VoicemailRecordsCacheSection(repository);

    await section.clear();

    expect(repository.wipeCalls, 1);
    expect((await section.usage()).amount, 0);
  });
}
