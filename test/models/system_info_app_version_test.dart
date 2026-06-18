import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_phone/models/models.dart';

WebtritSystemInfo _systemInfo({Version? minSupportedAppVersion}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: Version(1, 0, 0)),
    postgres: PostgresInfo(),
    minSupportedAppVersion: minSupportedAppVersion,
  );
}

void main() {
  group('WebtritSystemInfo.isAppVersionSupported', () {
    test('returns true when the backend declares no minimum (null)', () {
      final info = _systemInfo(minSupportedAppVersion: null);
      expect(info.isAppVersionSupported(Version(1, 0, 0)), isTrue);
      expect(info.isAppVersionSupported(Version(0, 1, 0)), isTrue);
    });

    test('returns true for debug/sideload builds reporting 0.0.0', () {
      final info = _systemInfo(minSupportedAppVersion: Version(2, 0, 0));
      expect(info.isAppVersionSupported(Version(0, 0, 0)), isTrue);
    });

    test('returns false when the app version is below the minimum', () {
      final info = _systemInfo(minSupportedAppVersion: Version(1, 5, 0));
      expect(info.isAppVersionSupported(Version(1, 4, 9)), isFalse);
      expect(info.isAppVersionSupported(Version(1, 0, 0)), isFalse);
    });

    test('returns true when the app version equals the minimum', () {
      final info = _systemInfo(minSupportedAppVersion: Version(1, 5, 0));
      expect(info.isAppVersionSupported(Version(1, 5, 0)), isTrue);
    });

    test('returns true when the app version is above the minimum', () {
      final info = _systemInfo(minSupportedAppVersion: Version(1, 5, 0));
      expect(info.isAppVersionSupported(Version(1, 5, 1)), isTrue);
      expect(info.isAppVersionSupported(Version(2, 0, 0)), isTrue);
    });
  });
}
