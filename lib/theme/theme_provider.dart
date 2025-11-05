import 'package:flutter/material.dart';

import 'package:material_color_utilities/material_color_utilities.dart';

import 'factory/factory.dart';
import 'models/models.dart';
import 'extension/extension.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    super.key,
    required this.settings,
    required this.lightDynamic,
    required this.darkDynamic,
    required super.child,
  }) : super();

  final ThemeSettings settings;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  /// Retrieves the widget-specific theme configuration based on brightness.
  ThemeWidgetConfig? _getThemeWidgetConfig(Brightness brightness) {
    return brightness.isLight ? settings.themeWidgetLightConfig : settings.themeWidgetDarkConfig;
  }

  /// Retrieves the page-specific theme configuration based on brightness.
  ThemePageConfig? _getThemePageConfig(Brightness brightness) {
    return brightness.isLight ? settings.themePageLightConfig : settings.themePageDarkConfig;
  }

  /// Computes a custom color based on blending settings.
  Color custom(CustomColor custom, Color seedColor) {
    return custom.blend ? _blend(custom.color.toColor(), seedColor) : custom.color.toColor();
  }

  /// Blends the target color with the seed color using Material harmonization.
  ///
  /// If the `target` color is `null`, equal to `seedColor`, or `harmonize` is `false`,
  /// the function returns `seedColor` without applying any blending.
  ///
  /// This ensures that blending is applied only when necessary, optimizing performance.
  ///
  /// - [target] The color to be blended with the seed color. If `null`, blending is skipped.
  /// - [seedColor] The base color used for blending.
  /// - [harmonize] If `true`, applies Material color harmonization; otherwise, returns `seedColor` as is.
  ///
  /// Returns a blended color or `seedColor` if no blending is needed.
  Color _blend(Color? target, Color seedColor, {bool harmonize = true}) {
    if (target == null || target == seedColor || !harmonize) return seedColor;
    return Color(Blend.harmonize(target.toARGB32(), seedColor.toARGB32()));
  }

  /// Determines the source color based on the provided target and seed color.
  ///
  /// If `target` is `null`, returns `seedColor`. Otherwise, it blends `target` with `seedColor`
  /// using the `_blend` method, ensuring color consistency in theme generation.
  ///
  /// - [target] The optional color that may be blended.
  /// - [seedColor] The base color used when `target` is `null`.
  ///
  /// Returns either the blended color or `seedColor` if `target` is not provided.
  Color _source(Color? target, Color seedColor) => _blend(target, seedColor);

  /// Creates a [ColorScheme] based on the given brightness and optional target color.
  ///
  /// Uses dynamic primary colors if available; otherwise, blends the target color with
  /// the configured seed color. Ensures consistency across the light and dark themes.
  ColorScheme _buildColorScheme(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness.isLight ? lightDynamic?.primary : darkDynamic?.primary;
    final colorSchemeConfig = brightness.isLight ? settings.lightColorSchemeConfig : settings.darkColorSchemeConfig;

    final seedColor = colorSchemeConfig.seedColor.toColor();

    return colorSchemeConfig.toColorScheme(
      seedColor: dynamicPrimary ?? _source(targetColor, seedColor),
      brightness: brightness,
      dynamicPrimary: dynamicPrimary,
      targetColor: targetColor,
    );
  }

  /// Builds a [ThemeData] object based on the given brightness and optional target color.
  ///
  /// This method constructs a customized theme using the provided brightness mode,
  /// dynamically generated [ColorScheme], and component-specific styles from
  /// `ThemeStyleFactoryProvider`. The resulting theme integrates with Material 3
  /// and includes custom configurations for widgets, buttons, app bars, and other
  /// UI elements.
  ///
  /// - [brightness] Determines whether the theme is light or dark.
  /// - [targetColor] (Optional) A base color that may be blended with the theme’s seed color.
  ///
  /// Returns a fully configured [ThemeData] object.
  ThemeData _buildThemeData(Brightness brightness, Color? targetColor) {
    final colorScheme = _buildColorScheme(brightness, targetColor);
    final themeWidgetConfig = _getThemeWidgetConfig(brightness)!;
    final themePageConfig = _getThemePageConfig(brightness)!;
    final seedThemeData = brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();

    final style = ThemeStyleFactoryProvider(
      colorScheme: colorScheme,
      widgetConfig: themeWidgetConfig,
      pageConfig: themePageConfig,
      seedThemeData: seedThemeData,
    );

    return ThemeData.from(colorScheme: colorScheme, textTheme: style.createTextTheme(), useMaterial3: true).copyWith(
      primaryColorLight: colorScheme.secondaryContainer,
      primaryColorDark: colorScheme.onSecondaryContainer,
      scaffoldBackgroundColor: colorScheme.surfaceBright,
      unselectedWidgetColor: colorScheme.onSurface,
      appBarTheme: style.createAppBarTheme(),
      tabBarTheme: style.createTabBarTheme(),
      bottomNavigationBarTheme: style.createBottomNavigationBarThemeData(),
      listTileTheme: style.createListTileThemeData(),
      snackBarTheme: style.createSnackBarThemeData(),
      elevatedButtonTheme: style.createElevatedButtonThemeData(),
      outlinedButtonTheme: style.createOutlinedButtonThemeData(),
      textButtonTheme: style.createTextButtonThemeData(),
      textSelectionTheme: style.createTextSelectionThemeData(),
      inputDecorationTheme: style.createInputDecorationTheme(),
      extensions: style.createThemeExtensions(),
    );
  }

  /// Generates the light theme, optionally blending with a target color.
  ThemeData light([Color? targetColor]) => _buildThemeData(Brightness.light, targetColor);

  /// Generates the dark theme, optionally blending with a target color.
  ThemeData dark([Color? targetColor]) => _buildThemeData(Brightness.dark, targetColor);

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}
