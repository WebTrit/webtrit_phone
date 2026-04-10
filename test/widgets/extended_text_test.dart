import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Widget wrapWithMaterial(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('renders plain Text when extendedStyle is null', (tester) async {
    await tester.pumpWidget(wrapWithMaterial(const ExtendedText('Hello')));

    expect(find.text('Hello'), findsOneWidget);
    expect(find.byType(DecoratedBox), findsNothing);
  });

  testWidgets('renders plain Text when decoration is null', (tester) async {
    await tester.pumpWidget(
      wrapWithMaterial(
        const ExtendedText('Hello', extendedStyle: ExtendedTextStyle(textStyle: TextStyle(fontSize: 20))),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.byType(DecoratedBox), findsNothing);

    final text = tester.widget<Text>(find.text('Hello'));
    expect(text.style?.fontSize, 20);
  });

  testWidgets('renders DecoratedBox when decoration is provided', (tester) async {
    await tester.pumpWidget(
      wrapWithMaterial(
        const ExtendedText(
          'Styled',
          extendedStyle: ExtendedTextStyle(
            textStyle: TextStyle(color: Colors.white),
            decoration: ExtendedTextDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              padding: EdgeInsets.all(12),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Styled'), findsOneWidget);
    expect(find.byType(DecoratedBox), findsOneWidget);

    final decoratedBox = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
    final boxDecoration = decoratedBox.decoration as BoxDecoration;
    expect(boxDecoration.color, Colors.blue);
    expect(boxDecoration.borderRadius, const BorderRadius.all(Radius.circular(8)));

    final padding = tester.widget<Padding>(find.byType(Padding));
    expect(padding.padding, const EdgeInsets.all(12));
  });

  testWidgets('applies textAlign correctly', (tester) async {
    await tester.pumpWidget(wrapWithMaterial(const ExtendedText('Centered', textAlign: TextAlign.center)));

    final text = tester.widget<Text>(find.text('Centered'));
    expect(text.textAlign, TextAlign.center);
  });

  testWidgets('uses EdgeInsets.zero when decoration padding is null', (tester) async {
    await tester.pumpWidget(
      wrapWithMaterial(
        const ExtendedText(
          'No padding',
          extendedStyle: ExtendedTextStyle(decoration: ExtendedTextDecoration(color: Colors.red)),
        ),
      ),
    );

    final padding = tester.widget<Padding>(find.byType(Padding));
    expect(padding.padding, EdgeInsets.zero);
  });
}
