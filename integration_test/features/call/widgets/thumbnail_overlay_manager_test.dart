import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/widgets/widgets.dart';

void main() {
  Widget buildTestableWidget({required WidgetBuilder onBuild}) {
    return MaterialApp(
      home: Scaffold(body: Builder(builder: onBuild)),
    );
  }

  group('ThumbnailOverlayManager', () {
    // Make manager nullable to safely handle manual disposal in tests
    ThumbnailOverlayManager? manager;

    setUp(() {
      manager = ThumbnailOverlayManager(stickyPadding: const EdgeInsets.all(10));
    });

    tearDown(() {
      // Only dispose if the test hasn't already done so (manager is not null)
      manager?.dispose();
    });

    testWidgets('shows overlay when show() is called', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          onBuild: (context) {
            return TextButton(
              onPressed: () => manager!.show(context, child: const Text('Overlay Content')),
              child: const Text('Show'),
            );
          },
        ),
      );

      expect(manager!.isShowing, isFalse);
      expect(find.text('Overlay Content'), findsNothing);

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(manager!.isShowing, isTrue);
      expect(find.text('Overlay Content'), findsOneWidget);
    });

    testWidgets('hides overlay when hide() is called', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          onBuild: (context) {
            return Column(
              children: [
                TextButton(
                  onPressed: () => manager!.show(context, child: const Text('Overlay Content')),
                  child: const Text('Show'),
                ),
                TextButton(onPressed: () => manager!.hide(), child: const Text('Hide')),
              ],
            );
          },
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();
      expect(find.text('Overlay Content'), findsOneWidget);

      await tester.tap(find.text('Hide'));
      await tester.pumpAndSettle();

      expect(manager!.isShowing, isFalse);
      expect(find.text('Overlay Content'), findsNothing);
    });

    testWidgets('updates content without re-inserting overlay (prevents flicker)', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          onBuild: (context) {
            return Column(
              children: [
                TextButton(
                  onPressed: () => manager!.show(context, child: const Text('Content A')),
                  child: const Text('Show A'),
                ),
                TextButton(
                  onPressed: () => manager!.show(context, child: const Text('Content B')),
                  child: const Text('Show B'),
                ),
              ],
            );
          },
        ),
      );

      await tester.tap(find.text('Show A'));
      await tester.pumpAndSettle();
      expect(find.text('Content A'), findsOneWidget);

      await tester.tap(find.text('Show B'));
      await tester.pump();

      expect(find.text('Content B'), findsOneWidget);
      expect(find.text('Content A'), findsNothing);
      expect(manager!.isShowing, isTrue);
    });

    testWidgets('preserves dragged position across hide/show sessions', (tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildTestableWidget(
          onBuild: (context) {
            return Column(
              children: [
                TextButton(
                  onPressed: () => manager!.show(context, child: Container(width: 50, height: 50, color: Colors.red)),
                  child: const Text('Show'),
                ),
                TextButton(onPressed: () => manager!.hide(), child: const Text('Hide')),
              ],
            );
          },
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final finder = find.byType(DraggableThumbnail);

      await tester.drag(finder, const Offset(-800, 0));
      await tester.pumpAndSettle();

      final draggedPos = tester.getTopLeft(finder);
      expect(draggedPos.dx, equals(10.0));

      await tester.tap(find.text('Hide'));
      await tester.pumpAndSettle();
      expect(find.byType(DraggableThumbnail), findsNothing);

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      final restoredPos = tester.getTopLeft(find.byType(DraggableThumbnail));
      expect(restoredPos.dx, equals(10.0));
    });

    testWidgets('dispose clears resources and hides overlay', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          onBuild: (context) {
            return TextButton(
              onPressed: () => manager!.show(context, child: const Text('Active')),
              child: const Text('Show'),
            );
          },
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();
      expect(manager!.isShowing, isTrue);

      // Manually call dispose
      manager!.dispose();
      // Set to null to prevent tearDown from calling dispose again
      manager = null;

      await tester.pumpAndSettle();

      // Since manager is null, we can't check isShowing, but we verify the overlay UI is gone
      expect(find.text('Active'), findsNothing);
    });
  });
}
