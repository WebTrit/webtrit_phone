import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/favorites/widgets/favorite_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/utils/utils.dart';

void main() {
  const favorite = Favorite(
    number: '1001',
    sourceType: FavoriteSourceType.pbx,
    sourceId: '1',
    label: 'work',
    position: 0,
  );

  Widget buildTestable(Widget child) {
    return MaterialApp(
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

  FavoriteTile buildTile({
    VoidCallback? onTap,
    bool expanded = false,
    bool gesturesEnabled = true,
    VoidCallback? onDialPressed,
    VoidCallback? onVideoCallPressed,
    VoidCallback? onChatPressed,
    VoidCallback? onCallLogPressed,
    VoidCallback? onViewContactPressed,
  }) {
    return FavoriteTile(
      favorite: favorite,
      callNumbers: const [],
      onTap: onTap,
      expanded: expanded,
      gesturesEnabled: gesturesEnabled,
      onDialPressed: onDialPressed,
      onVideoCallPressed: onVideoCallPressed,
      onChatPressed: onChatPressed,
      onCallLogPressed: onCallLogPressed,
      onViewContactPressed: onViewContactPressed,
    );
  }

  group('FavoriteTile expansion', () {
    testWidgets('collapsed tile does not show the actions bar', (tester) async {
      await tester.pumpWidget(buildTestable(buildTile(onVideoCallPressed: () {}, onCallLogPressed: () {})));
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsNothing);
      expect(find.text('History'), findsNothing);
      expect(find.text('More'), findsNothing);
    });

    testWidgets('expanded tile shows actions for non-null callbacks', (tester) async {
      await tester.pumpWidget(
        buildTestable(buildTile(expanded: true, onVideoCallPressed: () {}, onCallLogPressed: () {})),
      );
      await tester.pumpAndSettle();

      expect(find.text('Video call'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
      expect(find.text('Message'), findsNothing);
      expect(find.text('Contact'), findsNothing);
    });

    testWidgets('row tap calls onTap and not onDialPressed', (tester) async {
      var tapped = false;
      var dialed = false;
      await tester.pumpWidget(buildTestable(buildTile(onTap: () => tapped = true, onDialPressed: () => dialed = true)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Work: 1001'));
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

    testWidgets('reorder mode hides dial button and actions bar', (tester) async {
      await tester.pumpWidget(
        buildTestable(buildTile(expanded: true, gesturesEnabled: false, onDialPressed: () {}, onCallLogPressed: () {})),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.call), findsNothing);
      expect(find.text('History'), findsNothing);
    });

    testWidgets('expanded action buttons fire their callbacks', (tester) async {
      var history = false;
      await tester.pumpWidget(buildTestable(buildTile(expanded: true, onCallLogPressed: () => history = true)));
      await tester.pumpAndSettle();

      await tester.tap(find.text('History'));
      expect(history, isTrue);
    });
  });
}
