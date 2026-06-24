import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/version_gate/version_gate.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

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

AppState _appState(AppCompatibility compatibility) => AppState(
  themeMode: ThemeMode.system,
  locale: const Locale('en'),
  userAgreementStatus: AgreementStatus.accepted,
  contactsAgreementStatus: AgreementStatus.accepted,
  appCompatibility: compatibility,
);

void main() {
  late _MockAppBloc appBloc;

  setUp(() {
    appBloc = _MockAppBloc();
  });

  Widget host({required Version current, required Version min}) {
    when(() => appBloc.state).thenReturn(_appState(AppVersionTooOld(appVersion: current, minSupportedVersion: min)));

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          Provider<PackageInfo>.value(value: _FakePackageInfo(current.toString())),
          BlocProvider<AppBloc>.value(value: appBloc),
        ],
        child: const UpdateRequiredScreenPage(),
      ),
    );
  }

  testWidgets('renders title, description, both versions and the logout action', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0)));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(UpdateRequiredScreenPage));
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_title), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_description), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_currentVersionLabel), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_minimumVersionLabel), findsOneWidget);
    expect(find.text('1.14.0'), findsOneWidget);
    expect(find.text('1.15.0'), findsOneWidget);
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout), findsOneWidget);
  });

  testWidgets('hides the Update action when no newer store build is available', (tester) async {
    // On the test platform StoreInfoExtractor resolves to null, so the Update
    // button must never appear.
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0)));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(UpdateRequiredScreenPage));
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_update), findsNothing);
  });

  testWidgets('dispatches AppLogoutRequested when Logout is tapped', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0)));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(UpdateRequiredScreenPage));
    await tester.tap(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout));
    await tester.pump();

    verify(() => appBloc.add(const AppLogoutRequested(reason: AppLogoutReason.userRequest))).called(1);
  });
}
