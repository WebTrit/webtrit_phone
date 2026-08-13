import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/data/data.dart';

class _MockPackageInfo extends Mock implements PackageInfo {}

class _MockDeviceInfo extends Mock implements DeviceInfo {}

class _MockAppInfo extends Mock implements AppInfo {}

class _MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late _MockPackageInfo packageInfo;
  late _MockDeviceInfo deviceInfo;
  late _MockAppInfo appInfo;

  setUp(() {
    packageInfo = _MockPackageInfo();
    deviceInfo = _MockDeviceInfo();
    appInfo = _MockAppInfo();

    when(() => packageInfo.appName).thenReturn('WebTrit');
    when(() => appInfo.version).thenReturn(Version(1, 8, 2));
    when(() => deviceInfo.model).thenReturn('iPhone14,3');
    when(() => deviceInfo.systemName).thenReturn('iOS');
    when(() => deviceInfo.systemVersion).thenReturn('17.4');
  });

  test('buildUserAgent names the app build and the device', () {
    expect(
      DefaultAppMetadataProvider.buildUserAgent(packageInfo, appInfo, deviceInfo),
      equals('WebTrit/1.8.2 (iPhone14,3; iOS: 17.4)'),
    );
  });

  test('the User-Agent sent to the backend is the string presence uses as the device name', () async {
    final provider = await DefaultAppMetadataProvider.init(packageInfo, deviceInfo, appInfo, _MockSecureStorage());

    expect(provider.userAgent, equals(DefaultAppMetadataProvider.buildUserAgent(packageInfo, appInfo, deviceInfo)));
  });
}
