import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/app_bar_config_merge.dart';
import 'package:webtrit_phone/theme/factory/theme_data/app_bar_theme_data_factory.dart';

void main() {
  const global = AppBarConfig(
    backgroundColor: '#14284B',
    foregroundColor: '#FFFFFF',
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyleConfig(fontSize: 18),
  );

  group('AppBarConfig.mergeOver', () {
    test('page fields win over the global config', () {
      const page = AppBarConfig(backgroundColor: '#00000000', foregroundColor: '#EEF3F6');
      final merged = page.mergeOver(global);

      expect(merged.backgroundColor, '#00000000');
      expect(merged.foregroundColor, '#EEF3F6');
    });

    test('unset page fields fall through to the global config', () {
      const page = AppBarConfig(backgroundColor: '#00000000');
      final merged = page.mergeOver(global);

      expect(merged.foregroundColor, '#FFFFFF');
      expect(merged.elevation, 0);
      expect(merged.centerTitle, true);
      expect(merged.titleTextStyle?.fontSize, 18);
    });

    test('nested styles merge field-wise, not wholesale', () {
      const brandGlobal = AppBarConfig(
        iconTheme: IconThemeDataConfig(color: '#AA0000'),
        titleTextStyle: TextStyleConfig(fontSize: 18, color: '#00AA00'),
      );
      const page = AppBarConfig(
        iconTheme: IconThemeDataConfig(size: 20),
        titleTextStyle: TextStyleConfig(fontSize: 22),
      );
      final merged = page.mergeOver(brandGlobal);

      expect(merged.iconTheme?.size, 20);
      expect(merged.iconTheme?.color, '#AA0000');
      expect(merged.titleTextStyle?.fontSize, 22);
      expect(merged.titleTextStyle?.color, '#00AA00');
    });

    test('merged config resolves title color through the page foreground', () {
      const page = AppBarConfig(foregroundColor: '#EEF3F6');
      final colorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
      final theme = AppBarThemeDataFactory(colorScheme, page.mergeOver(global), null).create();

      expect(theme.titleTextStyle?.color, const Color(0xFFEEF3F6));
      expect(theme.backgroundColor, const Color(0xFF14284B));
    });
  });
}
