import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/shimmer.dart';

void main() {
  group('Shimmer Widget Tests', () {
    testWidgets('renders successfully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SizedBox(width: 200, height: 100, child: Shimmer())),
        ),
      );

      expect(find.byType(Shimmer), findsOneWidget);
    });

    testWidgets('adapts to Light Theme colors correctly', (tester) async {
      final lightTheme = ThemeData.light();
      final expectedBaseColor = lightTheme.colorScheme.surfaceContainerHighest;

      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme,
          home: const Scaffold(body: SizedBox(width: 200, height: 100, child: Shimmer())),
        ),
      );

      // Verify that the first rect is painted with the calculated light theme base color.
      expect(
        find.byType(Shimmer),
        paints..rect(color: expectedBaseColor),
        reason: 'Should paint the base background using the light theme surfaceContainerHighest color',
      );
    });

    testWidgets('adapts to Dark Theme colors correctly', (tester) async {
      // Setup Dark Theme
      final darkTheme = ThemeData.dark();
      final expectedBaseColor = darkTheme.colorScheme.surfaceContainerHighest;

      await tester.pumpWidget(
        MaterialApp(
          theme: darkTheme,
          home: const Scaffold(body: SizedBox(width: 200, height: 100, child: Shimmer())),
        ),
      );

      // Verify that the first rect is painted with the calculated dark theme base color.
      expect(
        find.byType(Shimmer),
        paints..rect(color: expectedBaseColor),
        reason: 'Should paint the base background using the dark theme surfaceContainerHighest color',
      );
    });

    testWidgets('animates continuously', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SizedBox(width: 200, height: 100, child: Shimmer())),
        ),
      );

      // Verify the widget is built
      expect(find.byType(Shimmer), findsOneWidget);

      // Pump frames to simulate time passing
      // We expect no exceptions during animation frames.
      // While we cannot easily assert the exact shader position without Golden tests,
      // we can ensure the ticker is running and the widget rebuilds/repaints.
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));

      // Ensure widget is still present and valid after a full animation cycle (1500ms)
      expect(find.byType(Shimmer), findsOneWidget);
    });
  });
}
