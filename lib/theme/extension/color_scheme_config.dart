import 'package:flutter/material.dart';

import '../models/models.dart';

import 'theme_json_serializable.dart';

extension ColorSchemeConfigExtension on ColorSchemeConfig {
  ColorScheme toColorScheme({
    required Color seedColor,
    required Brightness brightness,
    Color? dynamicPrimary,
    Color? targetColor,
  }) {
    final seed = dynamicPrimary ?? targetColor ?? seedColor;

    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
      primary: colorSchemeOverride.primary.toColor(),
      onPrimary: colorSchemeOverride.onPrimary.toColor(),
      primaryContainer: colorSchemeOverride.primaryContainer.toColor(),
      onPrimaryContainer: colorSchemeOverride.onPrimaryContainer.toColor(),
      primaryFixed: colorSchemeOverride.primaryFixed.toColor(),
      primaryFixedDim: colorSchemeOverride.primaryFixedDim.toColor(),
      onPrimaryFixed: colorSchemeOverride.onPrimaryFixed.toColor(),
      onPrimaryFixedVariant: colorSchemeOverride.onPrimaryFixedVariant.toColor(),
      secondary: colorSchemeOverride.secondary.toColor(),
      onSecondary: colorSchemeOverride.onSecondary.toColor(),
      secondaryContainer: colorSchemeOverride.secondaryContainer.toColor(),
      secondaryFixed: colorSchemeOverride.secondaryFixed.toColor(),
      secondaryFixedDim: colorSchemeOverride.secondaryFixedDim.toColor(),
      onSecondaryFixed: colorSchemeOverride.onSecondaryFixed.toColor(),
      onSecondaryFixedVariant: colorSchemeOverride.onSecondaryFixedVariant.toColor(),
      tertiary: colorSchemeOverride.tertiary.toColor(),
      onTertiary: colorSchemeOverride.onTertiary.toColor(),
      tertiaryContainer: colorSchemeOverride.tertiaryContainer.toColor(),
      onTertiaryContainer: colorSchemeOverride.onTertiaryContainer.toColor(),
      tertiaryFixed: colorSchemeOverride.tertiaryFixed.toColor(),
      tertiaryFixedDim: colorSchemeOverride.tertiaryFixedDim.toColor(),
      onTertiaryFixed: colorSchemeOverride.onTertiaryFixed.toColor(),
      onTertiaryFixedVariant: colorSchemeOverride.onTertiaryFixedVariant.toColor(),
      error: colorSchemeOverride.error.toColor(),
      onError: colorSchemeOverride.onError.toColor(),
      errorContainer: colorSchemeOverride.errorContainer.toColor(),
      onErrorContainer: colorSchemeOverride.onErrorContainer.toColor(),
      outline: colorSchemeOverride.outline.toColor(),
      outlineVariant: colorSchemeOverride.outlineVariant.toColor(),
      surface: colorSchemeOverride.surface.toColor(),
      onSurface: colorSchemeOverride.onSurface.toColor(),
      surfaceDim: colorSchemeOverride.surfaceDim.toColor(),
      surfaceBright: colorSchemeOverride.surfaceBright.toColor(),
      surfaceContainerLowest: colorSchemeOverride.surfaceContainerLowest.toColor(),
      surfaceContainerLow: colorSchemeOverride.surfaceContainerLow.toColor(),
      surfaceContainer: colorSchemeOverride.surfaceContainer.toColor(),
      surfaceContainerHigh: colorSchemeOverride.surfaceContainerHigh.toColor(),
      surfaceContainerHighest: colorSchemeOverride.surfaceContainerHighest.toColor(),
      onSurfaceVariant: colorSchemeOverride.onSurfaceVariant.toColor(),
      inverseSurface: colorSchemeOverride.inverseSurface.toColor(),
      onInverseSurface: colorSchemeOverride.onInverseSurface.toColor(),
      inversePrimary: colorSchemeOverride.inversePrimary.toColor(),
      shadow: colorSchemeOverride.shadow.toColor(),
      scrim: colorSchemeOverride.scrim.toColor(),
      surfaceTint: colorSchemeOverride.surfaceTint.toColor(),
    );
  }
}
