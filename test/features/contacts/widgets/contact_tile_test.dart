import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/contacts/widgets/contact_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  Widget buildTestable(Widget child, {bool blfViaSipSupport = false}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PresenceViewParams(
        hybridPresenceSupport: false,
        blfViaSipSupport: blfViaSipSupport,
        presenceViaSipSupport: false,
        child: Scaffold(body: child),
      ),
    );
  }

  DialogInfo dialog(DialogState state) => DialogInfo(
    id: 'dlg-${state.name}',
    entityNumber: '1001',
    state: state,
    callId: 'call-1',
    direction: DialogDirection.initiator,
    localTag: 'lt',
    localNumber: '1001',
    localDisplayName: null,
    remoteTag: 'rt',
    remoteNumber: '1002',
    remoteDisplayName: 'Jane Roe',
    arrivalVersion: '1',
    arrivalTime: DateTime(2026, 8, 20),
  );

  ContactTile buildTile({
    VoidCallback? onTap,
    bool expanded = false,
    VoidCallback? onDialPressed,
    VoidCallback? onVideoCallPressed,
    VoidCallback? onChatPressed,
    VoidCallback? onCallLogPressed,
    VoidCallback? onViewContactPressed,
    String? copyNumber,
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
      copyNumber: copyNumber,
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
          buildTile(
            expanded: true,
            onVideoCallPressed: () {},
            onCallLogPressed: () {},
            onViewContactPressed: () {},
            // overflow action so the More affordance is rendered
            copyNumber: '1001',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
      expect(find.text('Message'), findsNothing);
    });

    testWidgets('expanded tile hides More when there are no overflow actions', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          buildTile(expanded: true, onVideoCallPressed: () {}, onCallLogPressed: () {}, onViewContactPressed: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(find.text('More'), findsNothing);
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

  group('ContactTile call state', () {
    testWidgets('a ringing call is not described as a conversation', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          ContactTile(displayName: 'John Doe', dialogInfo: [dialog(DialogState.early)]),
          blfViaSipSupport: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Jane Roe'), findsNothing);
    });

    testWidgets('an established call names who the contact is talking to', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          ContactTile(displayName: 'John Doe', dialogInfo: [dialog(DialogState.confirmed)]),
          blfViaSipSupport: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Jane Roe'), findsOneWidget);
    });

    testWidgets('a call that is still ringing next to an established one picks the established one', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          ContactTile(displayName: 'John Doe', dialogInfo: [dialog(DialogState.early), dialog(DialogState.confirmed)]),
          blfViaSipSupport: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Jane Roe'), findsOneWidget);
    });
  });
}
