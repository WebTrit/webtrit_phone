import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/core_version.dart';

void main() {
  late final CoreVersion coreVersion;

  setUpAll(() {
    coreVersion = CoreVersion(VersionConstraint.parse('>=0.1.0-alpha <0.2.0'));
  });

  test('verify', () {
    expect(() => coreVersion.verify(Version(0, 1, 0)), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 1, 0, build: '1')), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 1, 0, pre: 'alpha')), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 1, 0, pre: 'alpha.1')), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 1, 0, pre: 'beta.1')), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 1, 5)), returnsNormally);
    expect(() => coreVersion.verify(Version(0, 0, 0)), throwsA(isA<IncompatibleCoreVersionException>()));
    expect(() => coreVersion.verify(Version(0, 2, 0, pre: 'alpha')), throwsA(isA<IncompatibleCoreVersionException>()));
    expect(() => coreVersion.verify(Version(0, 2, 0)), throwsA(isA<IncompatibleCoreVersionException>()));
  });

  test('==', () {
    expect(coreVersion, equals(CoreVersion(VersionConstraint.parse('>=0.1.0-alpha <0.2.0'))));
    expect(
      coreVersion,
      equals(CoreVersion(VersionRange(
        min: Version(0, 1, 0, pre: 'alpha'),
        max: Version(0, 2, 0),
        includeMin: true,
      ))),
    );
  });

  test('toString', () {
    expect(coreVersion.toString(), equals('>=0.1.0-alpha <0.2.0'));
  });
}
