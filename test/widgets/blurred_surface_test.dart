import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/blurred_surface.dart';

void main() {
  group('BlurredSurface.fromStyle', () {
    test('returns null when style is null', () {
      expect(BlurredSurface.fromStyle(null), isNull);
    });

    testWidgets('defaults sigmaX and sigmaY to 10 when not specified', (tester) async {
      final widget = BlurredSurface.fromStyle(const BlurredSurfaceStyle());
      expect(widget, isNotNull);
      expect(widget!.sigmaX, 10.0);
      expect(widget.sigmaY, 10.0);
    });

    testWidgets('uses explicit sigmaX and sigmaY when specified', (tester) async {
      final widget = BlurredSurface.fromStyle(const BlurredSurfaceStyle(sigmaX: 5, sigmaY: 5));
      expect(widget, isNotNull);
      expect(widget!.sigmaX, 5.0);
      expect(widget.sigmaY, 5.0);
    });

    testWidgets('applies color from style', (tester) async {
      final widget = BlurredSurface.fromStyle(const BlurredSurfaceStyle(color: Colors.red));
      expect(widget, isNotNull);
      expect(widget!.color, Colors.red);
    });
  });

  group('BlurredSurface.adaptive', () {
    Future<BlurredSurface?> adaptiveFor(WidgetTester tester, Color? appBarBackground) async {
      BlurredSurface? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: appBarBackground)),
          home: Builder(
            builder: (context) {
              result = BlurredSurface.adaptive(context);
              return const SizedBox();
            },
          ),
        ),
      );
      return result;
    }

    testWidgets('blurs when the themed bar background is fully transparent', (tester) async {
      expect(await adaptiveFor(tester, const Color(0x00000000)), isNotNull);
    });

    testWidgets('blurs when the themed bar background is semi-transparent', (tester) async {
      expect(await adaptiveFor(tester, const Color(0x9614284B)), isNotNull);
    });

    testWidgets('blurs when no bar background is configured', (tester) async {
      expect(await adaptiveFor(tester, null), isNotNull);
    });

    testWidgets('carries a semi-opaque surface tint so a transparent bar stays visible', (tester) async {
      final surface = await adaptiveFor(tester, const Color(0x00000000));
      expect(surface?.color, isNotNull);
      expect(surface!.color!.a, closeTo(0x96 / 255, 0.01));
    });

    testWidgets('stays solid when the themed bar background is opaque', (tester) async {
      expect(await adaptiveFor(tester, const Color(0xFF14284B)), isNull);
    });
  });
}
