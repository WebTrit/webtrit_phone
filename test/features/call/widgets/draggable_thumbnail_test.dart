import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  const windowSize = Size(90, 160);
  const screen = Size(400, 800);
  // Deliberately lopsided: with equal padding on every side an assertion cannot
  // tell the area the window may rest in from the screen itself.
  const stickyPadding = EdgeInsets.only(left: 8, top: 24, right: 32, bottom: 48);

  late List<Offset> moves;

  setUp(() => moves = []);

  /// The screen the window moves around has to be the real test surface, not
  /// a claim made through MediaQuery: a node that ends up outside the surface
  /// is dropped from the accessibility traversal, and the move looks like it
  /// did nothing.
  void useScreen(WidgetTester tester) {
    tester.view.physicalSize = screen;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  Widget buildSubject() {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Stack(
        children: [
          DraggableThumbnail(
            stickyPadding: stickyPadding,
            onOffsetUpdate: moves.add,
            // The real window carries a name; the moves are announced on that
            // same node, so a nameless stand-in would not be the thing under
            // test.
            child: ThumbnailFrame(
              orientation: Orientation.portrait,
              onTap: () {},
              label: 'Return to the call',
              identifier: 'thumbnail',
              child: SizedBox(width: windowSize.width, height: windowSize.height),
            ),
          ),
        ],
      ),
    );
  }

  /// The window as assistive technology sees it: the one node on the screen,
  /// read from the traversal rather than from the widget - a node found by
  /// widget carries none of what was merged into it.
  SemanticsNode window(WidgetTester tester) => tester.semantics.simulatedAccessibilityTraversal().first;

  int actionId(String label) => CustomSemanticsAction.getIdentifier(CustomSemanticsAction(label: label));

  Future<void> move(WidgetTester tester, String label) async {
    final node = window(tester);
    node.owner!.performAction(node.id, SemanticsAction.customAction, actionId(label));
    await tester.pumpAndSettle();
  }

  group('DraggableThumbnail - moving it without a finger', () {
    testWidgets('all six resting places are offered as actions', (tester) async {
      final semantics = tester.ensureSemantics();
      useScreen(tester);
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      final offered = window(tester).getSemanticsData().customSemanticsActionIds ?? [];
      for (final label in const [
        'Move to the top left',
        'Move to the top right',
        'Move to the middle left',
        'Move to the middle right',
        'Move to the bottom left',
        'Move to the bottom right',
      ]) {
        expect(offered, contains(actionId(label)), reason: '$label is not offered');
      }
      semantics.dispose();
    });

    testWidgets('each action puts the window there and says where it went', (tester) async {
      final semantics = tester.ensureSemantics();
      useScreen(tester);
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      await move(tester, 'Move to the bottom left');
      // The window rests inside the area it is allowed to rest in, so the
      // corner it lands on is that area's corner, not the screen's - which is
      // why the padding here is different on every side.
      expect(tester.getTopLeft(find.byType(ThumbnailFrame)), const Offset(8, 800 - 48 - 160));

      await move(tester, 'Move to the top right');
      expect(tester.getTopLeft(find.byType(ThumbnailFrame)), const Offset(400 - 32 - 90, 24));

      // Halfway down is the point of the two extra places: the corners are of
      // no help when what has to be uncovered sits in a corner itself. Halfway
      // is measured in that same area, not on the screen.
      await move(tester, 'Move to the middle left');
      expect(tester.getTopLeft(find.byType(ThumbnailFrame)), const Offset(8, (24 + (800 - 48)) / 2 - 80));

      // Whoever keeps the position is told about every move, not just drags.
      expect(moves.length, 3);
      semantics.dispose();
    });

    testWidgets('the window returns to the same edge when the screen changes', (tester) async {
      final semantics = tester.ensureSemantics();
      useScreen(tester);
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      // The right edge, on purpose: a window that simply kept its coordinates
      // would end up in the middle of a wider screen, so this is what proves
      // the edge itself is remembered.
      await move(tester, 'Move to the bottom right');
      expect(tester.getTopLeft(find.byType(ThumbnailFrame)).dx, 400 - 32 - 90);

      // Turn the phone: the window comes back to the edge it was put on,
      // measured against the new screen, and stays inside it.
      tester.view.physicalSize = const Size(800, 400);
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      final placed = tester.getRect(find.byType(ThumbnailFrame));
      expect(placed.right, 800 - 32, reason: 'the right edge is where it was put');
      expect(placed.bottom, lessThanOrEqualTo(400 - 48), reason: 'and it stays inside the new screen');
      semantics.dispose();
    });

    testWidgets('a window that cannot be pressed offers nothing at all', (tester) async {
      final semantics = tester.ensureSemantics();
      useScreen(tester);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Stack(
            children: [
              DraggableThumbnail(
                stickyPadding: stickyPadding,
                // The self-view is like this while the camera state is still
                // unknown: nothing to press, so nothing to say - and the moves
                // must not turn it into a nameless stop with six actions.
                child: ThumbnailFrame(
                  orientation: Orientation.portrait,
                  onTap: null,
                  label: 'Switch camera',
                  identifier: 'preview',
                  child: SizedBox(width: windowSize.width, height: windowSize.height),
                ),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.semantics.simulatedAccessibilityTraversal(), isEmpty);
      semantics.dispose();
    });
  });
}
