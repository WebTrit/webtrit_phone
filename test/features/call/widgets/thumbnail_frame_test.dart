import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );

  group('ThumbnailFrame', () {
    testWidgets('stands upright in portrait and lies down in landscape', (tester) async {
      await tester.pumpWidget(
        wrap(const ThumbnailFrame(orientation: Orientation.portrait, onTap: null, child: SizedBox.shrink())),
      );
      final portrait = tester.getSize(find.byType(ThumbnailFrame));
      expect(portrait.height, greaterThan(portrait.width));

      await tester.pumpWidget(
        wrap(const ThumbnailFrame(orientation: Orientation.landscape, onTap: null, child: SizedBox.shrink())),
      );
      final landscape = tester.getSize(find.byType(ThumbnailFrame));
      expect(landscape.width, greaterThan(landscape.height));
      expect(landscape.width, portrait.height);
    });

    testWidgets('the whole frame answers a tap, corners included', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrap(ThumbnailFrame(orientation: Orientation.portrait, onTap: () => taps++, child: const SizedBox.shrink())),
      );

      await tester.tap(find.byType(ThumbnailFrame));
      // The rounded clip cuts the corners visually; pressing one still counts,
      // which is why the tap sits outside the clip.
      await tester.tapAt(tester.getTopLeft(find.byType(ThumbnailFrame)) + const Offset(2, 2));
      expect(taps, 2);
    });

    testWidgets('without a callback it is inert', (tester) async {
      await tester.pumpWidget(
        wrap(const ThumbnailFrame(orientation: Orientation.portrait, onTap: null, child: SizedBox.shrink())),
      );

      await tester.tap(find.byType(ThumbnailFrame));
      expect(tester.takeException(), isNull);
      // The plain frame carries no surface of its own; only the raised one does.
      expect(find.descendant(of: find.byType(ThumbnailFrame), matching: find.byType(Card)), findsNothing);
    });

    testWidgets('the raised one sits on a surface of its own', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ThumbnailFrame(orientation: Orientation.portrait, onTap: null, raised: true, child: SizedBox.shrink()),
        ),
      );

      expect(find.descendant(of: find.byType(ThumbnailFrame), matching: find.byType(Card)), findsOneWidget);
    });
  });
}
