import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/avatar_colors.dart';

void main() {
  group('AvatarColors.background', () {
    test('is deterministic for the same seed', () {
      expect(
        AvatarColors.background('John Doe', Brightness.light),
        AvatarColors.background('John Doe', Brightness.light),
      );
    });

    test('ignores case and surrounding whitespace', () {
      expect(
        AvatarColors.background('  john doe ', Brightness.light),
        AvatarColors.background('John Doe', Brightness.light),
      );
    });

    test('returns null for null/blank seeds', () {
      expect(AvatarColors.background(null, Brightness.light), isNull);
      expect(AvatarColors.background('', Brightness.light), isNull);
      expect(AvatarColors.background('   ', Brightness.light), isNull);
    });

    test('differs between light and dark brightness', () {
      expect(
        AvatarColors.background('John Doe', Brightness.light),
        isNot(AvatarColors.background('John Doe', Brightness.dark)),
      );
    });

    test('spreads distinct seeds over multiple colors', () {
      final seeds = List.generate(30, (i) => 'Contact $i');
      final colors = seeds.map((s) => AvatarColors.background(s, Brightness.light)).toSet();

      expect(colors.length, greaterThan(15));
    });

    test('picks from an explicit palette', () {
      const palette = [Colors.red, Colors.green, Colors.blue];

      for (final seed in ['a', 'bb', 'ccc', 'John Doe']) {
        expect(palette, contains(AvatarColors.background(seed, Brightness.light, palette: palette)));
      }
    });

    test('falls back to generated colors for an empty palette', () {
      expect(
        AvatarColors.background('John Doe', Brightness.light, palette: const []),
        AvatarColors.background('John Doe', Brightness.light),
      );
    });
  });

  group('AvatarColors.foreground', () {
    test('contrasts with the generated background', () {
      for (final brightness in Brightness.values) {
        final background = AvatarColors.background('John Doe', brightness)!;
        final foreground = AvatarColors.foreground(background, brightness);

        expect((background.computeLuminance() - foreground.computeLuminance()).abs(), greaterThan(0.2));
      }
    });

    test('uses plain black/white on greyscale palette entries', () {
      expect(AvatarColors.foreground(Colors.white, Brightness.light), Colors.black87);
      expect(AvatarColors.foreground(Colors.black, Brightness.light), Colors.white);
    });
  });
}
