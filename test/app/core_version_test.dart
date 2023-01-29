import 'package:flutter_test/flutter_test.dart';

import 'package:version/version.dart';

import 'package:webtrit_phone/app/core_version.dart';

void main() {
  late final CoreVersion coreVersion;

  setUp(() {
    coreVersion = CoreVersion(Version(0, 1, 0, preRelease: ['alpha']), Version(0, 2, 0));
  });

  test('verifyCompatibility', () {
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 0)), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 0, build: '1')), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 0, preRelease: ['alpha'])), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 0, preRelease: ['alpha', '1'])), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 0, preRelease: ['beta', '1'])), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 1, 5)), returnsNormally);
    expect(() => coreVersion.verifyCompatibility(Version(0, 0, 0)), throwsA(isA<IncompatibleCoreVersionException>()));
    expect(() => coreVersion.verifyCompatibility(Version(0, 2, 0)), throwsA(isA<IncompatibleCoreVersionException>()));
  });
}
