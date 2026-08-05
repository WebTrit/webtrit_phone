import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/theme_data/app_bar_theme_data_factory.dart';

void main() {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

  AppBarTheme create(AppBarConfig config) => AppBarThemeDataFactory(colorScheme, config, null).create();

  group('AppBarThemeDataFactory titleTextStyle color', () {
    test('explicit title color wins over foreground', () {
      final theme = create(
        const AppBarConfig(
          foregroundColor: '#445566',
          titleTextStyle: TextStyleConfig(fontSize: 18, color: '#112233'),
        ),
      );

      expect(theme.titleTextStyle?.color, const Color(0xFF112233));
    });

    test('title style without color falls back to foreground', () {
      final theme = create(
        const AppBarConfig(foregroundColor: '#445566', titleTextStyle: TextStyleConfig(fontSize: 18)),
      );

      expect(theme.titleTextStyle?.color, const Color(0xFF445566));
      expect(theme.titleTextStyle?.fontSize, 18);
    });

    test('title style without color and foreground falls back to scheme onSurface', () {
      final theme = create(const AppBarConfig(titleTextStyle: TextStyleConfig(fontSize: 18)));

      expect(theme.titleTextStyle?.color, colorScheme.onSurface);
    });

    test('absent title style stays null so the framework default applies', () {
      final theme = create(const AppBarConfig(foregroundColor: '#445566'));

      expect(theme.titleTextStyle, isNull);
      expect(theme.foregroundColor, const Color(0xFF445566));
    });
  });

  group('AppBarThemeDataFactory toolbarTextStyle color', () {
    test('toolbar style without color falls back to foreground', () {
      final theme = create(
        const AppBarConfig(foregroundColor: '#445566', toolbarTextStyle: TextStyleConfig(fontSize: 14)),
      );

      expect(theme.toolbarTextStyle?.color, const Color(0xFF445566));
    });
  });

  group('AppBarThemeDataFactory icon theme colors', () {
    test('explicit icon colors win over foreground', () {
      final theme = create(
        const AppBarConfig(
          foregroundColor: '#445566',
          iconTheme: IconThemeDataConfig(color: '#112233'),
          actionsIconTheme: IconThemeDataConfig(color: '#223344'),
        ),
      );

      expect(theme.iconTheme?.color, const Color(0xFF112233));
      expect(theme.actionsIconTheme?.color, const Color(0xFF223344));
    });

    test('icon themes without color fall back to foreground', () {
      final theme = create(
        const AppBarConfig(
          foregroundColor: '#445566',
          iconTheme: IconThemeDataConfig(size: 20),
          actionsIconTheme: IconThemeDataConfig(size: 22),
        ),
      );

      expect(theme.iconTheme?.color, const Color(0xFF445566));
      expect(theme.iconTheme?.size, 20);
      expect(theme.actionsIconTheme?.color, const Color(0xFF445566));
    });

    test('icon themes without color and foreground fall back to scheme roles', () {
      final theme = create(
        const AppBarConfig(iconTheme: IconThemeDataConfig(size: 20), actionsIconTheme: IconThemeDataConfig(size: 22)),
      );

      expect(theme.iconTheme?.color, colorScheme.onSurface);
      expect(theme.actionsIconTheme?.color, colorScheme.onSurfaceVariant);
    });

    test('absent icon themes stay null so the framework default applies', () {
      final theme = create(const AppBarConfig(foregroundColor: '#445566'));

      expect(theme.iconTheme, isNull);
      expect(theme.actionsIconTheme, isNull);
    });
  });
}
