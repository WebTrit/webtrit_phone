import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
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

  /// Blends two colors using harmonization.
  Color _blend(Color targetColor, Color seedColor) {
    return Color(Blend.harmonize(targetColor.value, seedColor.value));
  }

  /// Determines the source color based on target and seed color.
  Color _source(Color? target, Color seedColor) {
    return target != null ? _blend(target, seedColor) : seedColor;
  }

  /// Generates a [ColorScheme] based on brightness and target color.
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

  /// Returns a [TextTheme] customized for the given brightness.
  TextTheme _textTheme(Brightness brightness) {
    final themeConfig = brightness.isLight ? settings.themeWidgetLightConfig : settings.themeWidgetDarkConfig;

    final fontFamily = themeConfig.fonts.fontFamily;

    final baseTextTheme = brightness.isLight ? ThemeData.light().textTheme : ThemeData.dark().textTheme;

    return GoogleFonts.getTextTheme(fontFamily, baseTextTheme);
  }

  ThemeData? light([Color? targetColor]) {
    const brightness = Brightness.light;
    final colorScheme = _buildColorScheme(brightness, targetColor);
    final themeWidgetConfig = _getThemeWidgetConfig(brightness);
    final themePageConfig = _getThemePageConfig(brightness);

    final style = ThemeStyleFactoryProvider(
        colorScheme: colorScheme, widgetConfig: themeWidgetConfig!, pageConfig: themePageConfig!);

    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: _textTheme(brightness),
      useMaterial3: true,
    ).copyWith(
      // General properties
      primaryColorLight: colorScheme.secondaryContainer,
      primaryColorDark: colorScheme.onSecondaryContainer,
      scaffoldBackgroundColor: colorScheme.surfaceBright,
      unselectedWidgetColor: colorScheme.onSurface,
      indicatorColor: colorScheme.primary,

      // Themes for specific components
      appBarTheme: style.createAppBarTheme(),
      tabBarTheme: style.createTabBarTheme(),
      bottomNavigationBarTheme: style.createBottomNavigationBarThemeData(),
      listTileTheme: style.createListTileThemeData(),
      snackBarTheme: style.createSnackBarThemeData(),

      // Button themes
      elevatedButtonTheme: style.createElevatedButtonThemeData(),
      outlinedButtonTheme: style.createOutlinedButtonThemeData(),
      textButtonTheme: style.createTextButtonThemeData(),

      // Input and selection themes
      textSelectionTheme: style.createTextSelectionThemeData(),
      inputDecorationTheme: style.createInputDecorationTheme(),

      // Custom extensions
      extensions: style.createThemeExtensions(),
    );
  }

  ThemeData? dark([Color? targetColor]) {
    const brightness = Brightness.dark;
    // ignore: unused_local_variable
    final colorScheme = _buildColorScheme(brightness, targetColor);
    // ignore: unused_local_variable
    final themeWidgetConfig = _getThemeWidgetConfig(brightness);
    // TODO: Not implemented yet
    return null;
  }

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}
