import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/factory/theme_style_factory_provider.dart';
import 'package:webtrit_phone/widgets/confirm_dialog.dart';

/// What the theme is handed, and what the confirm dialog reads out of it.
///
/// `ThemeData.extensions` is keyed by type, so two entries of one type are not
/// an error: the second silently replaces the first and the first build is
/// thrown away. That is how one factory ran twice for a whole release without
/// anything noticing, and the compiler cannot see it - only a list can.
void main() {
  ThemeStyleFactoryProvider provider({ThemeWidgetConfig widget = const ThemeWidgetConfig()}) =>
      ThemeStyleFactoryProvider(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8)),
        widgetConfig: widget,
        pageConfig: const ThemePageConfig(),
        seedThemeData: ThemeData.light(),
      );

  Color? foregroundOf(ButtonStyle? style) => style?.foregroundColor?.resolve(const <WidgetState>{});

  ConfirmDialogStyle dialogOf(ThemeStyleFactoryProvider p) =>
      p.createThemeExtensions().whereType<ConfirmDialogStyles>().single.primary!;

  test('no two extensions are registered under the same type', () {
    final types = provider().createThemeExtensions().map((extension) => extension.runtimeType).toList();

    expect(types, types.toSet().toList(), reason: 'a repeated type means one build replaced another');
  });

  // A colour the theme does not name used to be written down anyway, as a
  // property that exists and resolves to null, and a property that says nothing
  // still wins the `copyWith` it is handed to. Both buttons took one that way,
  // so both fell through to the same `TextButton` default.
  test('the confirming and the destructive button do not read alike unstyled', () {
    final dialog = dialogOf(provider());

    expect(foregroundOf(dialog.activeButtonStyle1), isNotNull);
    expect(foregroundOf(dialog.activeButtonStyle2), isNotNull);
    expect(foregroundOf(dialog.activeButtonStyle1), isNot(foregroundOf(dialog.activeButtonStyle2)));
  });

  test('a theme that names the confirm colours keeps them', () {
    final dialog = dialogOf(
      provider(
        widget: const ThemeWidgetConfig(
          dialog: DialogWidgetConfig(
            confirmDialog: ConfirmDialogWidgetConfig(activeButtonColor1: '#123456', activeButtonColor2: '#654321'),
          ),
        ),
      ),
    );

    expect(foregroundOf(dialog.activeButtonStyle1), const Color(0xFF123456));
    expect(foregroundOf(dialog.activeButtonStyle2), const Color(0xFF654321));
  });
}
