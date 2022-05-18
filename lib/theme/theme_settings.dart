import 'package:flutter/material.dart';

import 'custom_color.dart';

class ThemeSettings {
  const ThemeSettings({
    required this.seedColor,
    required this.themeMode,
    this.lightColorSchemeOverride,
    this.darkColorSchemeOverride,
    required this.primaryGradientColors,
  });

  final Color seedColor;
  final ThemeMode themeMode;
  final ColorSchemeOverride? lightColorSchemeOverride;
  final ColorSchemeOverride? darkColorSchemeOverride;
  final List<CustomColor> primaryGradientColors;
}

class ThemeSettingsChangedNotification extends Notification {
  ThemeSettingsChangedNotification({
    required this.settings,
  });

  final ThemeSettings settings;
}

class ColorSchemeOverride {
  const ColorSchemeOverride({
    this.primary,
    this.onPrimary,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.secondary,
    this.onSecondary,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.tertiary,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.error,
    this.onError,
    this.errorContainer,
    this.onErrorContainer,
    this.outline,
    this.background,
    this.onBackground,
    this.surface,
    this.onSurface,
    this.surfaceVariant,
    this.onSurfaceVariant,
    this.inverseSurface,
    this.onInverseSurface,
    this.inversePrimary,
    this.shadow,
    this.surfaceTint,
  });

  final Color? primary;
  final Color? onPrimary;
  final Color? primaryContainer;
  final Color? onPrimaryContainer;
  final Color? secondary;
  final Color? onSecondary;
  final Color? secondaryContainer;
  final Color? onSecondaryContainer;
  final Color? tertiary;
  final Color? onTertiary;
  final Color? tertiaryContainer;
  final Color? onTertiaryContainer;
  final Color? error;
  final Color? onError;
  final Color? errorContainer;
  final Color? onErrorContainer;
  final Color? outline;
  final Color? background;
  final Color? onBackground;
  final Color? surface;
  final Color? onSurface;
  final Color? surfaceVariant;
  final Color? onSurfaceVariant;
  final Color? inverseSurface;
  final Color? onInverseSurface;
  final Color? inversePrimary;
  final Color? shadow;
  final Color? surfaceTint;
}
