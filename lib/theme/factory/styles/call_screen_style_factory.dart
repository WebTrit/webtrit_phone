import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../../styles/styles.dart';
import '../theme_style_factory.dart';

const double kDisabledOpacity = 0.40;

/// How much of the surface a call button shows through when the theme sets no
/// background for it.
///
/// The resting look of the six neutral actions is a tint of the call screen
/// rather than a tone of its own, so the switched-on look - an opaque surface -
/// is a change in opacity and not a step between two near-white tones. It is
/// the same figure the retired widget-level styles used, and it is a factor
/// again for `disabled`: 0.40 of 0.40 leaves 0.16, so unavailable stays
/// distinct from unset.
const double kRestingOpacity = 0.40;

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
  /// Absent is the same as sets-nothing, and both draw nine buttons.
  ///
  /// A theme written before the page config had `actions` has none, and one
  /// that has the object with every colour null has set nothing - the same
  /// statement twice. Telling them apart is the mistake this factory used to
  /// make, and answering null for either is a worse version of it:
  /// `CallActionButton` hands the style to a `TextButton`, so no style is the
  /// app's plain text-button theme rather than the default call button.
  CallScreenActionsStyle _mapActionsFromPage(CallPageActionsConfig? a) {
    // What every action that is not call or hangup rests as. One value rather
    // than three tones of surface-container: the six read as one row of
    // buttons, and a per-button tone is a difference nobody asked for and
    // nobody can see.
    final resting = colors.surface.withValues(alpha: kRestingOpacity);

    return CallScreenActionsStyle(
      // The two that are filled by nature. A call is green and a hangup is
      // red on every phone ever made, so these carry a colour of their own
      // rather than a tint of the screen.
      callStart: _actionStyle(a?.callStart, background: colors.tertiary, foreground: colors.onTertiary),
      hangup: _actionStyle(a?.hangup, background: colors.error, foreground: colors.onError),
      // Transfer is one of the row, not an accent. It carried `secondary`,
      // which drew a filled dark circle among five tinted ones.
      transfer: _actionStyle(a?.transfer, background: resting, foreground: colors.surface),
      swap: _actionStyle(a?.swap, background: resting, foreground: colors.surface),
      key: _actionStyle(a?.key, background: resting, foreground: colors.surface),
      camera: _actionStyle(a?.camera, background: resting, foreground: colors.surface, toggleable: true),
      muted: _actionStyle(a?.muted, background: resting, foreground: colors.surface, toggleable: true),
      speaker: _actionStyle(a?.speaker, background: resting, foreground: colors.surface, toggleable: true),
      held: _actionStyle(a?.held, background: resting, foreground: colors.surface, toggleable: true),
      keypadInputTextStyle: _resolveKeypadInputTextStyle(a?.keypadInputStyle),
    );
  }

  /// One call-action button.
  ///
  /// [background], [foreground] and [icon] are what the button looks like when
  /// the theme says nothing; [toggleable] adds the switched-on look, which the
  /// theme cannot set yet and therefore comes from the palette.
  ButtonStyle _actionStyle(
    /// Null is a button the theme says nothing about, which resolves to
    /// [fallback] alone - every colour of it comes from the palette.
    ButtonStyleConfig? config, {
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

    // The identity element, not a stand-in: a `ButtonStyleConfig` with every
    // field null resolves each colour to `fallback`, which is the palette. So
    // "the theme says nothing" and "the theme sets nothing" take one path.
    final themed = (config ?? const ButtonStyleConfig()).toButtonStyle(
      defaultFontFamily: defaultFontFamily,
      fallback: fallback,
    );

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
