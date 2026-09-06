import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

/// How much of a colour is left on an actionpad button that cannot be pressed.
const double kActionPadDisabledOpacity = 0.38;

/// The same for the background of a button whose resting fill is an accent,
/// which fades further so a dead button does not read as a filled one. A button
/// already resting on a surface tone cannot say it this way - the faded accent
/// lands within a couple of percent of the tone it started from - so it recedes
/// toward the page instead.
const double kActionPadDisabledBackgroundOpacity = 0.12;

final _logger = Logger('ActionPadStyleFactory');

class ActionPadStyleFactory implements ThemeStyleFactory<ActionpadStyles> {
  ActionPadStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final ActionPadWidgetConfig? config;
  final String? defaultFontFamily;

  @override
  ActionpadStyles create() {
    const defaultScale = 0.75;
    const callStartScale = 1.0;

    _logger.finePretty('Creating ActionPadStyles, config = $config, defaultFontFamily = $defaultFontFamily');

    // One style used to fill all three, so the button that places the call, the
    // one that opens the options beside it and the backspace under it were the
    // same filled `secondary` circle. Three buttons, three jobs, one look.
    ButtonStyle filled(Color background, Color foreground, {Color? disabledBackground}) => TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: foreground,
      backgroundColor: background,
      disabledForegroundColor: colors.onSurface.withValues(alpha: kActionPadDisabledOpacity),
      disabledIconColor: colors.onSurface.withValues(alpha: kActionPadDisabledOpacity),
      disabledBackgroundColor:
          disabledBackground ?? colors.onSurface.withValues(alpha: kActionPadDisabledBackgroundOpacity),
    );

    // The same green the call screen starts a call with. It is the one thing
    // this screen is for, and it was indistinguishable from the backspace.
    final callStyle = filled(colors.tertiary, colors.onTertiary);

    // An action, but not the one the screen is for.
    final optionsStyle = filled(colors.secondary, colors.onSecondary);

    // Editing the number rather than acting on it, so it is quiet: a surface
    // tone instead of a filled accent. Still a circle, because the geometry of
    // the row is not what was wrong with it.
    //
    // It needs its own disabled fill. The shared one is the resting accent
    // faded, which for a button already resting on the highest surface tone
    // lands two percent away from where it started - and this is the state the
    // screen opens in, since an empty number disables all three. A lower
    // surface tone reads as receding toward the page.
    final backspaceStyle = filled(
      colors.surfaceContainerHighest,
      colors.onSurfaceVariant,
      disabledBackground: colors.surfaceContainerLow,
    );

    return ActionpadStyles(
      primary: ActionpadStyle(
        primary: _resolveStyle(source: config?.callStart, fallback: callStyle, scale: callStartScale),
        secondary: _resolveStyle(source: config?.callTransfer, fallback: optionsStyle, scale: defaultScale),
        backspace: _resolveStyle(source: config?.backspace, fallback: backspaceStyle, scale: defaultScale),
      ),
    );
  }

  ScaleButtonStyle _resolveStyle({
    required ButtonStyle fallback,
    required double scale,
    ButtonStyleConfig? source,
    bool checkTransparency = true,
  }) {
    final sourceStyle = source?.toButtonStyle(defaultFontFamily: defaultFontFamily);

    // If no config provided, strictly use fallback
    if (sourceStyle == null) {
      final backgroundColor = fallback.backgroundColor?.resolve({});
      final isTransparent = checkTransparency && (backgroundColor == null || backgroundColor.a == 0);
      return ScaleButtonStyle(style: fallback, scale: isTransparent ? 1 : scale);
    }

    // Force override properties using copyWith to ensure config values take precedence
    final style = fallback.copyWith(
      backgroundColor: sourceStyle.backgroundColor,
      foregroundColor: sourceStyle.foregroundColor,
      iconColor: sourceStyle.iconColor,
      overlayColor: sourceStyle.overlayColor,
      shadowColor: sourceStyle.shadowColor,
      elevation: sourceStyle.elevation,
      side: sourceStyle.side,
      shape: sourceStyle.shape,
      textStyle: sourceStyle.textStyle,
    );

    final backgroundColor = style.backgroundColor?.resolve({});
    final isTransparent = checkTransparency && (backgroundColor == null || backgroundColor.a == 0);

    return ScaleButtonStyle(style: style, scale: isTransparent ? 1 : scale);
  }
}
