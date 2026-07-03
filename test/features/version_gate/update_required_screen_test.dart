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

class _MockAppInfo extends Mock implements AppInfo {}

class _FakePackageInfo implements PackageInfo {
  _FakePackageInfo(this.version, [this.buildNumber = '0']);

  @override
  final String version;

  @override
  final String buildNumber;

  @override
  String get appName => 'WebTrit';

  @override
  String get packageName => 'com.webtrit.app';
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
  late _MockAppInfo appInfo;

  setUp(() {
    appBloc = _MockAppBloc();
    appInfo = _MockAppInfo();
  });

  Widget host({
    required Version current,
    required Version min,
    String storeVersion = '0.0.0',
    String storeBuildNumber = '0',
  }) {
    when(() => appBloc.state).thenReturn(_appState(AppVersionTooOld(appVersion: current, minSupportedVersion: min)));
    when(() => appInfo.version).thenReturn(current);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          Provider<AppInfo>.value(value: appInfo),
          Provider<PackageInfo>.value(value: _FakePackageInfo(storeVersion, storeBuildNumber)),
          BlocProvider<AppBloc>.value(value: appBloc),
        ],
        child: const UpdateRequiredScreenPage(),
      ),
    );
  }

  testWidgets('renders title, description, both versions and the logout action', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0), storeVersion: '4.4.9'));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(UpdateRequiredScreenPage));
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_title), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_description), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_currentVersionLabel), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_minimumVersionLabel), findsOneWidget);
    // The internal app_version and the build version+code render as two
    // explicitly labeled values.
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_buildVersionLabel), findsOneWidget);
    expect(find.text('1.14.0'), findsOneWidget);
    expect(find.text('4.4.9+0'), findsOneWidget);
    expect(find.text('1.15.0'), findsOneWidget);
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout), findsOneWidget);
  });

  testWidgets('fits long build versions on one line without overflow', (tester) async {
    await tester.pumpWidget(
      host(
        current: Version.parse('1.16.0+6'),
        min: Version(99, 0, 0),
        storeVersion: '4.4.9',
        storeBuildNumber: '449000002',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1.16.0+6'), findsOneWidget);
    expect(find.text('4.4.9+449000002'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the literal 0.0.0 placeholder for builds without a store version', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0)));
    await tester.pumpAndSettle();

    expect(find.text('0.0.0+0'), findsOneWidget);
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
