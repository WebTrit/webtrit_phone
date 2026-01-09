import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';

void main() {
  const kStickyPadding = EdgeInsets.all(10);
  const kThumbnailSize = Size(100, 100);

  Widget buildTestableWidget({
    required Widget child,
    StickySide initialStickySide = StickySide.right,
    Offset? initialOffset,
    EdgeInsets stickyPadding = kStickyPadding,
    VoidCallback? onTap,
    ValueChanged<Offset>? onOffsetUpdate,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            DraggableThumbnail(
              stickyPadding: stickyPadding,
              initialStickySide: initialStickySide,
              initialOffset: initialOffset,
              onTap: onTap,
              onOffsetUpdate: onOffsetUpdate,
              child: SizedBox.fromSize(size: kThumbnailSize, child: child),
            ),
          ],
        ),
      ),
    );
  }

  /// Retrieves the actual geometry (Size and Padding) from the running context.
  ({Size size, EdgeInsets padding}) getDeviceGeometry(WidgetTester tester) {
    final context = tester.element(find.byType(DraggableThumbnail));
    final mq = MediaQuery.of(context);
    return (size: mq.size, padding: mq.padding);
  }

  group('DraggableThumbnail', () {
    testWidgets('renders initially at the correct Right side position', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          initialStickySide: StickySide.right,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);
      final position = tester.getTopLeft(finder);

      // Dynamic Expectation: Screen Width - Sticky Padding - Safe Area - Widget Width
      final expectedX = geometry.size.width - kStickyPadding.right - geometry.padding.right - kThumbnailSize.width;
      // Dynamic Expectation: Sticky Padding + Safe Area Top
      final expectedY = kStickyPadding.top + geometry.padding.top;

      expect(position.dx, closeTo(expectedX, 0.1));
      expect(position.dy, closeTo(expectedY, 0.1));
    });

    testWidgets('renders initially at the correct Left side position', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          initialStickySide: StickySide.left,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);
      final position = tester.getTopLeft(finder);

      // Dynamic Expectation: Sticky Padding + Safe Area Left
      final expectedX = kStickyPadding.left + geometry.padding.left;

      expect(position.dx, closeTo(expectedX, 0.1));
    });

    testWidgets('snaps to the Left side when dragged past the center to the left', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          initialStickySide: StickySide.right,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);

      // Drag across the entire width to ensure we cross the center
      await tester.drag(finder, Offset(-geometry.size.width, 0));
      await tester.pumpAndSettle();

      final position = tester.getTopLeft(finder);
      final expectedX = kStickyPadding.left + geometry.padding.left;

      expect(position.dx, closeTo(expectedX, 0.1));
    });

    testWidgets('snaps back to the Right side when dragged slightly but not past center', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          initialStickySide: StickySide.right,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);

      // Drag slightly left (e.g., 10% of screen width)
      await tester.drag(finder, Offset(-geometry.size.width * 0.1, 0));
      await tester.pumpAndSettle();

      final position = tester.getTopLeft(finder);
      final expectedX = geometry.size.width - kStickyPadding.right - geometry.padding.right - kThumbnailSize.width;

      expect(position.dx, closeTo(expectedX, 0.1));
    });

    testWidgets('respects vertical boundaries (cannot be dragged off top)', (tester) async {
      await tester.pumpWidget(buildTestableWidget(child: Container(color: Colors.red)));
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);

      // Drag up off the screen
      await tester.drag(finder, const Offset(0, -1000));
      await tester.pumpAndSettle();

      final position = tester.getTopLeft(finder);
      final expectedY = kStickyPadding.top + geometry.padding.top;

      expect(position.dy, closeTo(expectedY, 0.1));
    });

    testWidgets('respects vertical boundaries (cannot be dragged off bottom)', (tester) async {
      await tester.pumpWidget(buildTestableWidget(child: Container(color: Colors.red)));
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);

      // Drag down off the screen
      await tester.drag(finder, const Offset(0, 2000));
      await tester.pumpAndSettle();

      final position = tester.getTopLeft(finder);

      // Expected Y: Screen Height - Sticky Padding - Safe Area Bottom - Widget Height
      final expectedY = geometry.size.height - kStickyPadding.bottom - geometry.padding.bottom - kThumbnailSize.height;

      expect(position.dy, closeTo(expectedY, 0.1));
    });

    testWidgets('triggers onTap callback when tapped', (tester) async {
      bool isTapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          onTap: () => isTapped = true,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DraggableThumbnail));
      expect(isTapped, isTrue);
    });

    testWidgets('triggers onOffsetUpdate with correct final position', (tester) async {
      Offset? lastOffset;

      await tester.pumpWidget(
        buildTestableWidget(
          initialStickySide: StickySide.right,
          onOffsetUpdate: (offset) => lastOffset = offset,
          child: Container(color: Colors.red),
        ),
      );
      await tester.pumpAndSettle();

      final geometry = getDeviceGeometry(tester);
      final finder = find.byType(DraggableThumbnail);

      // Drag to the left side and down
      await tester.drag(finder, Offset(-geometry.size.width, 100));
      await tester.pumpAndSettle();

      final expectedX = kStickyPadding.left + geometry.padding.left;

      expect(lastOffset, isNotNull);
      expect(lastOffset!.dx, closeTo(expectedX, 0.1));
      expect(lastOffset!.dy, greaterThan(kStickyPadding.top + geometry.padding.top));
    });

    testWidgets('respects initialOffset if provided', (tester) async {
      const customOffset = Offset(100, 200);

      await tester.pumpWidget(
        buildTestableWidget(
          initialOffset: customOffset,
          child: Container(color: Colors.red),
        ),
      );
      // Pump twice to allow initState and postFrameCallback logic to run
      await tester.pump();
      await tester.pumpAndSettle();

      final finder = find.byType(DraggableThumbnail);
      final position = tester.getTopLeft(finder);

      expect(position, equals(customOffset));
    });
  });
}
