import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    super.key,
    required this.settings,
    required this.lightDynamic,
    required this.darkDynamic,
    required super.child,
  }) : super();

  final ValueNotifier<ThemeSettings> settings;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(Blend.harmonize(targetColor.value, settings.value.seedColor.value));
  }

  Color source(Color? target) {
    Color source = settings.value.seedColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light ? lightDynamic?.primary : darkDynamic?.primary;
    final colorSchemeOverride = brightness == Brightness.light
        ? settings.value.lightColorSchemeOverride
        : settings.value.darkColorSchemeOverride;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
      primary: colorSchemeOverride?.primary,
      onPrimary: colorSchemeOverride?.onPrimary,
      primaryContainer: colorSchemeOverride?.primaryContainer,
      onPrimaryContainer: colorSchemeOverride?.onPrimaryContainer,
      secondary: colorSchemeOverride?.secondary,
      onSecondary: colorSchemeOverride?.onSecondary,
      secondaryContainer: colorSchemeOverride?.secondaryContainer,
      onSecondaryContainer: colorSchemeOverride?.onSecondaryContainer,
      tertiary: colorSchemeOverride?.tertiary,
      onTertiary: colorSchemeOverride?.onTertiary,
      tertiaryContainer: colorSchemeOverride?.tertiaryContainer,
      onTertiaryContainer: colorSchemeOverride?.onTertiaryContainer,
      error: colorSchemeOverride?.error,
      onError: colorSchemeOverride?.onError,
      errorContainer: colorSchemeOverride?.errorContainer,
      onErrorContainer: colorSchemeOverride?.onErrorContainer,
      outline: colorSchemeOverride?.outline,
      background: colorSchemeOverride?.background,
      onBackground: colorSchemeOverride?.onBackground,
      surface: colorSchemeOverride?.surface,
      onSurface: colorSchemeOverride?.onSurface,
      surfaceVariant: colorSchemeOverride?.surfaceVariant,
      onSurfaceVariant: colorSchemeOverride?.onSurfaceVariant,
      inverseSurface: colorSchemeOverride?.inverseSurface,
      onInverseSurface: colorSchemeOverride?.onInverseSurface,
      inversePrimary: colorSchemeOverride?.inversePrimary,
      shadow: colorSchemeOverride?.shadow,
      surfaceTint: colorSchemeOverride?.surfaceTint,
    );
  }

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  ElevatedButtonStyles elevatedButtonStyles(ColorScheme colors) {
    return ElevatedButtonStyles(
      primary: ElevatedButton.styleFrom(
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        onSurface: colors.onPrimaryContainer,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutral: ElevatedButton.styleFrom(
        primary: colors.background,
        onPrimary: colors.onBackground,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
    );
  }

  OutlinedButtonStyles outlinedButtonStyles(ColorScheme colors) {
    return OutlinedButtonStyles(
      neutral: OutlinedButton.styleFrom(
        primary: colors.onBackground,
        side: BorderSide(
          color: colors.onBackground.withOpacity(0.2),
        ),
      ),
    );
  }

  Gradients gradients(ColorScheme colors) {
    final customColors = settings.value.primaryGradientColors;
    return Gradients(
      tab: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: customColors.map((customColor) => customColor.value(this)).toList(growable: false),
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colors) {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: colors.background,
      contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.primary,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.error,
        ),
      ),
    );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return const AppBarTheme(
      scrolledUnderElevation: 0,
      centerTitle: true,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
    );
  }

  ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
    );
  }

  OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colors) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
      ),
    );
  }

  TextButtonThemeData textButtonTheme(ColorScheme colors) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const StadiumBorder(),
      ),
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      iconColor: colors.secondary,
    );
  }

  ThemeData? light([Color? targetColor]) {
    final colorScheme = colors(Brightness.light, targetColor);
    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: GoogleFonts.montserratTextTheme(),
      useMaterial3: true,
    ).copyWith(
      // GENERAL CONFIGURATIONValueNotifier
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      extensions: [
        elevatedButtonStyles(colorScheme),
        outlinedButtonStyles(colorScheme),
        gradients(colorScheme),
      ],
      // COLOR
      primaryColorLight: colorScheme.secondaryContainer,
      primaryColorDark: colorScheme.onSecondaryContainer,
      dividerColor: colorScheme.outline,
      unselectedWidgetColor: colorScheme.onSurface,
      indicatorColor: colorScheme.primary,
      toggleableActiveColor: colorScheme.primary,
      // TYPOGRAPHY & ICONOGRAPHY
      // COMPONENT THEMES
      appBarTheme: appBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: outlinedButtonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
    );
  }

  ThemeData? dark([Color? targetColor]) {
    final colorScheme = colors(Brightness.dark, targetColor);
    // TODO: Not implemented yet
    return null;
  }

  ThemeMode themeMode() {
    return settings.value.themeMode;
  }

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}
