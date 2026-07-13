import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/cache_management/sections/voicemail_cache_section.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  late Directory root;

  setUp(() {
    root = Directory.systemTemp.createTempSync('voicemail_cache_test');
  });

  tearDown(() {
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  VoicemailCacheSection createSection() {
    return VoicemailCacheSection(mediaCacheBasePath: '${root.path}/media_cache', temporaryPath: root.path);
  }

  File writeFile(String relativePath, int size) {
    final file = File('${root.path}/$relativePath')..createSync(recursive: true);
    file.writeAsBytesSync(List.filled(size, 0));
    return file;
  }

  Future<int> measure(VoicemailCacheSection section) async {
    final usage = await section.usage();
    expect(usage.unit, CacheUsageUnit.bytes);
    return usage.amount;
  }

  test('sums files of both cache locations, including nested ones', () async {
    writeFile('media_cache/vm-1', 100);
    writeFile('media_cache/nested/vm-2', 50);
    writeFile('just_audio_cache/remote/audio.mp3', 25);

    expect(await measure(createSection()), 175);
  });

  test('reports zero when nothing is cached yet', () async {
    expect(await measure(createSection()), 0);
  });

  test('clear removes both cache locations', () async {
    writeFile('media_cache/vm-1', 100);
    writeFile('just_audio_cache/audio.mp3', 25);

    final section = createSection();
    await section.clear();

    expect(Directory('${root.path}/media_cache').existsSync(), isFalse);
    expect(Directory('${root.path}/just_audio_cache').existsSync(), isFalse);
    expect(await measure(section), 0);
  });

  test('clear is a no-op when nothing is cached yet', () async {
    await createSection().clear();

    expect(await measure(createSection()), 0);
  });
}
