/// The cached system info used to live in secure storage and now lives in app
/// preferences, so every install that upgrades starts with an empty cache.
/// These tests pin what that costs the user: the shell guard refetches the
/// value, and sends them back to login when it cannot.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/resolvers/resolvers.dart';

import '../../mocks/mock_app_preferences.dart';
import 'main_shell_harness.dart';
import '../../helpers/feature_access_factories.dart';

class _FakeNavigationResolver extends Fake implements NavigationResolver {
  final resolutions = <bool>[];

  var overrodeNext = false;

  @override
  bool get isReevaluating => false;

  @override
  void next([bool continueNavigation = true]) => resolutions.add(continueNavigation);

  @override
  void overrideNext({
    List<PageRouteInfo>? children,
    Object? args,
    Map<String, dynamic>? queryParams,
    String? fragment,
    bool reevaluateNext = true,
  }) => overrodeNext = true;
}

class _FakeStackRouter extends Fake implements StackRouter {
  final replacements = <List<PageRouteInfo>>[];

  @override
  Future<void> replaceAll(
    List<PageRouteInfo> routes, {
    OnNavigationFailure? onFailure,
    bool updateExistingRoutes = true,
  }) async {
    replacements.add(routes);
  }
}

void main() {
  late MockAppBloc appBloc;
  late MockSystemInfoRepository systemInfoRepository;
  late MockAppPermissions appPermissions;
  late _FakeNavigationResolver resolver;
  late _FakeStackRouter router;

  setUpAll(registerHarnessFallbacks);

  setUp(() {
    // The guard builds its log line from the resolver's route, which the fake
    // does not carry; keeping fine records off leaves that closure unevaluated.
    Logger.root.level = Level.INFO;

    appBloc = MockAppBloc();
    systemInfoRepository = MockSystemInfoRepository();
    appPermissions = MockAppPermissions();
    resolver = _FakeNavigationResolver();
    router = _FakeStackRouter();

    when(() => appPermissions.isDenied).thenAnswer((_) async => false);
    when(() => appBloc.state).thenReturn(
      AppState(
        status: AppLifecycleStatus.authenticated,
        session: const Session(coreUrl: 'http://127.0.0.1:1', token: 'test-token', userId: 'test-user'),
        themeMode: ThemeMode.system,
        locale: const Locale('en'),
        userAgreementStatus: AgreementStatus.accepted,
        contactsAgreementStatus: AgreementStatus.accepted,
      ),
    );
  });

  AppRouter buildRouter() {
    final featureAccess = featureAccessFor(systemInfoWithSupported(const []));
    return AppRouter(
      appBloc,
      appPermissions,
      systemInfoRepository,
      null,
      featureAccess.bottomMenuConfig,
      BottomMenuInitialTabResolver(
        config: featureAccess.bottomMenuConfig,
        repository: ActiveMainTabRepositoryPrefsImpl(MockAppPreferences()),
      ),
      featureAccess.checker,
    );
  }

  bool wasSentToLogin() => router.replacements.any((routes) => routes.first is LoginRouterPageRoute);

  group('main shell guard without cached system info', () {
    test('sends the user back to login when the value cannot be fetched', () async {
      when(() => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')))
          .thenThrow(Exception('no network'));

      await buildRouter().onMainShellRouteGuardNavigation(resolver, router);

      expect(resolver.resolutions, [false]);
      expect(wasSentToLogin(), isTrue);
    });

    test('sends the user back to login when the core answers without it', () async {
      when(() => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')))
          .thenAnswer((_) async => null);

      await buildRouter().onMainShellRouteGuardNavigation(resolver, router);

      expect(resolver.resolutions, [false]);
      expect(wasSentToLogin(), isTrue);
    });

    test('keeps the user signed in when the value is refetched', () async {
      final systemInfo = systemInfoWithSupported(const []);
      when(() => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')))
          .thenAnswer((_) async => systemInfo);

      await buildRouter().onMainShellRouteGuardNavigation(resolver, router);

      expect(wasSentToLogin(), isFalse);
      expect(resolver.overrodeNext, isTrue);
    });

    test('reads the value through the cache-first policy, so one fetch refills the cache', () async {
      final systemInfo = systemInfoWithSupported(const []);
      when(() => systemInfoRepository.getSystemInfo(fetchPolicy: any(named: 'fetchPolicy')))
          .thenAnswer((_) async => systemInfo);

      await buildRouter().onMainShellRouteGuardNavigation(resolver, router);

      verify(() => systemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheFirst)).called(1);
    });
  });
}
