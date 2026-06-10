import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/widgets/contact_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  Widget buildTestable(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PresenceViewParams(
        hybridPresenceSupport: false,
        blfViaSipSupport: false,
        presenceViaSipSupport: false,
        child: Scaffold(body: child),
      ),
    );
  }

  ContactTile buildTile({
    VoidCallback? onTap,
    bool expanded = false,
    VoidCallback? onDialPressed,
    VoidCallback? onVideoCallPressed,
    VoidCallback? onChatPressed,
    VoidCallback? onCallLogPressed,
    VoidCallback? onViewContactPressed,
  }) {
    return ContactTile(
      displayName: 'John Doe',
      onTap: onTap,
      expanded: expanded,
      onDialPressed: onDialPressed,
      onVideoCallPressed: onVideoCallPressed,
      onChatPressed: onChatPressed,
      onCallLogPressed: onCallLogPressed,
      onViewContactPressed: onViewContactPressed,
    );
  }

  group('ContactTile expansion', () {
    testWidgets('collapsed tile does not show the actions bar', (tester) async {
      await tester.pumpWidget(buildTestable(buildTile(onVideoCallPressed: () {}, onCallLogPressed: () {})));
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsNothing);
      expect(find.text('History'), findsNothing);
      expect(find.text('More'), findsNothing);
    });

    testWidgets('expanded tile shows actions for non-null callbacks', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          buildTile(expanded: true, onVideoCallPressed: () {}, onCallLogPressed: () {}, onViewContactPressed: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
      expect(find.text('Message'), findsNothing);
    });

    testWidgets('row tap calls onTap and not onDialPressed', (tester) async {
      var tapped = false;
      var dialed = false;
      await tester.pumpWidget(buildTestable(buildTile(onTap: () => tapped = true, onDialPressed: () => dialed = true)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('John Doe'));
      expect(tapped, isTrue);
      expect(dialed, isFalse);
    });

    testWidgets('dial button calls onDialPressed', (tester) async {
      var dialed = false;
      await tester.pumpWidget(buildTestable(buildTile(onDialPressed: () => dialed = true)));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.call));
      expect(dialed, isTrue);
    });

    testWidgets('expanded action buttons fire their callbacks', (tester) async {
      var contactOpened = false;
      await tester.pumpWidget(
        buildTestable(buildTile(expanded: true, onViewContactPressed: () => contactOpened = true)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Contact'));
      expect(contactOpened, isTrue);
    });
  });
}
