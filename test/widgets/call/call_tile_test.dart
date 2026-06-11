import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/widgets/call/call_tile.dart';

void main() {
  Widget buildTestable(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  CallTile buildTile({
    VoidCallback? onTap,
    bool expanded = false,
    bool gesturesEnabled = true,
    VoidCallback? onDialPressed,
    IconData? dialIcon,
    VoidCallback? onAudioCallPressed,
    VoidCallback? onVideoCallPressed,
    VoidCallback? onChatPressed,
    VoidCallback? onCallLogPressed,
    VoidCallback? onViewContactPressed,
  }) {
    return CallTile(
      leading: const CircleAvatar(),
      name: 'John Doe',
      subName: '1001',
      timeLabel: '12:00',
      callNumbers: const [],
      copyNumber: '1001',
      onTap: onTap,
      expanded: expanded,
      gesturesEnabled: gesturesEnabled,
      onDialPressed: onDialPressed,
      dialIcon: dialIcon,
      onAudioCallPressed: onAudioCallPressed,
      onVideoCallPressed: onVideoCallPressed,
      onChatPressed: onChatPressed,
      onCallLogPressed: onCallLogPressed,
      onViewContactPressed: onViewContactPressed,
    );
  }

  group('CallTile expansion', () {
    testWidgets('collapsed tile does not show the actions bar', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          buildTile(
            onVideoCallPressed: () {},
            onChatPressed: () {},
            onCallLogPressed: () {},
            onViewContactPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsNothing);
      expect(find.text('Message'), findsNothing);
      expect(find.text('History'), findsNothing);
      expect(find.text('Contact'), findsNothing);
      expect(find.text('More'), findsNothing);
    });

    testWidgets('expanded tile shows actions for non-null callbacks', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          buildTile(
            expanded: true,
            onVideoCallPressed: () {},
            onChatPressed: () {},
            onCallLogPressed: () {},
            onViewContactPressed: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsOneWidget);
      expect(find.text('Message'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('expanded tile hides actions whose callbacks are null', (tester) async {
      await tester.pumpWidget(buildTestable(buildTile(expanded: true, onCallLogPressed: () {})));
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsNothing);
      expect(find.text('Message'), findsNothing);
      expect(find.text('Contact'), findsNothing);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
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

    testWidgets('dial button shows custom dialIcon when provided', (tester) async {
      var dialed = false;
      await tester.pumpWidget(buildTestable(buildTile(onDialPressed: () => dialed = true, dialIcon: Icons.videocam)));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.call), findsNothing);
      await tester.tap(find.byIcon(Icons.videocam));
      expect(dialed, isTrue);
    });

    testWidgets('without onDialPressed falls back to the menu button', (tester) async {
      await tester.pumpWidget(buildTestable(buildTile()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.call), findsNothing);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('expanded action buttons fire their callbacks', (tester) async {
      var video = false;
      var history = false;
      await tester.pumpWidget(
        buildTestable(
          buildTile(expanded: true, onVideoCallPressed: () => video = true, onCallLogPressed: () => history = true),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Video call'));
      await tester.tap(find.text('History'));
      expect(video, isTrue);
      expect(history, isTrue);
    });

    testWidgets('disabled gestures hide dial button and actions bar', (tester) async {
      await tester.pumpWidget(
        buildTestable(buildTile(expanded: true, gesturesEnabled: false, onDialPressed: () {}, onCallLogPressed: () {})),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.call), findsNothing);
      expect(find.byIcon(Icons.more_vert), findsNothing);
      expect(find.text('History'), findsNothing);
    });

    testWidgets('without any menu actions hides the menu button and More', (tester) async {
      await tester.pumpWidget(
        buildTestable(
          const CallTile(
            leading: CircleAvatar(),
            name: 'John Doe',
            timeLabel: '12:00',
            callNumbers: [],
            expanded: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.more_vert), findsNothing);
      expect(find.text('More'), findsNothing);
    });

    testWidgets('More opens the full actions menu', (tester) async {
      await tester.pumpWidget(buildTestable(buildTile(expanded: true, onAudioCallPressed: () {})));
      await tester.pumpAndSettle();

      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      expect(find.text('Audio call'), findsNWidgets(2));
    });
  });
}
