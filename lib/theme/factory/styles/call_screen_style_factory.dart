import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../../styles/styles.dart';
import '../theme_style_factory.dart';

const double kDisabledOpacity = 0.40;

class CallScreenStyleFactory implements ThemeStyleFactory<CallScreenStyles> {
  CallScreenStyleFactory(
    this.colors,
    this.pageConfig,
    this.legacyCallActionsConfig,
  );

  final ColorScheme colors;
  final CallPageConfig? pageConfig;

  // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
  // ignore: deprecated_member_use
  final CallActionsWidgetConfig? legacyCallActionsConfig;

  @override
  CallScreenStyles create() {
    final appBarCfg = pageConfig?.appBarStyle;
    final infoCfg = pageConfig?.callInfo;

    return CallScreenStyles(
      primary: CallScreenStyle(
        systemUiOverlayStyle: pageConfig?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        appBar: _mapAppBarStyle(appBarCfg),
        callInfo: _mapCallInfoStyle(infoCfg),
        actions: _resolveActionsStyle(
          fromPage: pageConfig?.actions,
          fromLegacy: legacyCallActionsConfig,
        ),
      ),
    );
  }

  AppBarStyle _mapAppBarStyle(AppBarStyleConfig? cfg) {
    return AppBarStyle(
      backgroundColor: cfg?.backgroundColor?.toColor() ?? Colors.transparent,
      foregroundColor: cfg?.foregroundColor?.toColor() ?? colors.surface,
      primary: false,
      showBackButton: true,
    );
  }

  CallInfoStyle? _mapCallInfoStyle(CallPageInfoConfig? cfg) {
    if (cfg == null) return null;
    return CallInfoStyle(
      userInfo: cfg.usernameTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 24,
        defaultFontWeight: FontWeight.w400,
      ),
      number: cfg.numberTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 20,
        defaultFontWeight: FontWeight.w400,
      ),
      callStatus: cfg.callStatusTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 16,
        defaultFontWeight: FontWeight.w400,
      ),
      processingStatus: cfg.processingStatusTextStyle?.toTextStyle(
        fallbackColor: colors.surface,
        defaultFontSize: 14,
        defaultFontWeight: FontWeight.w500,
      ),
    );
  }

  CallScreenActionsStyle? _resolveActionsStyle({
    CallPageActionsConfig? fromPage,
    // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use
    CallActionsWidgetConfig? fromLegacy,
  }) {
    if (fromPage != null) return _mapActionsFromPage(fromPage);
    if (fromLegacy != null) return _mapActionsFromLegacy(fromLegacy);
    return null;
  }

  CallScreenActionsStyle _mapActionsFromPage(CallPageActionsConfig a) {
    return CallScreenActionsStyle(
      callStart: buildFixedButtonStyle(
        a.callStart,
        colors: colors,
        fg: colors.onTertiary,
        bg: colors.tertiary,
        icon: colors.surface,
      ),
      hangup: buildFixedButtonStyle(
        a.hangup,
        colors: colors,
        fg: colors.onError,
        bg: colors.error,
        icon: colors.surface,
      ),
      transfer: buildFixedButtonStyle(
        a.transfer,
        colors: colors,
        fg: colors.onSecondary,
        bg: colors.secondary,
        icon: colors.surface,
      ),
      swap: buildFixedButtonStyle(
        a.swap,
        colors: colors,
        fg: colors.onSurface,
        bg: colors.surfaceContainerHigh,
        icon: colors.onSurface,
      ),
      key: buildFixedButtonStyle(
        a.key,
        colors: colors,
        fg: colors.onSurface,
        bg: colors.surfaceContainer,
        icon: colors.onSurface,
      ),
      camera: buildToggleButtonStyle(
        a.camera,
        colors: colors,
        baseFg: colors.onSurface,
        baseBg: colors.surfaceContainerHighest,
        baseIcon: colors.onSurface,
      ),
      muted: buildToggleButtonStyle(
        a.muted,
        colors: colors,
        baseFg: colors.onSurface,
        baseBg: colors.surfaceContainerHigh,
        baseIcon: colors.onSurface,
      ),
      speaker: buildToggleButtonStyle(
        a.speaker,
        colors: colors,
        baseFg: colors.onSurface,
        baseBg: colors.surfaceContainerHigh,
        baseIcon: colors.onSurface,
      ),
      held: buildToggleButtonStyle(
        a.held,
        colors: colors,
        baseFg: colors.onSurface,
        baseBg: colors.surfaceContainerHigh,
        baseIcon: colors.onSurface,
      ),
    );
  }

  // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
  // ignore: deprecated_member_use
  CallScreenActionsStyle _mapActionsFromLegacy(CallActionsWidgetConfig c) {
    final inactiveIcon = colors.surface;
    final activeIcon = colors.onSecondaryFixedVariant;

    final actionBg = colors.surface.withValues(alpha: kDisabledOpacity);
    final activeActionBg = colors.surface;

    final callStartBg = c.callStartBackgroundColor?.toColor() ?? colors.tertiary;
    final hangupBg = c.hangupBackgroundColor?.toColor() ?? colors.error;
    final transferBg = c.transferBackgroundColor?.toColor() ?? actionBg;

    final cameraBg = c.cameraBackgroundColor?.toColor() ?? actionBg;
    final cameraActiveBg = c.cameraActiveBackgroundColor?.toColor() ?? activeActionBg;

    final mutedBg = c.mutedBackgroundColor?.toColor() ?? actionBg;
    final mutedActiveBg = c.mutedActiveBackgroundColor?.toColor() ?? activeActionBg;

    final speakerBg = c.speakerBackgroundColor?.toColor() ?? actionBg;
    final speakerActiveBg = c.speakerActiveBackgroundColor?.toColor() ?? activeActionBg;

    final heldBg = c.heldBackgroundColor?.toColor() ?? actionBg;
    final heldActiveBg = c.heldActiveBackgroundColor?.toColor() ?? activeActionBg;

    final swapBg = c.swapBackgroundColor?.toColor() ?? actionBg;
    final keyBg = c.keyBackgroundColor?.toColor() ?? actionBg;

    return CallScreenActionsStyle(
      callStart: buildFilledLikeStyle(
        colors: colors,
        fg: colors.onTertiary,
        bg: callStartBg,
        icon: inactiveIcon,
      ),
      hangup: buildFilledLikeStyle(
        colors: colors,
        fg: colors.onError,
        bg: hangupBg,
        icon: inactiveIcon,
      ),
      transfer: buildFilledLikeStyle(
        colors: colors,
        fg: colors.onSecondary,
        bg: transferBg,
        icon: inactiveIcon,
      ),
      camera: buildToggleLikeStyle(
        colors: colors,
        bg: cameraBg,
        activeBg: cameraActiveBg,
        icon: inactiveIcon,
        activeIcon: activeIcon,
        fg: colors.surface,
        activeFg: colors.onSurface,
      ),
      muted: buildToggleLikeStyle(
        colors: colors,
        bg: mutedBg,
        activeBg: mutedActiveBg,
        icon: inactiveIcon,
        activeIcon: activeIcon,
        fg: colors.surface,
        activeFg: colors.onSurface,
      ),
      speaker: buildToggleLikeStyle(
        colors: colors,
        bg: speakerBg,
        activeBg: speakerActiveBg,
        icon: inactiveIcon,
        activeIcon: activeIcon,
        fg: colors.surface,
        activeFg: colors.onSurface,
      ),
      held: buildToggleLikeStyle(
        colors: colors,
        bg: heldBg,
        activeBg: heldActiveBg,
        icon: inactiveIcon,
        activeIcon: activeIcon,
        fg: colors.surface,
        activeFg: colors.onSurface,
      ),
      swap: buildFilledLikeStyle(
        colors: colors,
        fg: colors.surface,
        bg: swapBg,
        icon: inactiveIcon,
      ),
      key: buildFilledLikeStyle(
        colors: colors,
        fg: colors.surface,
        bg: keyBg,
        icon: inactiveIcon,
      ),
    );
  }

  ButtonStyle buildFixedButtonStyle(
    ElevatedButtonWidgetConfig cfg, {
    required ColorScheme colors,
    required Color fg,
    required Color bg,
    required Color icon,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    final resolvedFg = cfg.foregroundColor?.toColor() ?? fg;
    final resolvedFgDisabled = cfg.disabledForegroundColor?.toColor() ?? resolvedFg.withValues(alpha: kDisabledOpacity);

    final resolvedBg = cfg.backgroundColor?.toColor() ?? bg;
    final resolvedBgDisabled = cfg.disabledBackgroundColor?.toColor() ?? resolvedBg.withValues(alpha: kDisabledOpacity);

    final resolvedIcon = cfg.iconColor?.toColor() ?? icon;
    final resolvedIconDisabled = cfg.disabledIconColor?.toColor() ?? colors.surface.withValues(alpha: kDisabledOpacity);

    final base = TextButton.styleFrom(
      foregroundColor: resolvedFg,
      backgroundColor: resolvedBg,
      disabledForegroundColor: resolvedFgDisabled,
      iconColor: resolvedIcon,
      disabledIconColor: resolvedIconDisabled,
      padding: padding,
    );

    return base.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => states.contains(WidgetState.disabled) ? resolvedBgDisabled : resolvedBg,
      ),
    );
  }

  ButtonStyle buildToggleButtonStyle(
    ElevatedButtonWidgetConfig cfg, {
    required ColorScheme colors,
    required Color baseFg,
    required Color baseBg,
    required Color baseIcon,
    Color? activeFg,
    Color? activeBg,
    Color? activeIcon,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    final disFg = cfg.disabledForegroundColor?.toColor() ?? baseFg.withValues(alpha: kDisabledOpacity);
    final disBg = cfg.disabledBackgroundColor?.toColor() ?? baseBg.withValues(alpha: kDisabledOpacity);
    final disIcon = cfg.disabledIconColor?.toColor() ?? colors.surface.withValues(alpha: kDisabledOpacity);

    final selFg = activeFg ?? colors.onSurface;
    final selBg = activeBg ?? colors.surface;
    final selIcon = activeIcon ?? colors.onSecondaryFixedVariant;

    Color? bg(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disBg;
      if (s.contains(WidgetState.selected)) return selBg;
      return cfg.backgroundColor?.toColor() ?? baseBg;
    }

    Color? fg(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disFg;
      if (s.contains(WidgetState.selected)) return selFg;
      return cfg.foregroundColor?.toColor() ?? baseFg;
    }

    Color? ic(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disIcon;
      if (s.contains(WidgetState.selected)) return selIcon;
      return cfg.iconColor?.toColor() ?? baseIcon;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(bg),
      foregroundColor: WidgetStateProperty.resolveWith(fg),
      iconColor: WidgetStateProperty.resolveWith(ic),
      padding: WidgetStatePropertyAll(padding),
    );
  }

  ButtonStyle buildFilledLikeStyle({
    required ColorScheme colors,
    required Color fg,
    required Color bg,
    required Color icon,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return TextButton.styleFrom(
      foregroundColor: fg,
      backgroundColor: bg,
      disabledForegroundColor: fg.withValues(alpha: kDisabledOpacity),
      iconColor: icon,
      disabledIconColor: colors.surface.withValues(alpha: kDisabledOpacity),
      padding: padding,
    );
  }

  ButtonStyle buildToggleLikeStyle({
    required ColorScheme colors,
    required Color bg,
    required Color activeBg,
    required Color icon,
    required Color activeIcon,
    required Color fg,
    required Color activeFg,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? disabledIcon,
  }) {
    final disabledBg = disabledBackground ?? bg.withValues(alpha: kDisabledOpacity);
    final disabledFg = disabledForeground ?? fg.withValues(alpha: kDisabledOpacity);
    final disabledIcon0 = disabledIcon ?? icon.withValues(alpha: kDisabledOpacity);

    Color? resolveBg(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disabledBg;
      if (s.contains(WidgetState.selected)) return activeBg;
      return bg;
    }

    Color? resolveFg(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disabledFg;
      if (s.contains(WidgetState.selected)) return activeFg;
      return fg;
    }

    Color? resolveIcon(Set<WidgetState> s) {
      if (s.contains(WidgetState.disabled)) return disabledIcon0;
      if (s.contains(WidgetState.selected)) return activeIcon;
      return icon;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(resolveBg),
      foregroundColor: WidgetStateProperty.resolveWith(resolveFg),
      iconColor: WidgetStateProperty.resolveWith(resolveIcon),
      padding: WidgetStatePropertyAll(padding),
    );
  }
}
