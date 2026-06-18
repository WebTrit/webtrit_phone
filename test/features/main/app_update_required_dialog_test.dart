import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/features/main/main.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

void main() {
  Widget host({required Version current, required Version min, VoidCallback? onUpdate, VoidCallback? onLogout}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => AppUpdateRequiredDialog.show(
                  context,
                  current,
                  min,
                  onUpdatePressed: onUpdate,
                  onLogoutPressed: onLogout,
                ),
                child: const Text('open'),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> open(WidgetTester tester) async {
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('renders title, description, both versions and both actions', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0), onUpdate: () {}, onLogout: () {}));
    await open(tester);

    final context = tester.element(find.byType(AppUpdateRequiredDialog));
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_title), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_description), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_currentVersionLabel), findsOneWidget);
    expect(find.text(context.l10n.main_AppUpdateRequiredDialog_minimumVersionLabel), findsOneWidget);
    expect(find.text('1.14.0'), findsOneWidget);
    expect(find.text('1.15.0'), findsOneWidget);
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_update), findsOneWidget);
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout), findsOneWidget);
  });

  testWidgets('hides the Update action when no update callback is provided', (tester) async {
    await tester.pumpWidget(host(current: Version(1, 14, 0), min: Version(1, 15, 0), onLogout: () {}));
    await open(tester);

    final context = tester.element(find.byType(AppUpdateRequiredDialog));
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_update), findsNothing);
    expect(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout), findsOneWidget);
  });

  testWidgets('invokes the update and logout callbacks on tap', (tester) async {
    var updated = 0;
    var loggedOut = 0;
    await tester.pumpWidget(
      host(current: Version(1, 14, 0), min: Version(1, 15, 0), onUpdate: () => updated++, onLogout: () => loggedOut++),
    );
    await open(tester);

    final context = tester.element(find.byType(AppUpdateRequiredDialog));
    await tester.tap(find.text(context.l10n.main_CompatibilityIssueDialogActions_update));
    await tester.pump();
    expect(updated, 1);

    await tester.tap(find.text(context.l10n.main_CompatibilityIssueDialogActions_logout));
    await tester.pump();
    expect(loggedOut, 1);
  });
}
