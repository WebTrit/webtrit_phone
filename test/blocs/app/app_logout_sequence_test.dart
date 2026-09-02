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

const _session = Session(coreUrl: 'https://core.example.com', token: 'token', userId: 'user');

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
  late Session currentSession;

  setUpAll(() {
    registerFallbackValue(FetchPolicy.cacheFirst);
    registerFallbackValue(const Session());
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
    currentSession = _session;

    when(() => sessionRepository.getCurrent()).thenAnswer((_) => currentSession);
    when(() => sessionRepository.revokeSession(any())).thenAnswer((_) async {});
    when(() => sessionRepository.clean()).thenAnswer((_) async {
      currentSession = const Session();
    });
    when(() => userSessionCleanupResolver.resolve()).thenAnswer((_) async {});
    when(() => themeModeRepository.getThemeMode()).thenReturn(ThemeMode.system);
    when(() => localeRepository.getLocale()).thenReturn(const Locale('en'));
    when(() => userAgreementStatusRepository.getUserAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => contactsAgreementStatusRepository.getContactsAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => appInfo.version).thenReturn(Version.parse('1.16.5'));

    when(() => systemInfoRepository.infoStream).thenAnswer((_) => infoStreamController.stream);
    when(() => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')))
        .thenAnswer((_) async => null);
  });

  tearDown(() async {
    await infoStreamController.close();
  });

  AppBloc buildBloc() {
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

  test('logout of an authenticated session starts the teardown sequence', () async {
    final bloc = buildBloc();
    addTearDown(bloc.close);
    expect(bloc.state.status, AppLifecycleStatus.authenticated);

    bloc.add(const AppLogoutRequested(reason: AppLogoutReason.serverRejection));
    await pumpEventQueue();

    expect(bloc.state.status, AppLifecycleStatus.teardown);
    expect(bloc.state.logoutReason, AppLogoutReason.serverRejection);
  });

  test('a logout arriving after the session is gone does not re-enter teardown', () async {
    final bloc = buildBloc();
    addTearDown(bloc.close);

    bloc.add(const AppLogoutRequested());
    await pumpEventQueue();
    bloc.add(const AppCleanupRequested());
    await pumpEventQueue();

    expect(bloc.state.status, AppLifecycleStatus.unauthenticated);

    // A request issued before the logout completes afterwards with 401 and asks
    // for another logout; without an active session there is nothing to tear
    // down, and entering teardown again would strand the app on that screen.
    bloc.add(const AppLogoutRequested(reason: AppLogoutReason.serverRejection));
    await pumpEventQueue();

    expect(bloc.state.status, AppLifecycleStatus.unauthenticated);
    expect(bloc.state.logoutReason, isNull);
    expect(bloc.state.session, const Session());
  });

  test('a logout arriving during teardown keeps the reason the sequence started with', () async {
    final bloc = buildBloc();
    addTearDown(bloc.close);

    bloc.add(const AppLogoutRequested());
    await pumpEventQueue();
    bloc.add(const AppLogoutRequested(reason: AppLogoutReason.userNotFound));
    await pumpEventQueue();

    expect(bloc.state.status, AppLifecycleStatus.teardown);
    expect(bloc.state.logoutReason, AppLogoutReason.userRequest);
  });
}
