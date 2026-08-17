import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  const width = 100.0;
  const short = 'fits';
  const long = 'a caption far too long to ever fit into this narrow row';
  const pause = Duration(seconds: 2);

  // Long enough for a full travel at any sane speed, so the passes are waited
  // out with one number instead of a guess per step.
  const settled = Duration(minutes: 2);

  Future<void> pumpMarquee(WidgetTester tester, String caption, {bool disableAnimations = false}) {
    return tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: disableAnimations),
          child: Material(
            child: Center(
              child: SizedBox(
                width: width,
                child: OverflowMarquee(
                  child: Text(
                    caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Where the caption sits relative to the window it is shown through: 0 while
  // it rests at its start, negative once it has travelled to reveal its tail.
  double captionOffset(WidgetTester tester) =>
      tester.getTopLeft(find.byType(Text)).dx - tester.getTopLeft(find.byType(OverflowMarquee)).dx;

  group('OverflowMarquee', () {
    testWidgets('a caption that fits never moves', (tester) async {
      await pumpMarquee(tester, short);

      expect(tester.getSize(find.byType(Text)).width, lessThan(width), reason: 'the caption must fit, or it travels');
      expect(captionOffset(tester), 0);

      await tester.pump(pause);
      await tester.pump(settled);

      expect(captionOffset(tester), 0);
    });

    testWidgets('a caption that does not fit travels until its end shows, then comes back', (tester) async {
      await pumpMarquee(tester, long);

      final overflow = tester.getSize(find.byType(Text)).width - width;
      expect(overflow, greaterThan(0), reason: 'the caption must not fit, or there is nothing to reveal');

      // It waits before setting off, so the reader can start on the beginning.
      await tester.pump(pause - const Duration(milliseconds: 500));
      expect(captionOffset(tester), 0);

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 100));
      expect(captionOffset(tester), lessThan(0), reason: 'the caption should have set off after the pause');

      await tester.pump(settled);
      expect(captionOffset(tester), closeTo(-overflow, 0.5), reason: 'the far end of the caption should be shown');

      await tester.pump(pause);
      await tester.pump(settled);
      expect(captionOffset(tester), 0, reason: 'the caption should return to its beginning');
    });

    testWidgets('a caption that does not fit is read in full and claims no more room than it has', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpMarquee(tester, long);

      // Clipping the caption must not clip what a screen reader gets, at rest
      // or half way through a pass.
      expect(find.bySemanticsLabel(long), findsOneWidget);
      await tester.pump(pause);
      await tester.pump(const Duration(seconds: 5));
      expect(find.bySemanticsLabel(long), findsOneWidget);

      // The caption is laid out at its full width, and a node that wide would
      // promise a target reaching far past the row it belongs to.
      expect(tester.getSemantics(find.byType(Text)).rect.width, lessThanOrEqualTo(width));

      handle.dispose();
    });

    testWidgets('with animations off it stays put and keeps its own overflow treatment', (tester) async {
      await pumpMarquee(tester, long, disableAnimations: true);

      expect(find.byType(ClipRect), findsNothing);
      expect(
        tester.getSize(find.byType(Text)).width,
        closeTo(width, 0.01),
        reason: 'the caption should be held to the row and ellipsized, not laid out at full width',
      );

      await tester.pump(pause);
      await tester.pump(settled);

      expect(captionOffset(tester), 0);
    });
  });
}
