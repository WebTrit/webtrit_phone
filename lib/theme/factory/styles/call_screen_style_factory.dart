import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../../styles/styles.dart';
import '../theme_style_factory.dart';

const double kDisabledOpacity = 0.40;

final _logger = Logger('CallScreenStyleFactory');

class CallScreenStyleFactory implements ThemeStyleFactory<CallScreenStyles> {
  CallScreenStyleFactory(this.colors, this.pageConfig, this.defaultFontFamily);

  final ColorScheme colors;
  final CallPageConfig? pageConfig;
  final String? defaultFontFamily;

  @override
  CallScreenStyles create() {
    final appBarCfg = pageConfig?.appBarStyle;
    final infoCfg = pageConfig?.callInfo;
    final backgroundStyle = pageConfig?.background?.toStyle();

    return CallScreenStyles(
      primary: CallScreenStyle(
        background: backgroundStyle,
        systemUiOverlayStyle: pageConfig?.systemUiOverlayStyle?.toSystemUiOverlayStyle(colors.brightness),
        appBar: _mapAppBarStyle(appBarCfg),
        callInfo: _mapCallInfoStyle(infoCfg),
        list: _mapCallListStyle(pageConfig?.callList),
        hint: _mapHintStyle(pageConfig?.actingOnHint),
        actions: _mapActionsFromPage(pageConfig?.actions),
      ),
    );
  }

  /// Call-list row colors. Theme JSON values win; the defaults are
  /// scheme-derived tints of [ColorScheme.surface] (the call-screen text
  /// color), keeping the focused row the brighter one.
  CallListStyle _mapCallListStyle(CallPageListConfig? cfg) {
    return CallListStyle(
      rowBackground: cfg?.rowBackgroundColor?.toColor() ?? colors.surface.withValues(alpha: 0.10),
      rowFocusedBackground: cfg?.rowFocusedBackgroundColor?.toColor() ?? colors.surface.withValues(alpha: 0.26),
      rowFocusedBorder: cfg?.rowFocusedBorderColor?.toColor() ?? colors.surface.withValues(alpha: 0.55),
      dotRinging: cfg?.dotRingingColor?.toColor() ?? colors.tertiary,
      dotOnCall: cfg?.dotOnCallColor?.toColor() ?? colors.tertiaryContainer,
      dotHeld: cfg?.dotHeldColor?.toColor() ?? colors.surface.withValues(alpha: 0.55),
    );
  }

  /// "Acting on" hint pill colors. Theme JSON values win; the defaults are a
  /// scrim tint for the pill and the tertiary accent for the affected names.
  FocusedActionHintStyle _mapHintStyle(CallPageHintConfig? cfg) {
    return FocusedActionHintStyle(
      background: cfg?.backgroundColor?.toColor() ?? colors.scrim.withValues(alpha: 0.25),
      affectedName: cfg?.affectedNameColor?.toColor() ?? colors.tertiary,
    );
  }

  AppBarStyle _mapAppBarStyle(AppBarConfig? cfg) {
    return AppBarStyle(
      backgroundColor: cfg?.backgroundColor?.toColor() ?? Colors.transparent,
      foregroundColor: cfg?.foregroundColor?.toColor() ?? colors.surface,
      primary: cfg?.primary ?? false,
      showBackButton: cfg?.showBackButton ?? true,
    );
  }

  CallInfoStyle? _mapCallInfoStyle(CallPageInfoConfig? cfg) {
    if (cfg == null) {
      _logger.fine('Call info styles config not provided, call info will use default styles');
      return null;
    }

    final userInfoTextStyle = cfg.usernameTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);
    final numberTextStyle = cfg.numberTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);
    final callStatusTextStyle = cfg.callStatusTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);
    final processingStatusTextStyle = cfg.processingStatusTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);

    return CallInfoStyle(
      userInfo: _mergeWithDefaultTextStyle(
        userInfoTextStyle,
        defaultColor: colors.surface,
        defaultFontWeight: FontWeight.w400,
        defaultFontSize: 24,
      ),
      number: _mergeWithDefaultTextStyle(
        numberTextStyle,
        defaultColor: colors.surface,
        defaultFontWeight: FontWeight.w400,
        defaultFontSize: 20,
      ),
      callStatus: _mergeWithDefaultTextStyle(
        callStatusTextStyle,
        defaultColor: colors.surface,
        defaultFontWeight: FontWeight.w400,
        defaultFontSize: 16,
      ),
      processingStatus: _mergeWithDefaultTextStyle(
        processingStatusTextStyle,
        defaultColor: colors.surface,
        defaultFontWeight: FontWeight.w500,
        defaultFontSize: 14,
      ),
    );
  }

  TextStyle? _mergeWithDefaultTextStyle(
    TextStyle? textStyle, {
    required Color defaultColor,
    required FontWeight defaultFontWeight,
    required double defaultFontSize,
  }) {
    return textStyle?.copyWith(
      color: textStyle.color ?? defaultColor,
      fontWeight: textStyle.fontWeight ?? defaultFontWeight,
      fontSize: textStyle.fontSize ?? defaultFontSize,
    );
  }

  /// Resolves the in-call keypad input text style so it can be merged over the
  /// widget's base [TextTheme.displaySmall]. [TextStyleConfig.toTextStyle]
  /// always emits a non-null fontWeight/fontStyle, which would override the base
  /// during the merge; keep them only when the config sets them, so unset fields
  /// inherit the base weight/style instead of being forced to normal.
  TextStyle? _resolveKeypadInputTextStyle(TextStyleConfig? config) {
    if (config == null) return null;
    final resolved = config.toTextStyle(defaultFontFamily: defaultFontFamily);
    return TextStyle(
      fontFamily: resolved.fontFamily,
      fontSize: resolved.fontSize,
      fontWeight: config.fontWeight != null ? resolved.fontWeight : null,
      fontStyle: config.fontStyle != null ? resolved.fontStyle : null,
      color: resolved.color,
      letterSpacing: resolved.letterSpacing,
      wordSpacing: resolved.wordSpacing,
      height: resolved.height,
      decoration: resolved.decoration,
      backgroundColor: resolved.backgroundColor,
    );
  }

  /// The nine call buttons, from the page config alone.
  ///
  /// There used to be a second source here - the retired
  /// `widgetConfig.group.callActions` - and which of the two applied was
  /// decided by whether its container object existed rather than by whether
  /// anything in it was set. The two disagreed about what an unset button looks
  /// like, so the same theme drew a different call screen depending on which
  /// backend served it. One source is what makes that impossible.
  CallScreenActionsStyle? _mapActionsFromPage(CallPageActionsConfig? a) {
    if (a == null) return null;

    return CallScreenActionsStyle(
      callStart: _actionStyle(a.callStart, background: colors.tertiary, foreground: colors.onTertiary),
      hangup: _actionStyle(a.hangup, background: colors.error, foreground: colors.onError),
      transfer: _actionStyle(a.transfer, background: colors.secondary, foreground: colors.onSecondary),
      swap: _actionStyle(
        a.swap,
        background: colors.surfaceContainerHigh,
        foreground: colors.onSurface,
        icon: colors.onSurface,
      ),
      key: _actionStyle(
        a.key,
        background: colors.surfaceContainer,
        foreground: colors.onSurface,
        icon: colors.onSurface,
      ),
      camera: _actionStyle(
        a.camera,
        background: colors.surfaceContainerHighest,
        foreground: colors.onSurface,
        icon: colors.onSurface,
        toggleable: true,
      ),
      muted: _actionStyle(
        a.muted,
        background: colors.surfaceContainerHigh,
        foreground: colors.onSurface,
        icon: colors.onSurface,
        toggleable: true,
      ),
      speaker: _actionStyle(
        a.speaker,
        background: colors.surfaceContainerHigh,
        foreground: colors.onSurface,
        icon: colors.onSurface,
        toggleable: true,
      ),
      held: _actionStyle(
        a.held,
        background: colors.surfaceContainerHigh,
        foreground: colors.onSurface,
        icon: colors.onSurface,
        toggleable: true,
      ),
      keypadInputTextStyle: _resolveKeypadInputTextStyle(a.keypadInputStyle),
    );
  }

  /// One call-action button.
  ///
  /// [background], [foreground] and [icon] are what the button looks like when
  /// the theme says nothing; [toggleable] adds the switched-on look, which the
  /// theme cannot set yet and therefore comes from the palette.
  ButtonStyle _actionStyle(
    ButtonStyleConfig config, {
    required Color background,
    required Color foreground,
    Color? icon,
    bool toggleable = false,
    Color? selectedBackground,
    Color? disabledBackground,
  }) {
    final fallback = ButtonStyleFallback(
      background: background,
      foreground: foreground,
      icon: icon ?? colors.surface,
      selectedBackground: toggleable ? selectedBackground ?? colors.surface : null,
      selectedForeground: toggleable ? colors.onSurface : null,
      selectedIcon: toggleable ? colors.onSecondaryFixedVariant : null,
      disabledBackground: disabledBackground,
      disabledIcon: colors.surface.withValues(alpha: kDisabledOpacity),
      disabledOpacity: kDisabledOpacity,
    );

    final themed = config.toButtonStyle(defaultFontFamily: defaultFontFamily, fallback: fallback);

    // Colors only, on purpose. These buttons live in a grid that sets their
    // size, so letting a theme through with a shape or a fixed size here would
    // let it pull the grid apart.
    return ButtonStyle(
      backgroundColor: themed.backgroundColor,
      foregroundColor: themed.foregroundColor,
      iconColor: themed.iconColor,
      overlayColor: themed.overlayColor,
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
    );
  }
}
