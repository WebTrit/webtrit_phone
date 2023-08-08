import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

import 'custom_color.dart';

class ThemeSettings {
  const ThemeSettings({
    required this.seedColor,
    this.lightColorSchemeOverride,
    this.darkColorSchemeOverride,
    required this.primaryGradientColors,
    this.fontFamily,
    this.imagesScheme,
  });

  final Color seedColor;
  final ColorSchemeOverride? lightColorSchemeOverride;
  final ColorSchemeOverride? darkColorSchemeOverride;
  final List<CustomColor> primaryGradientColors;
  final ImagesScheme? imagesScheme;
  final String? fontFamily;
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
    this.outlineVariant,
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
    this.scrim,
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
  final Color? outlineVariant;
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
  final Color? scrim;
  final Color? surfaceTint;
}

class ImagesScheme {
  ImagesScheme({
    ReplaySubject<SvgLoader?>? primaryOnboardingLogoStream,
    ReplaySubject<SvgLoader?>? secondaryOnboardingLogoStream,
  })  : _primaryOnboardingLogoStream = primaryOnboardingLogoStream ?? ReplaySubject<SvgLoader?>(maxSize: 1),
        _secondaryOnboardingLogoStream = secondaryOnboardingLogoStream ?? ReplaySubject<SvgLoader?>(maxSize: 1);

  final ReplaySubject<SvgLoader?> _primaryOnboardingLogoStream;
  final ReplaySubject<SvgLoader?> _secondaryOnboardingLogoStream;

  Stream<SvgLoader?> get primaryOnboardingLogo => _primaryOnboardingLogoStream.stream;

  Stream<SvgLoader?> get secondaryOnboardingLogo => _secondaryOnboardingLogoStream.stream;

  void setPrimaryOnboardingLogo({
    String? url,
    Uint8List? bytes,
    SvgGenImage? asset,
    SvgGenImage svgGenImage = Assets.logo,
  }) async {
    if (url != null) {
      return _primaryOnboardingLogoStream.add(SvgNetworkLoader(url));
    } else if (bytes != null) {
      return _primaryOnboardingLogoStream.add(SvgBytesLoader(bytes));
    } else if (asset != null) {
      return _primaryOnboardingLogoStream.add(SvgAssetLoader(asset.path));
    } else {
      return _primaryOnboardingLogoStream.add(SvgAssetLoader(svgGenImage.path));
    }
  }

  void setSecondaryOnboardingLogo({
    String? url,
    Uint8List? bytes,
    SvgGenImage? asset,
    SvgGenImage svgGenImage = Assets.logo,
  }) {
    if (url != null) {
      return _secondaryOnboardingLogoStream.add(SvgNetworkLoader(url));
    } else if (bytes != null) {
      return _secondaryOnboardingLogoStream.add(SvgBytesLoader(bytes));
    } else if (asset != null) {
      return _secondaryOnboardingLogoStream.add(SvgAssetLoader(asset.path));
    } else {
      return _primaryOnboardingLogoStream.add(SvgAssetLoader(svgGenImage.path));
    }
  }

  void clearPrimaryOnboardingLogoStream() {
    _primaryOnboardingLogoStream.add(null);
  }

  void clearSecondaryOnboardingLogoStream() {
    _secondaryOnboardingLogoStream.add(null);
  }
}
