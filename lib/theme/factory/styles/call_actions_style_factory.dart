import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

@Deprecated('Use CallScreenStyleFactory instead')
class CallActionsStyleFactory implements ThemeStyleFactory<CallActionsStyles> {
  CallActionsStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final CallActionsWidgetConfig? config;

  @override
  CallActionsStyles create() {
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
}
