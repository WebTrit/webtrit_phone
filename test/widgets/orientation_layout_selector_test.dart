import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/orientation_layout_selector.dart';

void main() {
  Widget wrap() {
    return const MaterialApp(
      home: OrientationLayoutSelector(
        portrait: Text('upright', key: Key('portrait')),
        landscape: Text('lying down', key: Key('landscape')),
      ),
    );
  }

  testWidgets('an upright window gets the portrait arrangement only', (tester) async {
    tester.view.physicalSize = const Size(1206, 2622);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap());

    expect(find.byKey(const Key('portrait')), findsOneWidget);
    expect(find.byKey(const Key('landscape')), findsNothing);
  });

  testWidgets('a window lying down gets the landscape arrangement only', (tester) async {
    tester.view.physicalSize = const Size(2622, 1206);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap());

    expect(find.byKey(const Key('landscape')), findsOneWidget);
    expect(find.byKey(const Key('portrait')), findsNothing);
  });

  testWidgets('turning the window swaps the arrangement without a new pumpWidget', (tester) async {
    tester.view.physicalSize = const Size(1206, 2622);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap());
    expect(find.byKey(const Key('portrait')), findsOneWidget);

    tester.view.physicalSize = const Size(2622, 1206);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('landscape')), findsOneWidget);
    expect(find.byKey(const Key('portrait')), findsNothing);
  });
}
