import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/keypad/widgets/actionpad.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/features/login/widgets/onboarding_logo.dart';
import 'package:webtrit_phone/features/login/widgets/onboarding_picture_logo.dart';
import 'package:webtrit_phone/features/settings/features/about/view/about_screen.dart';
import 'package:webtrit_phone/features/settings/widgets/group_title_list_tile.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'styles/styles.dart';

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
      primaryFixed: colorSchemeOverride?.primaryFixed,
      primaryFixedDim: colorSchemeOverride?.primaryFixedDim,
      onPrimaryFixed: colorSchemeOverride?.onPrimaryFixed,
      onPrimaryFixedVariant: colorSchemeOverride?.onPrimaryFixedVariant,
      secondary: colorSchemeOverride?.secondary,
      onSecondary: colorSchemeOverride?.onSecondary,
      secondaryContainer: colorSchemeOverride?.secondaryContainer,
      secondaryFixed: colorSchemeOverride?.secondaryFixed,
      secondaryFixedDim: colorSchemeOverride?.secondaryFixedDim,
      onSecondaryFixed: colorSchemeOverride?.onSecondaryFixed,
      onSecondaryFixedVariant: colorSchemeOverride?.onSecondaryFixedVariant,
      tertiary: colorSchemeOverride?.tertiary,
      onTertiary: colorSchemeOverride?.onTertiary,
      tertiaryContainer: colorSchemeOverride?.tertiaryContainer,
      onTertiaryContainer: colorSchemeOverride?.onTertiaryContainer,
      tertiaryFixed: colorSchemeOverride?.tertiaryFixed,
      tertiaryFixedDim: colorSchemeOverride?.tertiaryFixedDim,
      onTertiaryFixed: colorSchemeOverride?.onTertiaryFixed,
      onTertiaryFixedVariant: colorSchemeOverride?.onTertiaryFixedVariant,
      error: colorSchemeOverride?.error,
      onError: colorSchemeOverride?.onError,
      errorContainer: colorSchemeOverride?.errorContainer,
      onErrorContainer: colorSchemeOverride?.onErrorContainer,
      outline: colorSchemeOverride?.outline,
      outlineVariant: colorSchemeOverride?.outlineVariant,
      surface: colorSchemeOverride?.surface,
      onSurface: colorSchemeOverride?.onSurface,
      surfaceDim: colorSchemeOverride?.surfaceDim,
      surfaceBright: colorSchemeOverride?.surfaceBright,
      surfaceContainerLowest: colorSchemeOverride?.surfaceContainerLowest,
      surfaceContainerLow: colorSchemeOverride?.surfaceContainerLow,
      surfaceContainer: colorSchemeOverride?.surfaceContainer,
      surfaceContainerHigh: colorSchemeOverride?.surfaceContainerHigh,
      surfaceContainerHighest: colorSchemeOverride?.surfaceContainerHighest,
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
    final textColor = groupTitleListTile?.textColor;
    final backgroundColor = groupTitleListTile?.backgroundColor;

    final textStyle = TextStyle(
      color: textColor,
    );

    return GroupTitleListStyles(
      primary: GroutTitleListStyle(
        textStyle: textStyle,
        background: backgroundColor,
      ),
    );
  }

  OnboardingPictureLogoStyles onboardingPictureLogoStyles(
    ColorScheme colors,
    ThemeSvgAsset? picture,
    LogoWidgetConfig? onboardingPictureLogo,
  ) {
    final textStyleColor = onboardingPictureLogo?.labelColor ?? colors.onPrimary;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingPictureLogoStyles(
      primary: OnboardingPictureLogoStyle(
        picture: picture,
        scale: onboardingPictureLogo?.scale,
        textStyle: textStyle,
      ),
    );
  }

  OnboardingLogoStyles onboardingLogoStyles(
    ColorScheme colors,
    ThemeSvgAsset? picture,
    LogoWidgetConfig? onboardingLogoWidgetConfig,
  ) {
    final textStyleColor = onboardingLogoWidgetConfig?.labelColor;

    final textStyle = TextStyle(color: textStyleColor);

    return OnboardingLogoStyles(
      primary: OnboardingLogoStyle(
        picture: picture,
        scale: onboardingLogoWidgetConfig?.scale,
        textStyle: textStyle,
      ),
    );
  }

  AboutScreenStyles aboutScreenStyles(
    AboutPageConfig? aboutPageConfig,
  ) {
    return AboutScreenStyles(
      primary: AboutScreenStyle(
        picture: aboutPageConfig?.picture,
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
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      primaryOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        disabledForegroundColor: colors.onPrimary.withOpacity(0.5),
        disabledBackgroundColor: colors.primary.withOpacity(0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutralOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
        disabledForegroundColor: colors.onSurface.withOpacity(0.5),
        disabledBackgroundColor: colors.surface.withOpacity(0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
    );
  }

  OutlinedButtonStyles outlinedButtonStyles(ColorScheme colors) {
    return OutlinedButtonStyles(
      neutral: OutlinedButton.styleFrom(
        foregroundColor: colors.onSurface,
        side: BorderSide(
          color: colors.onSurface.withOpacity(0.2),
        ),
      ),
    );
  }

  LoginModeSelectScreenStyles loginPageStyles(LoginModeSelectPageConfig? loginSettings) {
    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        signInTypeButton: loginSettings?.buttonSignupStyleType,
        signUpTypeButton: loginSettings?.buttonLoginStyleType,
      ),
    );
  }

  TextButtonStyles _textButtonStyles(ColorScheme colors) {
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
      selectionHandleColor: selection?.selectionHandleColor,
    );
  }

  LinkifyStyles linkifyStyles(
    ColorScheme colors,
    LinkifyWidgetConfig? linkifyWidgetConfig,
  ) {
    final regularTextColor = linkifyWidgetConfig?.styleColor;
    final linkifyTextColor = linkifyWidgetConfig?.linkifyStyleColor ?? colors.primary;

    final regularTextStyle = TextStyle(color: regularTextColor);
    final linkifyTextStyle = TextStyle(color: linkifyTextColor);

    return LinkifyStyles(
      primary: LinkifyStyle(
        style: regularTextStyle,
        linkStyle: linkifyTextStyle,
      ),
    );
  }

  ActionpadStyles actionpadStyles(
    ColorScheme colors,
    ActionPadWidgetConfig? config,
  ) {
    const disabledOpacity = 0.4;

    final callStartForegroundColor = config?.callStart?.foregroundColor ?? colors.onTertiary;
    final callStartBackgroundColor = config?.callStart?.backgroundColor ?? colors.tertiary;
    final callStartIconColor = config?.callStart?.iconColor ?? colors.surface;
    final callStartDisabledIconColor =
        config?.callStart?.disabledIconColor ?? colors.surface.withOpacity(disabledOpacity);

    final callTransferForegroundColor = config?.callTransfer?.foregroundColor ?? colors.onSecondary;
    final callTransferBackgroundColor = config?.callTransfer?.backgroundColor ?? colors.secondary;
    final callTransferIconColor = config?.callTransfer?.iconColor ?? colors.surface;
    final callTransferDisabledIconColor =
        config?.callTransfer?.disabledIconColor ?? colors.surface.withOpacity(disabledOpacity);

    final backspacePressedStyleForegroundColor = config?.backspacePressed?.foregroundColor ?? colors.onSecondary;
    final backspacePressedStyleBackgroundColor = config?.backspacePressed?.backgroundColor;
    final backspacePressedStyleIconColor = config?.backspacePressed?.iconColor ?? colors.onSurface;
    final backspacePressedStyleDisabledIconColor = config?.backspacePressed?.disabledIconColor ?? colors.surface;

    final callStartStyle = TextButton.styleFrom(
      foregroundColor: callStartForegroundColor,
      backgroundColor: callStartBackgroundColor,
      disabledForegroundColor: colors.onTertiary.withOpacity(disabledOpacity),
      iconColor: callStartIconColor,
      disabledIconColor: callStartDisabledIconColor,
      padding: EdgeInsets.zero,
    );

    final callTransferStyle = TextButton.styleFrom(
      foregroundColor: callTransferForegroundColor,
      backgroundColor: callTransferBackgroundColor,
      disabledForegroundColor: colors.secondary.withOpacity(disabledOpacity),
      iconColor: callTransferIconColor,
      disabledIconColor: callTransferDisabledIconColor,
      padding: EdgeInsets.zero,
    );

    final backspacePressedStyle = TextButton.styleFrom(
      foregroundColor: backspacePressedStyleForegroundColor,
      backgroundColor: backspacePressedStyleBackgroundColor,
      iconColor: backspacePressedStyleIconColor,
      disabledIconColor: backspacePressedStyleDisabledIconColor,
    );

    return ActionpadStyles(
      primary: ActionpadStyle(
        callStart: callStartStyle,
        callTransfer: callTransferStyle,
        backspacePressed: backspacePressedStyle,
      ),
    );
  }

  CallActionsStyles callActionsStyles(
    ColorScheme colors,
    CallActionsWidgetConfig? config,
  ) {
    const disabledOpacity = 0.4;

    final inactiveIconColor = colors.surface;
    final activeIconColor = colors.onSecondaryFixedVariant;

    final activeActionBackgroundColor = colors.surface;
    final actionBackgroundColor = colors.surface.withOpacity(disabledOpacity);

    // Common color group
    final callStartBackgroundColor = config?.callStartBackgroundColor ?? colors.tertiary;
    final hangupBackgroundColor = config?.hangupBackgroundColor ?? colors.error;
    final transferBackgroundColor = config?.transferBackgroundColor ?? actionBackgroundColor;

    // Camera color group
    final cameraBackgroundColor = config?.cameraBackgroundColor ?? actionBackgroundColor;
    final cameraActiveBackgroundColor = config?.cameraActiveBackgroundColor ?? activeActionBackgroundColor;

    // Muted color group
    final mutedBackgroundColor = config?.mutedBackgroundColor ?? actionBackgroundColor;
    final mutedActiveBackgroundColor = config?.mutedActiveBackgroundColor ?? activeActionBackgroundColor;

    // Speaker color group
    final speakerBackgroundColor = config?.speakerBackgroundColor ?? actionBackgroundColor;
    final speakerActiveBackgroundColor = config?.speakerActiveBackgroundColor ?? activeActionBackgroundColor;

    // Held color group
    final heldBackgroundColor = config?.heldBackgroundColor ?? actionBackgroundColor;
    final heldActiveBackgroundColor = config?.heldActiveBackgroundColor ?? activeActionBackgroundColor;

    // Swap color group
    final swapBackgroundColor = config?.swapBackgroundColor ?? actionBackgroundColor;

    // Key color group
    final keyBackgroundColor = config?.keyBackgroundColor ?? actionBackgroundColor;
    final keypadBackgroundColor = config?.keypadBackgroundColor ?? actionBackgroundColor;
    final keypadActiveBackgroundColor = config?.keypadActiveBackgroundColor ?? activeActionBackgroundColor;

    // Start call style group
    final callStart = TextButton.styleFrom(
      foregroundColor: colors.onTertiary,
      backgroundColor: callStartBackgroundColor,
      disabledForegroundColor: colors.onTertiary.withOpacity(disabledOpacity),
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Hangup style group
    final callHangup = TextButton.styleFrom(
      foregroundColor: colors.onError,
      backgroundColor: hangupBackgroundColor,
      disabledForegroundColor: colors.onError.withOpacity(disabledOpacity),
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Transfer style group
    final callTransfer = TextButton.styleFrom(
      foregroundColor: colors.onSecondary,
      backgroundColor: transferBackgroundColor,
      disabledForegroundColor: colors.secondary.withOpacity(disabledOpacity),
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Common style group
    final callAction = TextButton.styleFrom(
      foregroundColor: colors.surface,
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );
    final callActiveAction = TextButton.styleFrom(
      foregroundColor: colors.onSurface,
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Camera style group
    final cameraStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(cameraBackgroundColor),
    );
    final cameraActiveStyle = callActiveAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(cameraActiveBackgroundColor),
      iconColor: WidgetStatePropertyAll(activeIconColor),
    );

    // Muted style group
    final mutedStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(mutedBackgroundColor),
    );
    final mutedActiveStyle = callActiveAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(mutedActiveBackgroundColor),
      iconColor: WidgetStatePropertyAll(activeIconColor),
    );

    // Speaker style group
    final speakerStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(speakerBackgroundColor),
    );
    final speakerActiveStyle = callActiveAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(speakerActiveBackgroundColor),
      iconColor: WidgetStatePropertyAll(activeIconColor),
    );

    // Held style group
    final heldStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(heldBackgroundColor),
    );
    final heldActiveStyle = callActiveAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(heldActiveBackgroundColor),
      iconColor: WidgetStatePropertyAll(activeIconColor),
    );

    // Swap style group
    final swapStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(swapBackgroundColor),
    );

    // Key style group
    final keyStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(keyBackgroundColor),
    );
    final keypadStyle = callAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(keypadBackgroundColor),
    );
    final keypadActiveStyle = callActiveAction.copyWith(
      backgroundColor: WidgetStatePropertyAll(keypadActiveBackgroundColor),
      iconColor: WidgetStatePropertyAll(activeIconColor),
    );

    return CallActionsStyles(
      primary: CallActionsStyle(
        callStart: callStart,
        hangup: callHangup,
        transfer: callTransfer,
        camera: cameraStyle,
        cameraActive: cameraActiveStyle,
        muted: mutedStyle,
        mutedActive: mutedActiveStyle,
        speaker: speakerStyle,
        speakerActive: speakerActiveStyle,
        held: heldStyle,
        heldActive: heldActiveStyle,
        swap: swapStyle,
        key: keyStyle,
        keypad: keypadStyle,
        keypadActive: keypadActiveStyle,
      ),
    );
  }

  AppIconStyles appIconStyle(ColorScheme colors, AppIconWidgetConfig? appIcon) {
    return AppIconStyles(
      primary: AppIconStyle(
        color: appIcon?.color ?? colors.primary,
      ),
    );
  }

  ConfirmDialogStyles confirmDialogStyles(
    ColorScheme colors,
    TextButtonStyles styles,
    ConfirmDialogWidgetConfig? dialogConfig,
  ) {
    final activeButtonStyle1ForegroundColor = WidgetStatePropertyAll(dialogConfig?.activeButtonColor1);
    final activeButtonStyle2ForegroundColor = WidgetStatePropertyAll(dialogConfig?.activeButtonColor2);
    final defaultButtonStyleForegroundColor = WidgetStatePropertyAll(dialogConfig?.defaultButtonColor);

    final activeButtonStyle1 = styles.neutral?.copyWith(foregroundColor: activeButtonStyle1ForegroundColor);
    final activeButtonStyle2 = styles.dangerous?.copyWith(foregroundColor: activeButtonStyle2ForegroundColor);
    final defaultButtonStyle = const ButtonStyle().copyWith(foregroundColor: defaultButtonStyleForegroundColor);

    return ConfirmDialogStyles(
      primary: ConfirmDialogStyle(
        activeButtonStyle1: activeButtonStyle1,
        activeButtonStyle2: activeButtonStyle2,
        defaultButtonStyle: defaultButtonStyle,
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme(
    ColorScheme colors,
    TextFormFieldWidgetConfig? primary,
  ) {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      filled: true,
      // TODO(Serdun): add fill color from widget settings model
      fillColor: colors.surfaceBright,
      labelStyle: TextStyle(color: primary?.labelColor),
      border: MaterialStateOutlineInputBorder.resolveWith((states) {
        final Color borderColor;
        final bool isError = states.contains(WidgetState.error);
        if (states.contains(WidgetState.disabled)) {
          borderColor = isError
              ? primary?.border?.disabled?.errorColor ?? colors.error.withOpacity(0.25)
              : primary?.border?.disabled?.typicalColor ?? colors.onSurface.withOpacity(0.25);
        } else if (states.contains(WidgetState.focused)) {
          borderColor = isError
              ? primary?.border?.focused?.errorColor ?? colors.error
              : primary?.border?.focused?.typicalColor ?? colors.primary;
        } else {
          borderColor = isError
              ? primary?.border?.any?.errorColor ?? colors.error.withOpacity(0.5)
              : primary?.border?.any?.typicalColor ?? colors.onSurface.withOpacity(0.5);
        }
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        );
      }),
    );
  }

  CallStatusStyles callStatusStyles(
    ColorScheme colors,
    CallStatusesWidgetConfig? callStatuses,
  ) {
    final connectivityNone = callStatuses?.connectivityNone ?? colors.error;
    final connectError = callStatuses?.connectError ?? colors.error;
    final appUnregistered = callStatuses?.appUnregistered ?? colors.onSurfaceVariant;
    final connectIssue = callStatuses?.connectIssue ?? colors.error;
    final inProgress = callStatuses?.inProgress ?? colors.secondary;
    final ready = callStatuses?.ready ?? colors.tertiary;

    return CallStatusStyles(
      primary: CallStatusStyle(
        connectivityNone: connectivityNone,
        connectError: connectError,
        appUnregistered: appUnregistered,
        connectIssue: connectIssue,
        inProgress: inProgress,
        ready: ready,
      ),
    );
  }

  RegisteredStatusStyles registeredStatusStyle(
    ColorScheme colors,
    RegistrationStatusesWidgetConfig? registrationStatuses,
  ) {
    final registered = registrationStatuses?.online ?? colors.error;
    final unregisters = registrationStatuses?.offline ?? colors.error;

    return RegisteredStatusStyles(
      primary: RegisteredStatusStyle(
        registered: registered,
        unregistered: unregisters,
      ),
    );
  }

  SnackBarStyles snackBarStyles(
    ColorScheme colors,
    SnackBarWidgetConfig? snackBarConfig,
  ) {
    final successBackgroundColor = snackBarConfig?.successBackgroundColor ?? colors.primary;
    final errorBackgroundColor = snackBarConfig?.errorBackgroundColor ?? colors.error;
    final infoBackgroundColor = snackBarConfig?.infoBackgroundColor ?? colors.secondary;
    final warningBackgroundColor = snackBarConfig?.warningBackgroundColor ?? colors.tertiary;

    return SnackBarStyles(
      primary: SnackBarStyle(
        successBackgroundColor: successBackgroundColor,
        errorBackgroundColor: errorBackgroundColor,
        infoBackgroundColor: infoBackgroundColor,
        warningBackgroundColor: warningBackgroundColor,
      ),
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

    final textButtonStyles = _textButtonStyles(colorScheme);

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
        appIconStyle(
          colorScheme,
          themeWidgetConfig?.picture?.appIcon,
        ),
        confirmDialogStyles(
          colorScheme,
          textButtonStyles,
          themeWidgetConfig?.dialog?.confirmDialog,
        ),
        linkifyStyles(
          colorScheme,
          themeWidgetConfig?.text?.linkify,
        ),
        callActionsStyles(
          colorScheme,
          themeWidgetConfig?.group?.callActions,
        ),
        callStatusStyles(
          colorScheme,
          themeWidgetConfig?.statuses.callStatuses,
        ),
        registeredStatusStyle(
          colorScheme,
          themeWidgetConfig?.statuses.registrationStatuses,
        ),
        snackBarStyles(
          colorScheme,
          themeWidgetConfig?.dialog?.snackBar,
        ),
        actionpadStyles(
          colorScheme,
          themeWidgetConfig?.actionPad,
        ),
        inputDecorations(colorScheme),
        elevatedButtonStyles(
          colorScheme,
          themeWidgetConfig?.button?.primaryElevatedButton,
        ),
        outlinedButtonStyles(colorScheme),
        textButtonStyles,
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
          settings.primaryOnboardingLogo,
          themeWidgetConfig?.picture?.onboardingPictureLogo,
        ),
        onboardingLogoStyles(
          colorScheme,
          settings.secondaryOnboardingLogo,
          themeWidgetConfig?.picture?.onboardingLogo,
        ),
        aboutScreenStyles(themePageConfig?.about)
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
      scaffoldBackgroundColor: colorScheme.surfaceBright,
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
