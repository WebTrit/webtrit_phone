import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';
import 'package:webtrit_phone/models/system_info/components/core_info.dart';

void main() {
  late final VersionConstraint versionConstraint;

  setUpAll(() {
    versionConstraint = VersionConstraint.parse('>=0.1.0-alpha <0.2.0');
  });

  test('verify', () {
    expect(CoreInfo(version: Version(0, 1, 0)).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 1, 0, build: '1')).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 1, 0, pre: 'alpha')).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 1, 0, pre: 'alpha.1')).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 1, 0, pre: 'beta.1')).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 1, 5)).verifyVersion(versionConstraint), true);
    expect(CoreInfo(version: Version(0, 0, 0)).verifyVersion(versionConstraint), false);
    expect(CoreInfo(version: Version(0, 2, 0, pre: 'alpha')).verifyVersion(versionConstraint), false);
    expect(CoreInfo(version: Version(0, 2, 0)).verifyVersion(versionConstraint), false);
  });

  test('==', () {
    expect(CoreInfo(version: Version(0, 1, 0)) == CoreInfo(version: Version(0, 1, 0)), true);
    expect(CoreInfo(version: Version(0, 1, 0)) == CoreInfo(version: Version(0, 1, 0, build: '1')), false);
  });

  test('toString', () {
    expect(CoreInfo(version: Version(0, 1, 0)).toString(), equals('CoreInfo(0.1.0)'));
  });
}
