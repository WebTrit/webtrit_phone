import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/cache_management.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  test('reports the model files size as byte usage', () async {
    final section = TranscriptionModelsCacheSection(sizeBytes: () async => 142 * 1024 * 1024, deleteAll: () async {});

    expect(await section.usage(), const CacheUsage.bytes(142 * 1024 * 1024));
  });

  test('clear deletes the downloaded models', () async {
    var deleted = false;
    final section = TranscriptionModelsCacheSection(sizeBytes: () async => 0, deleteAll: () async => deleted = true);

    await section.clear();

    expect(deleted, isTrue);
  });
}
