import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockSystemInfoRepository extends Mock implements SystemInfoRepository {}

class _MockPrivateGatewayRepository extends Mock implements PrivateGatewayRepository {}

class _FakePackageInfo implements PackageInfo {
  _FakePackageInfo(this.version);

  @override
  final String version;

  @override
  String get appName => 'WebTrit';

  @override
  String get packageName => 'com.webtrit.app';

  @override
  String get buildNumber => '0';
}

const _coreVersionConstraint = '>=0.7.0-alpha <2.0.0';

WebtritSystemInfo _systemInfo({Version? minSupportedAppVersion}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: Version(1, 0, 0)),
    postgres: PostgresInfo(),
    minSupportedAppVersion: minSupportedAppVersion,
  );
}

void main() {
  late _MockSystemInfoRepository systemInfoRepository;
  late _MockPrivateGatewayRepository privateGatewayRepository;

  setUp(() {
    systemInfoRepository = _MockSystemInfoRepository();
    privateGatewayRepository = _MockPrivateGatewayRepository();
  });

  MainBloc buildBloc(String appVersion) {
    return MainBloc(
      systemInfoRepository,
      privateGatewayRepository,
      _coreVersionConstraint,
      _FakePackageInfo(appVersion),
    );
  }

  blocTest<MainBloc, MainBlocState>(
    'emits AppVersionUnsupported when the running app is older than the minimum',
    build: () => buildBloc('1.15.3'),
    act: (bloc) => bloc.add(MainBlocSystemInfoArrived(_systemInfo(minSupportedAppVersion: Version(2, 0, 0)))),
    expect: () => [
      isA<MainBlocState>().having(
        (s) => s.coreVersionState,
        'coreVersionState',
        isA<AppVersionUnsupported>()
            .having((s) => s.currentVersion, 'currentVersion', Version(1, 15, 3))
            .having((s) => s.minSupportedVersion, 'minSupportedVersion', Version(2, 0, 0))
            .having((s) => s.updateStoreUrl, 'updateStoreUrl', isNull),
      ),
    ],
  );

  blocTest<MainBloc, MainBlocState>(
    'emits Compatible when the backend declares no minimum (null)',
    build: () => buildBloc('1.15.3'),
    act: (bloc) => bloc.add(MainBlocSystemInfoArrived(_systemInfo(minSupportedAppVersion: null))),
    expect: () => [isA<MainBlocState>().having((s) => s.coreVersionState, 'coreVersionState', isA<Compatible>())],
  );

  blocTest<MainBloc, MainBlocState>(
    'emits Compatible when the running app satisfies the minimum',
    build: () => buildBloc('1.15.3'),
    act: (bloc) => bloc.add(MainBlocSystemInfoArrived(_systemInfo(minSupportedAppVersion: Version(1, 0, 0)))),
    expect: () => [isA<MainBlocState>().having((s) => s.coreVersionState, 'coreVersionState', isA<Compatible>())],
  );
}
