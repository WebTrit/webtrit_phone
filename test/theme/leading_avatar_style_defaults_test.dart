import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/styles/styles.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

void main() {
  final colors = ColorScheme.fromSeed(seedColor: const Color(0xFF1F618F));

  LeadingAvatarStyle resolved(LeadingAvatarStyleConfig? config) {
    final styles = LeadingAvatarStyleFactory(colors, config, null).create();
    return styles.primary!;
  }

  group('leading avatar appearance comes from the app', () {
    test('a theme that says nothing gets the app values', () {
      final style = resolved(null);

      expect(style.radius, 20);
      expect(style.backgroundColor, colors.secondaryContainer);
      expect(style.presenceBadge?.sizeFactor, 0.5);
      expect(style.presenceBadge?.availableColor, colors.tertiary);
      expect(style.presenceBadge?.unavailableColor, colors.onSurfaceVariant);
      expect(style.presenceBadge?.iconColor, colors.surface);
      expect(style.registeredBadge?.sizeFactor, 0.2);
      expect(style.smartIndicator?.sizeFactor, 0.4);
      expect(style.nameColors?.enabled, isTrue);
    });

    test('a theme that names one value keeps the app values around it', () {
      final style = resolved(const LeadingAvatarStyleConfig(presenceBadge: PresenceBadgeStyleConfig(sizeFactor: 0.5)));

      expect(style.presenceBadge?.sizeFactor, 0.5);
      expect(style.presenceBadge?.availableColor, colors.tertiary);
      expect(style.radius, 20);
      expect(style.registeredBadge?.sizeFactor, 0.2);
    });

    test('a block with only colors leaves the size to the app', () {
      final style = resolved(
        const LeadingAvatarStyleConfig(presenceBadge: PresenceBadgeStyleConfig(availableColor: '#FF00FF')),
      );

      expect(style.presenceBadge?.availableColor, const Color(0xFFFF00FF));
      expect(style.presenceBadge?.sizeFactor, 0.5);
    });

    test('name colors stay on unless the theme turns them off', () {
      expect(resolved(const LeadingAvatarStyleConfig()).nameColors?.enabled, isTrue);
      expect(
        resolved(const LeadingAvatarStyleConfig(nameColors: NameColorsStyleConfig(enabled: false))).nameColors?.enabled,
        isFalse,
      );
    });
  });

  group('LeadingAvatarStyles.of', () {
    testWidgets('falls back to the app values when the theme carries no extension', (tester) async {
      late LeadingAvatarStyle style;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(colorScheme: colors),
          home: Builder(
            builder: (context) {
              style = LeadingAvatarStyles.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(style.radius, 20);
      expect(style.presenceBadge?.sizeFactor, 0.5);
      expect(style.presenceBadge?.availableColor, colors.tertiary);
    });

    testWidgets('lets the extension override a single value', (tester) async {
      late LeadingAvatarStyle style;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: colors,
            extensions: const [
              LeadingAvatarStyles(primary: LeadingAvatarStyle(presenceBadge: PresenceBadgeStyle(sizeFactor: 0.5))),
            ],
          ),
          home: Builder(
            builder: (context) {
              style = LeadingAvatarStyles.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(style.presenceBadge?.sizeFactor, 0.5);
      expect(style.presenceBadge?.availableColor, colors.tertiary);
      expect(style.radius, 20);
    });
  });
}
