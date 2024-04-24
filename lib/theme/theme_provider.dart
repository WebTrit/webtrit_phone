import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

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
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(Blend.harmonize(targetColor.value, settings.seedColor.value));
  }

  Color source(Color? target) {
    Color source = settings.seedColor;
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
      outlineVariant: colorSchemeOverride?.outlineVariant,
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
      scrim: colorSchemeOverride?.scrim,
      surfaceTint: colorSchemeOverride?.surfaceTint,
    );
  }

  ThemeWidgetConfig? _themeWidgetConfig(Brightness brightness) {
    return brightness == Brightness.light ? settings.themeWidgetLightConfig : settings.themeWidgetDarkConfig;
  }

  ThemePageConfig? _themePageConfig(Brightness brightness) {
    return brightness == Brightness.light ? settings.themePageLightConfig : settings.themePageDarkConfig;
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

  GroupTitleListStyles groupTitleListStyles(GroupTitleListTileWidgetConfig? groupTitleListTile) {
    return GroupTitleListStyles(
      primary: GroutTitleListStyle(
        textStyle: const TextStyle(color: Colors.white),
        background: groupTitleListTile?.backgroundColor,
      ),
    );
  }

  OnboardingPictureLogoStyles onboardingPictureLogoStyles(
    ColorScheme colors,
    OnboardingPictureLogoWidgetConfig? onboardingPictureLogo,
  ) {
    return OnboardingPictureLogoStyles(
      primary: OnboardingPictureLogoStyle(
        scale: onboardingPictureLogo?.scale,
        textStyle: TextStyle(
          color: onboardingPictureLogo?.labelColor ?? colors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ElevatedButtonStyles elevatedButtonStyles(
    ColorScheme colors,
    ElevatedButtonWidgetConfig? elevatedButtonAddons,
  ) {
    return ElevatedButtonStyles(
      primary: ElevatedButton.styleFrom(
        foregroundColor: elevatedButtonAddons?.foregroundColor ?? colors.onPrimary,
        backgroundColor: elevatedButtonAddons?.backgroundColor ?? colors.primary,
        textStyle: TextStyle(color: elevatedButtonAddons?.textColor),
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

  LoginPageStyles loginPageStyles(LoginModeSelectPageConfig? loginSettings) {
    return LoginPageStyles(
      primary: LoginModeSelectStyle(
        signInTypeButton: loginSettings?.buttonSignupStyleType,
        signUpTypeButton: loginSettings?.buttonLoginStyleType,
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
        padding: EdgeInsets.zero,
      ),
      callHangup: TextButton.styleFrom(
        foregroundColor: colors.onError,
        backgroundColor: colors.error,
        disabledForegroundColor: colors.onError.withOpacity(0.38),
        padding: EdgeInsets.zero,
      ),
      callTransfer: TextButton.styleFrom(
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        disabledForegroundColor: colors.secondary.withOpacity(0.38),
        padding: EdgeInsets.zero,
      ),
      callAction: TextButton.styleFrom(
        foregroundColor: colors.surface,
        backgroundColor: colors.surface.withOpacity(0.3),
        padding: EdgeInsets.zero,
      ),
      callActiveAction: TextButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
        padding: EdgeInsets.zero,
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

  TextSelectionThemeData textSelectionThemeData(
    ColorScheme colors,
    TextSelectionWidgetConfig? selection,
  ) {
    return TextSelectionThemeData(
        cursorColor: selection?.cursorColor,
        selectionColor: selection?.selectionColor,
        selectionHandleColor: selection?.selectionHandleColor);
  }

  InputDecorationTheme inputDecorationTheme(
    ColorScheme colors,
    TextFormFieldWidgetConfig? primary,
  ) {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      filled: true,
      fillColor: colors.background,
      labelStyle: TextStyle(color: primary?.labelColor),
      border: MaterialStateOutlineInputBorder.resolveWith((states) {
        final Color borderColor;
        final bool isError = states.contains(MaterialState.error);
        if (states.contains(MaterialState.disabled)) {
          borderColor = isError
              ? primary?.border?.disabled?.errorColor ?? colors.error.withOpacity(0.25)
              : primary?.border?.disabled?.typicalColor ?? colors.onBackground.withOpacity(0.25);
        } else if (states.contains(MaterialState.focused)) {
          borderColor = isError
              ? primary?.border?.focused?.errorColor ?? colors.error
              : primary?.border?.focused?.typicalColor ?? colors.primary;
        } else {
          borderColor = isError
              ? primary?.border?.any?.errorColor ?? colors.error.withOpacity(0.5)
              : primary?.border?.any?.typicalColor ?? colors.onBackground.withOpacity(0.5);
        }
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        );
      }),
    );
  }

  AppBarTheme appBarTheme(
    ColorScheme colors,
    ExtTabBarWidgetConfig? extTabBar,
  ) {
    return AppBarTheme(
      backgroundColor: extTabBar?.backgroundColor,
      foregroundColor: extTabBar?.foregroundColor,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,
      centerTitle: true,
    );
  }

  TabBarTheme tabBarTheme(
    ColorScheme colors,
    ExtTabBarWidgetConfig? extTabBar,
  ) {
    return TabBarTheme(
      unselectedLabelColor: extTabBar?.unSelectedItemColor ?? colors.onSurface,
      dividerColor: Colors.transparent,
      labelColor: colors.onPrimary,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(
    ColorScheme colors,
    BottomNavigationBarWidgetConfig? bottomNavigationBar,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: bottomNavigationBar?.backgroundColor ?? colors.surface,
      unselectedItemColor: bottomNavigationBar?.unSelectedItemColor,
      selectedItemColor: bottomNavigationBar?.selectedItemColor,
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
    final themeWidgetConfig = _themeWidgetConfig(brightness);
    final themePageConfig = _themePageConfig(brightness);

    return ThemeData.from(
      colorScheme: colorScheme,
      textTheme: textTheme(brightness),
      useMaterial3: true,
    ).copyWith(
      textSelectionTheme: textSelectionThemeData(
        colorScheme,
        themeWidgetConfig?.text?.selection,
      ),
      // GENERAL CONFIGURATIONValueNotifier
      inputDecorationTheme: inputDecorationTheme(
        colorScheme,
        themeWidgetConfig?.input?.primary,
      ),
      extensions: [
        // PAGES
        loginPageStyles(
          themePageConfig?.login?.modeSelect,
        ),
        // WIDGETS
        inputDecorations(colorScheme),
        elevatedButtonStyles(
          colorScheme,
          themeWidgetConfig?.button?.primaryElevatedButton,
        ),
        outlinedButtonStyles(colorScheme),
        textButtonStyles(colorScheme),
        gradients(colorScheme),
        logoAssets(
          primaryOnboardin: settings.primaryOnboardingLogo,
          secondaryOnboardin: settings.secondaryOnboardingLogo,
        ),
        groupTitleListStyles(
          themeWidgetConfig?.group?.groupTitleListTile,
        ),
        onboardingPictureLogoStyles(
          colorScheme,
          themeWidgetConfig?.picture?.onboardingPictureLogo,
        )
      ],
      // COLOR
      primaryColorLight: colorScheme.secondaryContainer,
      primaryColorDark: colorScheme.onSecondaryContainer,
      unselectedWidgetColor: colorScheme.onSurface,
      indicatorColor: colorScheme.primary,
      // TYPOGRAPHY & ICONOGRAPHY
      // COMPONENT THEMES
      appBarTheme: appBarTheme(
        colorScheme,
        themeWidgetConfig?.bar?.extTabBar,
      ),

      tabBarTheme: tabBarTheme(
        colorScheme,
        themeWidgetConfig?.bar?.extTabBar,
      ),
      bottomNavigationBarTheme: bottomNavigationBarTheme(
        colorScheme,
        themeWidgetConfig?.bar?.bottomNavigationBar,
      ),
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
    // ignore: unused_local_variable
    final themeWidgetConfig = _themeWidgetConfig(brightness);
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
