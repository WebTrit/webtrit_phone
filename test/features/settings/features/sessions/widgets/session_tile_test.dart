import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart';
import 'package:webtrit_api/webtrit_api.dart' show AppType;

import 'package:webtrit_phone/features/settings/features/sessions/widgets/session_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  Widget wrap(ActiveSession session, {bool revoking = false, ValueChanged<ActiveSession>? onRevoke}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SessionTile(session: session, dateFormat: dateFormat, revoking: revoking, onRevoke: onRevoke ?? (_) {}),
      ),
    );
  }

  testWidgets('names the session after the app type it was created from', (tester) async {
    await tester.pumpWidget(wrap(const ActiveSession(id: 'a', current: false, appType: AppType.ios)));

    expect(find.text('iOS app'), findsOneWidget);
  });

  testWidgets('falls back to an unknown device when the app type is missing', (tester) async {
    await tester.pumpWidget(wrap(const ActiveSession(id: 'a', current: false)));

    expect(find.text('Unknown device'), findsOneWidget);
  });

  testWidgets('marks the current session and offers no revoke action for it', (tester) async {
    await tester.pumpWidget(wrap(const ActiveSession(id: 'a', current: true, appType: AppType.android)));

    expect(find.text('This device'), findsOneWidget);
    expect(find.text('Sign out'), findsNothing);
  });

  testWidgets('reports the session to revoke when its action is tapped', (tester) async {
    const session = ActiveSession(id: 'a', current: false, appType: AppType.android);
    final revoked = <ActiveSession>[];
    await tester.pumpWidget(wrap(session, onRevoke: revoked.add));

    await tester.tap(find.text('Sign out'));

    expect(revoked, equals([session]));
  });

  testWidgets('shows progress instead of the action while the session is being revoked', (tester) async {
    await tester.pumpWidget(
      wrap(const ActiveSession(id: 'a', current: false, appType: AppType.android), revoking: true),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<TextButton>(find.byType(TextButton)).onPressed, isNull);
  });

  testWidgets('shows when the session was last used and created', (tester) async {
    await tester.pumpWidget(
      wrap(
        ActiveSession(
          id: 'a',
          current: false,
          appType: AppType.ios,
          createdAt: DateTime(2026, 8, 1, 10),
          lastActivityAt: DateTime(2026, 8, 12, 18, 30),
        ),
      ),
    );

    expect(find.text('Last used 2026-08-12 18:30'), findsOneWidget);
    expect(find.text('Signed in 2026-08-01 10:00'), findsOneWidget);
  });
}
