import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';

class _MockUserAgreementStatusRepository extends Mock implements UserAgreementStatusRepository {}

class _MockContactsAgreementStatusRepository extends Mock implements ContactsAgreementStatusRepository {}

class _MockSessionRepository extends Mock implements SessionRepository {}

class _MockLocaleRepository extends Mock implements LocaleRepository {}

class _MockThemeModeRepository extends Mock implements ThemeModeRepository {}

class _MockSystemInfoRepository extends Mock implements SystemInfoRepository {}

class _MockUserSessionCleanupResolver extends Mock implements UserSessionCleanupResolver {}

class _MockAppInfo extends Mock implements AppInfo {}

// The default core version constraint is '>=0.7.0-alpha <2.0.0'.
WebtritSystemInfo _systemInfo({Version? coreVersion, Version? minSupportedAppVersion}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: coreVersion ?? Version(1, 0, 0)),
    postgres: PostgresInfo(),
    minSupportedAppVersion: minSupportedAppVersion,
  );
}

void main() {
  late _MockUserAgreementStatusRepository userAgreementStatusRepository;
  late _MockContactsAgreementStatusRepository contactsAgreementStatusRepository;
  late _MockSessionRepository sessionRepository;
  late _MockLocaleRepository localeRepository;
  late _MockThemeModeRepository themeModeRepository;
  late _MockSystemInfoRepository systemInfoRepository;
  late _MockUserSessionCleanupResolver userSessionCleanupResolver;
  late _MockAppInfo appInfo;
  late StreamController<WebtritSystemInfo> infoStreamController;

  setUpAll(() {
    registerFallbackValue(FetchPolicy.cacheFirst);
  });

  setUp(() {
    userAgreementStatusRepository = _MockUserAgreementStatusRepository();
    contactsAgreementStatusRepository = _MockContactsAgreementStatusRepository();
    sessionRepository = _MockSessionRepository();
    localeRepository = _MockLocaleRepository();
    themeModeRepository = _MockThemeModeRepository();
    systemInfoRepository = _MockSystemInfoRepository();
    userSessionCleanupResolver = _MockUserSessionCleanupResolver();
    appInfo = _MockAppInfo();
    infoStreamController = StreamController<WebtritSystemInfo>.broadcast();

    when(() => sessionRepository.getCurrent()).thenReturn(const Session());
    when(() => themeModeRepository.getThemeMode()).thenReturn(ThemeMode.system);
    when(() => localeRepository.getLocale()).thenReturn(const Locale('en'));
    when(() => userAgreementStatusRepository.getUserAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => contactsAgreementStatusRepository.getContactsAgreementStatus()).thenReturn(AgreementStatus.accepted);

    when(() => systemInfoRepository.infoStream).thenAnswer((_) => infoStreamController.stream);
    when(
      () => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')),
    ).thenAnswer((_) async => null);
  });

  tearDown(() async {
    await infoStreamController.close();
  });

  AppBloc buildBloc(String appVersion) {
    when(() => appInfo.version).thenReturn(Version.parse(appVersion));
    return AppBloc(
      userAgreementStatusRepository: userAgreementStatusRepository,
      contactsAgreementStatusRepository: contactsAgreementStatusRepository,
      sessionRepository: sessionRepository,
      localeRepository: localeRepository,
      themeModeRepository: themeModeRepository,
      systemInfoRepository: systemInfoRepository,
      userSessionCleanupResolver: userSessionCleanupResolver,
      appInfo: appInfo,
      appCompatibilityResolver: const DefaultAppCompatibilityResolver(),
    );
  }

  test('starts compatible when no system info is available', () {
    final bloc = buildBloc('1.15.3');
    addTearDown(bloc.close);
    expect(bloc.state.appCompatibility, const AppCompatible());
  });

  test('resolves AppVersionTooOld when the running app is older than the minimum', () async {
    final bloc = buildBloc('1.15.3');
    addTearDown(bloc.close);

    infoStreamController.add(_systemInfo(minSupportedAppVersion: Version(2, 0, 0)));
    await Future<void>.delayed(Duration.zero);

    expect(
      bloc.state.appCompatibility,
      AppVersionTooOld(appVersion: Version(1, 15, 3), minSupportedVersion: Version(2, 0, 0)),
    );
  });

  test('resolves CoreVersionUnsupported when the backend core is out of constraint', () async {
    final bloc = buildBloc('1.15.3');
    addTearDown(bloc.close);

    infoStreamController.add(_systemInfo(coreVersion: Version(2, 5, 0)));
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.appCompatibility, isA<CoreVersionUnsupported>());
  });

  test('resolves AppCompatible when the app and core satisfy the requirements', () async {
    final bloc = buildBloc('1.15.3');
    addTearDown(bloc.close);

    infoStreamController.add(_systemInfo(coreVersion: Version(1, 0, 0), minSupportedAppVersion: Version(1, 0, 0)));
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.appCompatibility, const AppCompatible());
  });

  test('compareToReevaluate returns false when the gate flips', () {
    final bloc = buildBloc('1.15.3');
    addTearDown(bloc.close);

    final compatible = bloc.state;
    final gated = bloc.state.copyWith(
      appCompatibility: AppVersionTooOld(appVersion: Version(1, 15, 3), minSupportedVersion: Version(2, 0, 0)),
    );

    expect(compatible.compareToReevaluate(gated), isFalse);
    expect(compatible.compareToReevaluate(compatible), isTrue);
  });
}
