import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:webtrit_theme/webtrit_theme.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

import 'theme.dart';

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

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color.toColor());
    } else {
      return custom.color.toColor();
    }
  }

  Color blend(Color targetColor) {
    return Color(Blend.harmonize(targetColor.value, settings.seedColor.toColor().value));
  }

  Color source(Color? target) {
    Color source = settings.seedColor.toColor();
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light ? lightDynamic?.primary : darkDynamic?.primary;
    final colorSchemeOverride =
        brightness == Brightness.light ? settings.lightColorSchemeOverride : settings.darkColorSchemeOverride;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
      primary: colorSchemeOverride?.primary?.toColor(),
      onPrimary: colorSchemeOverride?.onPrimary?.toColor(),
      primaryContainer: colorSchemeOverride?.primaryContainer?.toColor(),
      onPrimaryContainer: colorSchemeOverride?.onPrimaryContainer?.toColor(),
      secondary: colorSchemeOverride?.secondary?.toColor(),
      onSecondary: colorSchemeOverride?.onSecondary?.toColor(),
      secondaryContainer: colorSchemeOverride?.secondaryContainer?.toColor(),
      onSecondaryContainer: colorSchemeOverride?.onSecondaryContainer?.toColor(),
      tertiary: colorSchemeOverride?.tertiary?.toColor(),
      onTertiary: colorSchemeOverride?.onTertiary?.toColor(),
      tertiaryContainer: colorSchemeOverride?.tertiaryContainer?.toColor(),
      onTertiaryContainer: colorSchemeOverride?.onTertiaryContainer?.toColor(),
      error: colorSchemeOverride?.error?.toColor(),
      onError: colorSchemeOverride?.onError?.toColor(),
      errorContainer: colorSchemeOverride?.errorContainer?.toColor(),
      onErrorContainer: colorSchemeOverride?.onErrorContainer?.toColor(),
      outline: colorSchemeOverride?.outline?.toColor(),
      outlineVariant: colorSchemeOverride?.outlineVariant?.toColor(),
      background: colorSchemeOverride?.background?.toColor(),
      onBackground: colorSchemeOverride?.onBackground?.toColor(),
      surface: colorSchemeOverride?.surface?.toColor(),
      onSurface: colorSchemeOverride?.onSurface?.toColor(),
      surfaceVariant: colorSchemeOverride?.surfaceVariant?.toColor(),
      onSurfaceVariant: colorSchemeOverride?.onSurfaceVariant?.toColor(),
      inverseSurface: colorSchemeOverride?.inverseSurface?.toColor(),
      onInverseSurface: colorSchemeOverride?.onInverseSurface?.toColor(),
      inversePrimary: colorSchemeOverride?.inversePrimary?.toColor(),
      shadow: colorSchemeOverride?.shadow?.toColor(),
      scrim: colorSchemeOverride?.scrim?.toColor(),
      surfaceTint: colorSchemeOverride?.surfaceTint?.toColor(),
    );
  }

  TextTheme? textTheme(Brightness brightness) {
    final fontFamily = settings.fontFamily;
    if (fontFamily == null) {
      return null;
    } else {
      final textTheme = brightness == Brightness.light ? ThemeData.light().textTheme : ThemeData.dark().textTheme;
      return GoogleFonts.getTextTheme(fontFamily, textTheme);
    }
  }

  InputDecorations inputDecorations(ColorScheme colors) {
    return const InputDecorations(
      search: InputDecoration(
        isDense: false,
        filled: false,
        isCollapsed: true,
        border: InputBorder.none,
      ),
      keypad: InputDecoration(
        filled: false,
        border: InputBorder.none,
      ),
    );
  }

  LogoAssets logoAssets({
    required ThemeSvgAsset primaryOnboardin,
    required ThemeSvgAsset secondaryOnboardin,
  }) {
    return LogoAssets(
      primaryOnboarding: primaryOnboardin,
      secondaryOnboarding: secondaryOnboardin,
    );
  }

  ElevatedButtonStyles elevatedButtonStyles(ColorScheme colors) {
    return ElevatedButtonStyles(
      primary: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        disabledForegroundColor: colors.onPrimaryContainer.withOpacity(0.38),
        disabledBackgroundColor: colors.onPrimaryContainer.withOpacity(0.12),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutral: ElevatedButton.styleFrom(
        foregroundColor: colors.onBackground,
        backgroundColor: colors.background,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      primaryOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        disabledForegroundColor: colors.onPrimary.withOpacity(0.5),
        disabledBackgroundColor: colors.primary.withOpacity(0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutralOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onBackground,
        backgroundColor: colors.background,
        disabledForegroundColor: colors.onBackground.withOpacity(0.5),
        disabledBackgroundColor: colors.background.withOpacity(0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
    );
  }

  OutlinedButtonStyles outlinedButtonStyles(ColorScheme colors) {
    return OutlinedButtonStyles(
      neutral: OutlinedButton.styleFrom(
        foregroundColor: colors.onBackground,
        side: BorderSide(
          color: colors.onBackground.withOpacity(0.2),
        ),
      ),
    );
  }

  TextButtonStyles textButtonStyles(ColorScheme colors) {
    return TextButtonStyles(
      neutral: TextButton.styleFrom(
        foregroundColor: colors.secondary,
      ),
      dangerous: TextButton.styleFrom(
        foregroundColor: colors.error,
      ),
      callStart: TextButton.styleFrom(
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
        disabledForegroundColor: colors.onTertiary.withOpacity(0.38),
      ),
      callHangup: TextButton.styleFrom(
        foregroundColor: colors.onError,
        backgroundColor: colors.error,
        disabledForegroundColor: colors.onError.withOpacity(0.38),
      ),
      callAction: TextButton.styleFrom(
        foregroundColor: colors.surface,
        backgroundColor: colors.surface.withOpacity(0.3),
      ),
      callActiveAction: TextButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
      ),
    );
  }

  Gradients gradients(ColorScheme colors) {
    final customColors = settings.primaryGradientColors;
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
      isDense: true,
      filled: true,
      fillColor: colors.background,
      border: MaterialStateOutlineInputBorder.resolveWith((states) {
        final Color borderColor;
        final bool isError = states.contains(MaterialState.error);
        if (states.contains(MaterialState.disabled)) {
          borderColor = isError ? colors.error.withOpacity(0.25) : colors.onBackground.withOpacity(0.25);
        } else if (states.contains(MaterialState.focused)) {
          borderColor = isError ? colors.error : colors.primary;
        } else {
          borderColor = isError ? colors.error.withOpacity(0.5) : colors.onBackground.withOpacity(0.5);
        }
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        );
      }),
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

  SnackBarThemeData snackBarTheme(ColorScheme colors) {
    return SnackBarThemeData(
      actionTextColor: colors.surface,
    );
  }

  ThemeData? light([Color? targetColor]) {
    const brightness = Brightness.light;
    final colorScheme = colors(brightness, targetColor);
    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme(brightness),
      useMaterial3: true,
    ).copyWith(
      // GENERAL CONFIGURATIONValueNotifier
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      extensions: [
        inputDecorations(colorScheme),
        elevatedButtonStyles(colorScheme),
        outlinedButtonStyles(colorScheme),
        textButtonStyles(colorScheme),
        gradients(colorScheme),
        logoAssets(
          primaryOnboardin: settings.primaryOnboardingSvgLogo,
          secondaryOnboardin: settings.secondaryOnboardingSvgLogo,
        ),
      ],
      // COLOR
      primaryColorLight: colorScheme.secondaryContainer,
      primaryColorDark: colorScheme.onSecondaryContainer,
      unselectedWidgetColor: colorScheme.onSurface,
      indicatorColor: colorScheme.primary,
      // TYPOGRAPHY & ICONOGRAPHY
      // COMPONENT THEMES
      appBarTheme: appBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: outlinedButtonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      snackBarTheme: snackBarTheme(colorScheme),
    );
  }

  ThemeData? dark([Color? targetColor]) {
    const brightness = Brightness.dark;
    // ignore: unused_local_variable
    final colorScheme = colors(brightness, targetColor);
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
