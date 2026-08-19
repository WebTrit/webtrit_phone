import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/settings/features/about/about.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

class _MockAboutBloc extends MockBloc<AboutEvent, AboutState> implements AboutBloc {}

class _MockStackRouter extends Mock implements StackRouter {}

class _FakePageRouteInfo extends Fake implements PageRouteInfo {}

EmbeddedData _resource(String uri) =>
    EmbeddedData(id: uri, uri: Uri.parse(uri), reconnectStrategy: ReconnectStrategy.softReload);

void main() {
  const openable = 'https://webtrit.com/legal/privacy-policy-for-webtrit-app/';
  const unopenable = 'mailto:support@webtrit.com';

  setUpAll(() => registerFallbackValue(_FakePageRouteInfo()));

  late _MockAboutBloc bloc;
  late _MockStackRouter router;

  setUp(() {
    bloc = _MockAboutBloc();
    router = _MockStackRouter();

    when(
      () => router.canPop(
        ignoreChildRoutes: any(named: 'ignoreChildRoutes'),
        ignoreParentRoutes: any(named: 'ignoreParentRoutes'),
        ignorePagelessRoutes: any(named: 'ignorePagelessRoutes'),
      ),
    ).thenReturn(false);
    when(() => router.topPage).thenReturn(null);
    when(() => router.pagelessRoutesObserver).thenReturn(PagelessRoutesObserver());
    when(() => router.navigate(any(), onFailure: any(named: 'onFailure'))).thenAnswer((_) async {});
  });

  Widget wrap(List<EmbeddedData> resources) {
    when(() => bloc.state).thenReturn(
      AboutState(
        embeddedResources: resources,
        packageName: 'com.webtrit.app',
        appIdentifier: 'app-identifier',
        coreUrl: Uri.parse('https://core.webtrit.com'),
        userAgent: 'user-agent',
        appInfo: 'app-info',
        deviceInfo: 'device-info',
        callkeepVersion: '1.3.3',
      ),
    );

    return ThemeProvider(
      settings: const ThemeSettings(),
      lightDynamic: null,
      darkDynamic: null,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RouterScope(
          controller: router,
          inheritableObserversBuilder: () => const [],
          stateHash: 0,
          navigatorObservers: const [],
          child: StackRouterScope(
            controller: router,
            stateHash: 0,
            child: BlocProvider<AboutBloc>.value(value: bloc, child: const AboutScreen()),
          ),
        ),
      ),
    );
  }

  Future<void> openDialog(WidgetTester tester, List<EmbeddedData> resources) async {
    await tester.pumpWidget(wrap(resources));
    await tester.tap(find.text('Application embedded links'));
    await tester.pumpAndSettle();
  }

  EmbeddedScreenPageRoute capturedRoute() {
    final route = verify(() => router.navigate(captureAny(), onFailure: any(named: 'onFailure'))).captured.single;
    return route as EmbeddedScreenPageRoute;
  }

  testWidgets('tapping an address opens that resource in the app', (tester) async {
    final privacyPolicy = _resource(openable);

    await openDialog(tester, [privacyPolicy]);
    await tester.tap(find.text(openable));
    await tester.pumpAndSettle();

    expect(capturedRoute().args?.data, privacyPolicy);
  });

  testWidgets('the dialog closes behind the resource it opened', (tester) async {
    await openDialog(tester, [_resource(openable)]);
    await tester.tap(find.text(openable));
    await tester.pumpAndSettle();

    expect(find.text(openable), findsNothing);
  });

  testWidgets('an address the app cannot open leads nowhere', (tester) async {
    await openDialog(tester, [_resource(unopenable)]);
    await tester.tap(find.text(unopenable));
    await tester.pumpAndSettle();

    verifyNever(() => router.navigate(any(), onFailure: any(named: 'onFailure')));
    expect(find.text(unopenable), findsOneWidget);
  });

  testWidgets('every configured resource is listed, openable or not', (tester) async {
    await openDialog(tester, [_resource(openable), _resource(unopenable)]);

    expect(find.text(openable), findsOneWidget);
    expect(find.text(unopenable), findsOneWidget);
  });
}
