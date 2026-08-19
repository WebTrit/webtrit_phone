import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/widgets/account_actions_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  late int logoutTaps;
  late int sessionsTaps;

  setUp(() {
    logoutTaps = 0;
    sessionsTaps = 0;
  });

  Widget buildTestable({required int? sessionsCount}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: AccountActionsTile(
          sessionsCount: sessionsCount,
          showSeparator: false,
          onLogoutTap: () => logoutTaps++,
          onSessionsTap: () => sessionsTaps++,
        ),
      ),
    );
  }

  testWidgets('offers logout and sessions side by side', (tester) async {
    await tester.pumpWidget(buildTestable(sessionsCount: 2));

    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Sessions'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('logs out when its half is tapped', (tester) async {
    await tester.pumpWidget(buildTestable(sessionsCount: 2));

    await tester.tap(find.byKey(settingsLogoutButtonKey));

    expect(logoutTaps, 1);
    expect(sessionsTaps, 0);
  });

  testWidgets('opens the sessions screen when its half is tapped', (tester) async {
    await tester.pumpWidget(buildTestable(sessionsCount: 2));

    await tester.tap(find.text('Sessions'));

    expect(sessionsTaps, 1);
    expect(logoutTaps, 0);
  });

  testWidgets('shows no count until the sessions are known', (tester) async {
    await tester.pumpWidget(buildTestable(sessionsCount: 0));

    expect(find.text('Sessions'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('says how many sessions there are, after naming the row', (tester) async {
    // The row merges into one node, so the badge digit used to be read out
    // inside its name ("Sessions, 2"). It travels as the row's state instead.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(sessionsCount: 2));

    final data = tester.getSemantics(find.bySemanticsLabel('Sessions')).getSemanticsData();
    expect(data.label, 'Sessions');
    expect(data.value, '2 total');

    handle.dispose();
  });

  testWidgets('keeps logout alone when sessions are unavailable', (tester) async {
    await tester.pumpWidget(buildTestable(sessionsCount: null));

    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Sessions'), findsNothing);

    await tester.tap(find.byKey(settingsLogoutButtonKey));
    expect(logoutTaps, 1);
  });
}
