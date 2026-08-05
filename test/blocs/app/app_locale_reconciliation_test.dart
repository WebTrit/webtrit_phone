import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
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
    when(() => userAgreementStatusRepository.getUserAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => contactsAgreementStatusRepository.getContactsAgreementStatus()).thenReturn(AgreementStatus.accepted);
    when(() => appInfo.version).thenReturn(Version(1, 0, 0));

    when(() => systemInfoRepository.infoStream).thenAnswer((_) => infoStreamController.stream);
    when(
      () => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')),
    ).thenAnswer((_) async => null);
  });

  tearDown(() async {
    await infoStreamController.close();
  });

  AppBloc buildBloc({required Locale persisted, required List<Locale> supportedLocales}) {
    when(() => localeRepository.getLocale()).thenReturn(persisted);
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
      supportedLocales: supportedLocales,
    );
  }

  group('initial locale reconciliation against the supported locales', () {
    test('keeps the persisted locale when it is still supported', () {
      final bloc = buildBloc(persisted: const Locale('en'), supportedLocales: const [Locale('en'), Locale('uk')]);
      addTearDown(bloc.close);
      expect(bloc.state.locale, const Locale('en'));
    });

    test('falls back to default when the persisted locale is no longer supported', () {
      final bloc = buildBloc(persisted: const Locale('en'), supportedLocales: const [Locale('uk'), Locale('it')]);
      addTearDown(bloc.close);
      expect(bloc.state.locale, LocaleExtension.defaultNull);
      expect(bloc.state.effectiveLocale, isNull);
    });

    test('keeps the default (follow-system) locale untouched with multiple languages', () {
      final bloc = buildBloc(
        persisted: LocaleExtension.defaultNull,
        supportedLocales: const [Locale('uk'), Locale('it')],
      );
      addTearDown(bloc.close);
      expect(bloc.state.locale, LocaleExtension.defaultNull);
    });

    test('pins to the only supported language when the persisted locale differs', () {
      final bloc = buildBloc(persisted: const Locale('en'), supportedLocales: const [Locale('uk')]);
      addTearDown(bloc.close);
      expect(bloc.state.locale, const Locale('uk'));
      expect(bloc.state.effectiveLocale, const Locale('uk'));
    });

    test('pins to the only supported language even when following the system', () {
      final bloc = buildBloc(persisted: LocaleExtension.defaultNull, supportedLocales: const [Locale('uk')]);
      addTearDown(bloc.close);
      expect(bloc.state.locale, const Locale('uk'));
    });

    test('treats an empty supported list as unrestricted and keeps the persisted locale', () {
      final bloc = buildBloc(persisted: const Locale('en'), supportedLocales: const []);
      addTearDown(bloc.close);
      expect(bloc.state.locale, const Locale('en'));
    });
  });
}
