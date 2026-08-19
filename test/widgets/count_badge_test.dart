import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  testWidgets('the badge draws its number and says nothing', (tester) async {
    // Everywhere it is drawn the badge sits inside a node someone else names,
    // and a raw digit merged into such a node is read out as part of that
    // node's name. The host names the count as state instead - so the badge
    // itself must contribute nothing, whoever draws it.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Semantics(container: true, label: 'Chats', child: const CountBadge(count: 3)),
        ),
      ),
    );

    expect(find.text('3'), findsOneWidget, reason: 'the number is still drawn');
    expect(
      tester.getSemantics(find.bySemanticsLabel('Chats')).getSemanticsData().label,
      'Chats',
      reason: 'nothing of the badge reaches what is spoken',
    );

    handle.dispose();
  });

  testWidgets('a number over the cap is drawn capped', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: CountBadge(count: 128))));

    expect(find.text('99+'), findsOneWidget);
    expect(find.text('128'), findsNothing);
  });

  testWidgets('a number at the cap is drawn as itself', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: CountBadge(count: 99))));

    expect(find.text('99'), findsOneWidget);
  });

  testWidgets('what a capped badge is announced as comes from its host, and is not capped', (tester) async {
    // The point of the cap: it belongs to the drawing only. A screen reader is
    // told the real number, because the host that speaks it has the count and
    // never sees what the badge managed to fit.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Semantics(
            container: true,
            label: 'Voicemail',
            value: '128 unread',
            child: const CountBadge(count: 128, maxCount: 9, size: 14),
          ),
        ),
      ),
    );

    expect(find.text('9+'), findsOneWidget, reason: 'a badge this small can only fit so much');
    expect(tester.getSemantics(find.bySemanticsLabel('Voicemail')).getSemanticsData().value, '128 unread');

    handle.dispose();
  });

  testWidgets('a short number leaves the badge a circle, a longer one stretches it sideways', (tester) async {
    // The badge keeps the height of the slot it was given whatever it counts;
    // what grows is its width, so the digits stay the size they were drawn at
    // instead of shrinking into the shape.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountBadge(count: 7, size: 20),
                CountBadge(count: 42, size: 20),
                CountBadge(count: 128, size: 20),
              ],
            ),
          ),
        ),
      ),
    );

    final short = tester.getSize(find.byType(CountBadge).first);
    final twoDigits = tester.getSize(find.byType(CountBadge).at(1));
    final long = tester.getSize(find.byType(CountBadge).last);

    // How many digits still fit the circle is a question about the real font -
    // the test one draws every glyph as a square - so what is pinned here is the
    // rule itself: never narrower than tall, and wider only when the number
    // needs it.
    expect(short, const Size(20, 20), reason: 'a short number stays a circle');
    expect(twoDigits.height, 20);
    expect(twoDigits.width, greaterThanOrEqualTo(20), reason: 'the badge is never narrower than it is tall');
    expect(long.height, 20, reason: 'the badge keeps the height of its slot');
    expect(long.width, greaterThan(twoDigits.width), reason: 'it grows sideways rather than shrinking the number');
  });

  testWidgets('a badge drawn on the accent swaps its colours instead of vanishing into it', (tester) async {
    const colorScheme = ColorScheme.light(primary: Color(0xFF112233), onPrimary: Color(0xFFEEDDCC));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.from(colorScheme: colorScheme),
        home: const Scaffold(body: Row(children: [CountBadge(count: 1), CountBadge(count: 1, onAccent: true)])),
      ),
    );

    Color backgroundOf(int index) {
      final decoration = tester.widgetList<Container>(find.byType(Container)).elementAt(index).decoration;
      return switch (decoration) {
        ShapeDecoration(:final color) => color!,
        BoxDecoration(:final color) => color!,
        _ => throw StateError('the badge is expected to paint its own background'),
      };
    }

    expect(backgroundOf(0), colorScheme.primary);
    expect(backgroundOf(1), colorScheme.onPrimary);
  });
}
