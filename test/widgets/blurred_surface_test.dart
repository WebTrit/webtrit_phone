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
}
