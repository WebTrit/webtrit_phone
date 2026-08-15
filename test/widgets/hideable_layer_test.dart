import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Future<void> pumpLayer(WidgetTester tester, {required bool hidden, required VoidCallback onPressed}) {
    return tester.pumpWidget(
      MaterialApp(
        home: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: Colors.black)),
            HideableLayer(
              hidden: hidden,
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(onPressed: onPressed, child: const Text('Hang up')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  group('HideableLayer', () {
    testWidgets('while shown, its content is visible, pressable and inset', (tester) async {
      var presses = 0;
      await pumpLayer(tester, hidden: false, onPressed: () => presses++);

      expect(tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity, 1);
      expect(tester.getTopLeft(find.byType(ElevatedButton)).dy, 24);

      await tester.tap(find.text('Hang up'));
      expect(presses, 1);
    });

    testWidgets('while hidden, it is invisible and takes no taps', (tester) async {
      var presses = 0;
      await pumpLayer(tester, hidden: true, onPressed: () => presses++);
      await tester.pump(kThemeAnimationDuration);

      expect(tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity)).opacity, 0);

      await tester.tap(find.text('Hang up'), warnIfMissed: false);
      expect(presses, 0, reason: 'an invisible layer that still answered taps would be a trap');
    });

    testWidgets('hiding it takes the content out of the accessibility tree', (tester) async {
      final semantics = tester.ensureSemantics();
      await pumpLayer(tester, hidden: false, onPressed: () {});
      expect(find.bySemanticsLabel('Hang up'), findsOneWidget);

      await pumpLayer(tester, hidden: true, onPressed: () {});
      // It fades out, and leaves the tree only once nothing of it is left.
      await tester.pump(kThemeAnimationDuration);
      expect(
        tester.semantics.simulatedAccessibilityTraversal().map((node) => node.getSemanticsData().label),
        isNot(contains('Hang up')),
      );
      semantics.dispose();
    });

    testWidgets('the content stays in the widget tree either way', (tester) async {
      await pumpLayer(tester, hidden: true, onPressed: () {});

      expect(find.text('Hang up'), findsOneWidget);
    });
  });
}
