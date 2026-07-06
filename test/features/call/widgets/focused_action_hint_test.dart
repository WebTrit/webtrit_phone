import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

Widget _buildSubject({
  required String focusedName,
  List<String> willBeHeldNames = const [],
  List<String> willBeEndedNames = const [],
}) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: FocusedActionHint(
        focusedName: focusedName,
        willBeHeldNames: willBeHeldNames,
        willBeEndedNames: willBeEndedNames,
      ),
    ),
  );
}

void main() {
  group('FocusedActionHint', () {
    testWidgets('names the focused call', (tester) async {
      await tester.pumpWidget(_buildSubject(focusedName: 'Boris Klein'));
      final context = tester.element(find.byType(FocusedActionHint));

      expect(
        find.text(context.l10n.call_FocusedActionHint_actingOn('Boris Klein'), findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('spells out the will-be-held side effect', (tester) async {
      await tester.pumpWidget(_buildSubject(focusedName: 'Boris Klein', willBeHeldNames: const ['Anna Marchenko']));
      final context = tester.element(find.byType(FocusedActionHint));

      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Anna Marchenko'), findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('spells out the will-be-ended side effect when nothing can be held', (tester) async {
      await tester.pumpWidget(_buildSubject(focusedName: 'Boris Klein', willBeEndedNames: const ['Anna Marchenko']));
      final context = tester.element(find.byType(FocusedActionHint));

      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeEnded('Anna Marchenko'), findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('hold side effect wins over ended when both are passed', (tester) async {
      await tester.pumpWidget(
        _buildSubject(
          focusedName: 'Boris Klein',
          willBeHeldNames: const ['Anna Marchenko'],
          willBeEndedNames: const ['Clara Diaz'],
        ),
      );
      final context = tester.element(find.byType(FocusedActionHint));

      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Anna Marchenko'), findRichText: true),
        findsOneWidget,
      );
      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeEnded('Clara Diaz'), findRichText: true),
        findsNothing,
      );
    });

    testWidgets('joins multiple affected names', (tester) async {
      await tester.pumpWidget(
        _buildSubject(focusedName: 'Boris Klein', willBeHeldNames: const ['Anna Marchenko', 'Clara Diaz']),
      );
      final context = tester.element(find.byType(FocusedActionHint));

      expect(
        find.text(context.l10n.call_FocusedActionHint_willBeHeld('Anna Marchenko, Clara Diaz'), findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('shows no side-effect line without affected calls', (tester) async {
      await tester.pumpWidget(_buildSubject(focusedName: 'Boris Klein'));
      // Only the acting-on line is present.
      expect(find.byType(Text), findsOneWidget);
    });
  });

  group('IncomingCallActions', () {
    Widget buildActions({VoidCallback? onAccept, VoidCallback? onHangup}) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: IncomingCallActions(
            remoteVideo: false,
            inviteToAttendedTransfer: false,
            onHangupPressed: onHangup,
            onAcceptPressed: onAccept,
          ),
        ),
      );
    }

    testWidgets('renders only Decline and Answer - no combined-icon buttons', (tester) async {
      await tester.pumpWidget(buildActions(onAccept: () {}, onHangup: () {}));

      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.byIcon(Icons.call_end), findsOneWidget);
      expect(find.byIcon(Icons.call), findsOneWidget);
      // The combined "Hold & Answer" pause glyph is gone for good.
      expect(find.byIcon(Icons.pause), findsNothing);
    });

    testWidgets('buttons invoke their callbacks', (tester) async {
      var accepted = 0;
      var declined = 0;
      await tester.pumpWidget(buildActions(onAccept: () => accepted++, onHangup: () => declined++));

      await tester.tap(find.byIcon(Icons.call));
      await tester.tap(find.byIcon(Icons.call_end));
      expect(accepted, 1);
      expect(declined, 1);
    });
  });
}
