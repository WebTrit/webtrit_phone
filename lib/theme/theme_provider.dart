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
      primaryFixed: colorSchemeOverride?.primaryFixed?.toColor(),
      primaryFixedDim: colorSchemeOverride?.primaryFixedDim?.toColor(),
      onPrimaryFixed: colorSchemeOverride?.onPrimaryFixed?.toColor(),
      onPrimaryFixedVariant: colorSchemeOverride?.onPrimaryFixedVariant?.toColor(),
      secondary: colorSchemeOverride?.secondary?.toColor(),
      onSecondary: colorSchemeOverride?.onSecondary?.toColor(),
      secondaryContainer: colorSchemeOverride?.secondaryContainer?.toColor(),
      secondaryFixed: colorSchemeOverride?.secondaryFixed?.toColor(),
      secondaryFixedDim: colorSchemeOverride?.secondaryFixedDim?.toColor(),
      onSecondaryFixed: colorSchemeOverride?.onSecondaryFixed?.toColor(),
      onSecondaryFixedVariant: colorSchemeOverride?.onSecondaryFixedVariant?.toColor(),
      tertiary: colorSchemeOverride?.tertiary?.toColor(),
      onTertiary: colorSchemeOverride?.onTertiary?.toColor(),
      tertiaryContainer: colorSchemeOverride?.tertiaryContainer?.toColor(),
      onTertiaryContainer: colorSchemeOverride?.onTertiaryContainer?.toColor(),
      tertiaryFixed: colorSchemeOverride?.tertiaryFixed?.toColor(),
      tertiaryFixedDim: colorSchemeOverride?.tertiaryFixedDim?.toColor(),
      onTertiaryFixed: colorSchemeOverride?.onTertiaryFixed?.toColor(),
      onTertiaryFixedVariant: colorSchemeOverride?.onTertiaryFixedVariant?.toColor(),
      error: colorSchemeOverride?.error?.toColor(),
      onError: colorSchemeOverride?.onError?.toColor(),
      errorContainer: colorSchemeOverride?.errorContainer?.toColor(),
      onErrorContainer: colorSchemeOverride?.onErrorContainer?.toColor(),
      outline: colorSchemeOverride?.outline?.toColor(),
      outlineVariant: colorSchemeOverride?.outlineVariant?.toColor(),
      surface: colorSchemeOverride?.surface?.toColor(),
      onSurface: colorSchemeOverride?.onSurface?.toColor(),
      surfaceDim: colorSchemeOverride?.surfaceDim?.toColor(),
      surfaceBright: colorSchemeOverride?.surfaceBright?.toColor(),
      surfaceContainerLowest: colorSchemeOverride?.surfaceContainerLowest?.toColor(),
      surfaceContainerLow: colorSchemeOverride?.surfaceContainerLow?.toColor(),
      surfaceContainer: colorSchemeOverride?.surfaceContainer?.toColor(),
      surfaceContainerHigh: colorSchemeOverride?.surfaceContainerHigh?.toColor(),
      surfaceContainerHighest: colorSchemeOverride?.surfaceContainerHighest?.toColor(),
      onSurfaceVariant: colorSchemeOverride?.onSurfaceVariant?.toColor(),
      inverseSurface: colorSchemeOverride?.inverseSurface?.toColor(),
      onInverseSurface: colorSchemeOverride?.onInverseSurface?.toColor(),
      inversePrimary: colorSchemeOverride?.inversePrimary?.toColor(),
      shadow: colorSchemeOverride?.shadow?.toColor(),
      scrim: colorSchemeOverride?.scrim?.toColor(),
      surfaceTint: colorSchemeOverride?.surfaceTint?.toColor(),
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
    final textColor = groupTitleListTile?.textColor?.toColor();
    final backgroundColor = groupTitleListTile?.backgroundColor?.toColor();

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
    final textStyleColor = onboardingPictureLogo?.labelColor?.toColor() ?? colors.onPrimary;

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
    final textStyleColor = onboardingLogoWidgetConfig?.labelColor?.toColor();

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
        picture: aboutPageConfig?.picture != null ? ThemeSvgAsset.fromJson(aboutPageConfig!.picture) : null,
      ),
    );
  }

  ElevatedButtonStyles elevatedButtonStyles(
    ColorScheme colors,
    ElevatedButtonWidgetConfig? elevatedButtonAddons,
  ) {
    final foregroundColor = elevatedButtonAddons?.foregroundColor?.toColor() ?? colors.onPrimary;
    final backgroundColor = elevatedButtonAddons?.backgroundColor?.toColor() ?? colors.primary;
    final textStyleColor = elevatedButtonAddons?.textColor?.toColor();

    return ElevatedButtonStyles(
      primary: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        textStyle: TextStyle(color: textStyleColor),
        disabledForegroundColor: colors.onPrimaryContainer.withValues(alpha: 0.38),
        disabledBackgroundColor: colors.onPrimaryContainer.withValues(alpha: 0.12),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutral: ElevatedButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      primaryOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        disabledForegroundColor: colors.onPrimary.withValues(alpha: 0.5),
        disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      neutralOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.5),
        disabledBackgroundColor: colors.surface.withValues(alpha: 0.5),
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
    );
  }

  OutlinedButtonStyles outlinedButtonStyles(ColorScheme colors) {
    return OutlinedButtonStyles(
      neutral: OutlinedButton.styleFrom(
        foregroundColor: colors.onSurface,
        side: BorderSide(
          color: colors.onSurface.withValues(alpha: 0.2),
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
        disabledForegroundColor: colors.onTertiary.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callHangup: TextButton.styleFrom(
        foregroundColor: colors.onError,
        backgroundColor: colors.error,
        disabledForegroundColor: colors.onError.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callTransfer: TextButton.styleFrom(
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        disabledForegroundColor: colors.secondary.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callAction: TextButton.styleFrom(
        foregroundColor: colors.surface,
        backgroundColor: colors.surface.withValues(alpha: 0.3),
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
    final customColors = settings.primaryGradientColors.map((it) => it.color.toColor()).toList();

    return Gradients(
      tab: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: customColors,
      ),
    );
  }

  TextSelectionThemeData textSelectionThemeData(
    ColorScheme colors,
    TextSelectionWidgetConfig? selection,
  ) {
    final cursorColor = selection?.cursorColor?.toColor();
    final selectionColor = selection?.selectionColor?.toColor();
    final selectionHandleColor = selection?.selectionHandleColor?.toColor();

    return TextSelectionThemeData(
      cursorColor: cursorColor,
      selectionColor: selectionColor,
      selectionHandleColor: selectionHandleColor,
    );
  }

  LinkifyStyles linkifyStyles(
    ColorScheme colors,
    LinkifyWidgetConfig? linkifyWidgetConfig,
  ) {
    final regularTextColor = linkifyWidgetConfig?.styleColor?.toColor();
    final linkifyTextColor = linkifyWidgetConfig?.linkifyStyleColor?.toColor() ?? colors.primary;

    final regularTextStyle = TextStyle(color: regularTextColor);
    final linkifyTextStyle = TextStyle(color: linkifyTextColor);

    return LinkifyStyles(
      primary: LinkifyStyle(
        style: regularTextStyle,
        linkStyle: linkifyTextStyle,
      ),
    );
  }

  ActionpadStyles actionPadStyles(
    ColorScheme colors,
    ActionPadWidgetConfig? config,
  ) {
    const disabledColorOpacity = 0.4;

    final defaultCallDisabledIconColor = colors.surface.withValues(alpha: disabledColorOpacity);

    final callStartForegroundColor = config?.callStart?.foregroundColor?.toColor() ?? colors.onTertiary;
    final callStartBackgroundColor = config?.callStart?.backgroundColor?.toColor() ?? colors.tertiary;
    final callStartIconColor = config?.callStart?.iconColor?.toColor() ?? colors.surface;
    final callStartDisabledIconColor = config?.callStart?.disabledIconColor?.toColor() ?? defaultCallDisabledIconColor;

    final callTransferForegroundColor = config?.callTransfer?.foregroundColor?.toColor() ?? colors.onSecondary;
    final callTransferBackgroundColor = config?.callTransfer?.backgroundColor?.toColor() ?? colors.secondary;
    final callTransferIconColor = config?.callTransfer?.iconColor?.toColor() ?? colors.surface;
    final callTransferDisabledIconColor =
        config?.callTransfer?.disabledIconColor?.toColor() ?? defaultCallDisabledIconColor;

    final backspacePressedStyleForegroundColor =
        config?.backspacePressed?.foregroundColor?.toColor() ?? colors.onSecondary;
    final backspacePressedStyleBackgroundColor = config?.backspacePressed?.backgroundColor?.toColor();
    final backspacePressedStyleIconColor = config?.backspacePressed?.iconColor?.toColor() ?? colors.onSurface;
    final backspacePressedStyleDisabledIconColor =
        config?.backspacePressed?.disabledIconColor?.toColor() ?? colors.surface;

    final callStartStyle = TextButton.styleFrom(
      foregroundColor: callStartForegroundColor,
      backgroundColor: callStartBackgroundColor,
      disabledForegroundColor: colors.onTertiary.withValues(alpha: disabledColorOpacity),
      iconColor: callStartIconColor,
      disabledIconColor: callStartDisabledIconColor,
      padding: EdgeInsets.zero,
    );

    final callTransferStyle = TextButton.styleFrom(
      foregroundColor: callTransferForegroundColor,
      backgroundColor: callTransferBackgroundColor,
      disabledForegroundColor: colors.secondary.withValues(alpha: disabledColorOpacity),
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
    const disabledColorOpacity = 0.4;

    final inactiveIconColor = colors.surface;
    final activeIconColor = colors.onSecondaryFixedVariant;

    final activeActionBackgroundColor = colors.surface;
    final actionBackgroundColor = colors.surface.withValues(alpha: disabledColorOpacity);

    // Common color group
    final callStartBackgroundColor = config?.callStartBackgroundColor?.toColor() ?? colors.tertiary;
    final hangupBackgroundColor = config?.hangupBackgroundColor?.toColor() ?? colors.error;
    final transferBackgroundColor = config?.transferBackgroundColor?.toColor() ?? actionBackgroundColor;

    // Camera color group
    final cameraBackgroundColor = config?.cameraBackgroundColor?.toColor() ?? actionBackgroundColor;
    final cameraActiveBackgroundColor = config?.cameraActiveBackgroundColor?.toColor() ?? activeActionBackgroundColor;

    // Muted color group
    final mutedBackgroundColor = config?.mutedBackgroundColor?.toColor() ?? actionBackgroundColor;
    final mutedActiveBackgroundColor = config?.mutedActiveBackgroundColor?.toColor() ?? activeActionBackgroundColor;

    // Speaker color group
    final speakerBackgroundColor = config?.speakerBackgroundColor?.toColor() ?? actionBackgroundColor;
    final speakerActiveBackgroundColor = config?.speakerActiveBackgroundColor?.toColor() ?? activeActionBackgroundColor;

    // Held color group
    final heldBackgroundColor = config?.heldBackgroundColor?.toColor() ?? actionBackgroundColor;
    final heldActiveBackgroundColor = config?.heldActiveBackgroundColor?.toColor() ?? activeActionBackgroundColor;

    // Swap color group
    final swapBackgroundColor = config?.swapBackgroundColor?.toColor() ?? actionBackgroundColor;

    // Key color group
    final keyBackgroundColor = config?.keyBackgroundColor?.toColor() ?? actionBackgroundColor;
    final keypadBackgroundColor = config?.keypadBackgroundColor?.toColor() ?? actionBackgroundColor;
    final keypadActiveBackgroundColor = config?.keypadActiveBackgroundColor?.toColor() ?? activeActionBackgroundColor;

    // Start call style group
    final callStart = TextButton.styleFrom(
      foregroundColor: colors.onTertiary,
      backgroundColor: callStartBackgroundColor,
      disabledForegroundColor: colors.onTertiary.withValues(alpha: disabledColorOpacity),
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Hangup style group
    final callHangup = TextButton.styleFrom(
      foregroundColor: colors.onError,
      backgroundColor: hangupBackgroundColor,
      disabledForegroundColor: colors.onError.withValues(alpha: disabledColorOpacity),
      iconColor: inactiveIconColor,
      padding: EdgeInsets.zero,
    );

    // Transfer style group
    final callTransfer = TextButton.styleFrom(
      foregroundColor: colors.onSecondary,
      backgroundColor: transferBackgroundColor,
      disabledForegroundColor: colors.secondary.withValues(alpha: disabledColorOpacity),
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
    final appIconColor = appIcon?.color?.toColor() ?? colors.primary;

    return AppIconStyles(
      primary: AppIconStyle(
        color: appIconColor,
      ),
    );
  }

  ConfirmDialogStyles confirmDialogStyles(
    ColorScheme colors,
    TextButtonStyles styles,
    ConfirmDialogWidgetConfig? dialogConfig,
  ) {
    final activeButtonStyle1ForegroundColor = WidgetStatePropertyAll(dialogConfig?.activeButtonColor1?.toColor());
    final activeButtonStyle2ForegroundColor = WidgetStatePropertyAll(dialogConfig?.activeButtonColor2?.toColor());
    final defaultButtonStyleForegroundColor = WidgetStatePropertyAll(dialogConfig?.defaultButtonColor?.toColor());

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
    final labelStyleColor = primary?.labelColor?.toColor();
    final disabledErrorBorderColor = primary?.border?.disabled?.errorColor?.toColor();
    final disabledPrimaryBorderColor = primary?.border?.disabled?.typicalColor?.toColor();
    final focusedErrorBorderColor = primary?.border?.focused?.errorColor?.toColor();
    final focusedPrimaryBorderColor = primary?.border?.focused?.typicalColor?.toColor();
    final anyErrorBorderColor = primary?.border?.any?.errorColor?.toColor();
    final anyPrimaryBorderColor = primary?.border?.any?.typicalColor?.toColor();

    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      filled: true,
      // TODO: add fill color from widget settings model
      fillColor: colors.surfaceBright,
      labelStyle: TextStyle(color: labelStyleColor),
      border: MaterialStateOutlineInputBorder.resolveWith((states) {
        final bool isError = states.contains(WidgetState.error);
        final Color borderColor;

        if (states.contains(WidgetState.disabled)) {
          borderColor = isError
              ? disabledErrorBorderColor ?? colors.error.withAlpha(64)
              : disabledPrimaryBorderColor ?? colors.onSurface.withAlpha(64);
        } else if (states.contains(WidgetState.focused)) {
          borderColor = isError ? focusedErrorBorderColor ?? colors.error : focusedPrimaryBorderColor ?? colors.primary;
        } else {
          borderColor = isError
              ? anyErrorBorderColor ?? colors.error.withAlpha(128)
              : anyPrimaryBorderColor ?? colors.onSurface.withAlpha(128);
        }

        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        );
      }),
    );
  }

  CallStatusStyles callStatusStyles(
    ColorScheme colors,
    CallStatusesWidgetConfig? callStatuses,
  ) {
    final connectivityNone = callStatuses?.connectivityNone.toColor() ?? colors.error;
    final connectError = callStatuses?.connectError.toColor() ?? colors.error;
    final appUnregistered = callStatuses?.appUnregistered.toColor() ?? colors.onSurfaceVariant;
    final connectIssue = callStatuses?.connectIssue.toColor() ?? colors.error;
    final inProgress = callStatuses?.inProgress.toColor() ?? colors.secondary;
    final ready = callStatuses?.ready.toColor() ?? colors.tertiary;

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
    final registered = registrationStatuses?.online.toColor() ?? colors.error;
    final unregisters = registrationStatuses?.offline.toColor() ?? colors.error;

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
    final successBackgroundColor = snackBarConfig?.successBackgroundColor.toColor() ?? colors.primary;
    final errorBackgroundColor = snackBarConfig?.errorBackgroundColor.toColor() ?? colors.error;
    final infoBackgroundColor = snackBarConfig?.infoBackgroundColor.toColor() ?? colors.secondary;
    final warningBackgroundColor = snackBarConfig?.warningBackgroundColor.toColor() ?? colors.tertiary;

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
    final backgroundColor = extTabBar?.backgroundColor?.toColor();
    final foregroundColor = extTabBar?.foregroundColor?.toColor();
    const surfaceTintColor = Colors.white;

    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: surfaceTintColor,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }

  TabBarTheme tabBarTheme(
    ColorScheme colors,
    ExtTabBarWidgetConfig? extTabBar,
  ) {
    final unselectedLabelColor = extTabBar?.unSelectedItemColor?.toColor() ?? colors.onSurface;
    const dividerColor = Colors.transparent;
    final labelColor = colors.onPrimary;

    return TabBarTheme(
      unselectedLabelColor: unselectedLabelColor,
      dividerColor: dividerColor,
      labelColor: labelColor,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(
    ColorScheme colors,
    BottomNavigationBarWidgetConfig? bottomNavigationBar,
  ) {
    final backgroundColor = bottomNavigationBar?.backgroundColor?.toColor();
    final unselectedItemColor = bottomNavigationBar?.unSelectedItemColor?.toColor();
    final selectedItemColor = bottomNavigationBar?.selectedItemColor?.toColor();

    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor ?? colors.surface,
      unselectedItemColor: unselectedItemColor,
      selectedItemColor: selectedItemColor,
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
        actionPadStyles(
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
          primaryOnboardin: ThemeSvgAsset.fromJson(settings.primaryOnboardingLogo),
          secondaryOnboardin: ThemeSvgAsset.fromJson(settings.secondaryOnboardingLogo),
        ),
        groupTitleListStyles(
          themeWidgetConfig?.group?.groupTitleListTile,
        ),
        onboardingPictureLogoStyles(
          colorScheme,
          ThemeSvgAsset.fromJson(settings.primaryOnboardingLogo),
          themeWidgetConfig?.picture?.onboardingPictureLogo,
        ),
        onboardingLogoStyles(
          colorScheme,
          ThemeSvgAsset.fromJson(settings.secondaryOnboardingLogo),
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
