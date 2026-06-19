import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_phone/models/models.dart';

const _coreConstraint = '>=1.0.0 <2.0.0';

WebtritSystemInfo _systemInfo({required Version coreVersion, Version? minSupportedAppVersion}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: coreVersion),
    postgres: PostgresInfo(),
    minSupportedAppVersion: minSupportedAppVersion,
  );
}

AppCompatibility _resolve(WebtritSystemInfo systemInfo, Version appVersion) {
  return const DefaultAppCompatibilityResolver().resolve(
    systemInfo: systemInfo,
    appVersion: appVersion,
    coreVersionConstraint: _coreConstraint,
  );
}

void main() {
  group('DefaultAppCompatibilityResolver.resolve', () {
    test('is AppCompatible when core is in range and app satisfies (or no) minimum', () {
      final noMinimum = _systemInfo(coreVersion: Version(1, 5, 0));
      expect(_resolve(noMinimum, Version(1, 0, 0)), isA<AppCompatible>());

      final withMinimum = _systemInfo(coreVersion: Version(1, 5, 0), minSupportedAppVersion: Version(1, 2, 0));
      expect(_resolve(withMinimum, Version(1, 2, 0)), isA<AppCompatible>());
    });

    test('is CoreVersionUnsupported when core is outside the constraint', () {
      final info = _systemInfo(coreVersion: Version(3, 0, 0));
      final result = _resolve(info, Version(1, 0, 0));

      expect(result, isA<CoreVersionUnsupported>());
      final core = result as CoreVersionUnsupported;
      expect(core.coreVersion, Version(3, 0, 0));
      expect(core.constraint, VersionConstraint.parse(_coreConstraint));
    });

    test('is AppVersionTooOld when the app is below the declared minimum', () {
      final info = _systemInfo(coreVersion: Version(1, 5, 0), minSupportedAppVersion: Version(1, 16, 0));
      final result = _resolve(info, Version(1, 15, 0));

      expect(result, isA<AppVersionTooOld>());
      final tooOld = result as AppVersionTooOld;
      expect(tooOld.appVersion, Version(1, 15, 0));
      expect(tooOld.minSupportedVersion, Version(1, 16, 0));
    });

    test('app-too-old takes priority when both the app and core checks fail', () {
      final info = _systemInfo(coreVersion: Version(3, 0, 0), minSupportedAppVersion: Version(1, 16, 0));
      expect(_resolve(info, Version(1, 15, 0)), isA<AppVersionTooOld>());
    });

    test('never blocks 0.0.0 debug/sideload builds even with a minimum set', () {
      final info = _systemInfo(coreVersion: Version(1, 5, 0), minSupportedAppVersion: Version(2, 0, 0));
      expect(_resolve(info, Version(0, 0, 0)), isA<AppCompatible>());
    });
  });
}
