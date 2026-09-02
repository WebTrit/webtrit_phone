import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

/// Every colour a theme names has to reach the screen.
///
/// The app builds its palette from a seed and then replaces role by role with
/// what the theme asked for, listing each one by hand. A role missing from that
/// list is not an error anywhere: the value is stored, shown in the editor,
/// carried into the build - and then quietly replaced by whatever the seed
/// generates. That is how the colour of the initials inside an avatar came from
/// Material while the circle behind them came from the brand.
///
/// So the list is pinned here in full: give every role a colour of its own, and
/// read every one of them back.
final _roleReaders = <String, Color Function(ColorScheme)>{
  'primary': (scheme) => scheme.primary,
  'onPrimary': (scheme) => scheme.onPrimary,
  'primaryContainer': (scheme) => scheme.primaryContainer,
  'onPrimaryContainer': (scheme) => scheme.onPrimaryContainer,
  'primaryFixed': (scheme) => scheme.primaryFixed,
  'primaryFixedDim': (scheme) => scheme.primaryFixedDim,
  'onPrimaryFixed': (scheme) => scheme.onPrimaryFixed,
  'onPrimaryFixedVariant': (scheme) => scheme.onPrimaryFixedVariant,
  'secondary': (scheme) => scheme.secondary,
  'onSecondary': (scheme) => scheme.onSecondary,
  'secondaryContainer': (scheme) => scheme.secondaryContainer,
  'onSecondaryContainer': (scheme) => scheme.onSecondaryContainer,
  'secondaryFixed': (scheme) => scheme.secondaryFixed,
  'secondaryFixedDim': (scheme) => scheme.secondaryFixedDim,
  'onSecondaryFixed': (scheme) => scheme.onSecondaryFixed,
  'onSecondaryFixedVariant': (scheme) => scheme.onSecondaryFixedVariant,
  'tertiary': (scheme) => scheme.tertiary,
  'onTertiary': (scheme) => scheme.onTertiary,
  'tertiaryContainer': (scheme) => scheme.tertiaryContainer,
  'onTertiaryContainer': (scheme) => scheme.onTertiaryContainer,
  'tertiaryFixed': (scheme) => scheme.tertiaryFixed,
  'tertiaryFixedDim': (scheme) => scheme.tertiaryFixedDim,
  'onTertiaryFixed': (scheme) => scheme.onTertiaryFixed,
  'onTertiaryFixedVariant': (scheme) => scheme.onTertiaryFixedVariant,
  'error': (scheme) => scheme.error,
  'onError': (scheme) => scheme.onError,
  'errorContainer': (scheme) => scheme.errorContainer,
  'onErrorContainer': (scheme) => scheme.onErrorContainer,
  'outline': (scheme) => scheme.outline,
  'outlineVariant': (scheme) => scheme.outlineVariant,
  'surface': (scheme) => scheme.surface,
  'onSurface': (scheme) => scheme.onSurface,
  'surfaceDim': (scheme) => scheme.surfaceDim,
  'surfaceBright': (scheme) => scheme.surfaceBright,
  'surfaceContainerLowest': (scheme) => scheme.surfaceContainerLowest,
  'surfaceContainerLow': (scheme) => scheme.surfaceContainerLow,
  'surfaceContainer': (scheme) => scheme.surfaceContainer,
  'surfaceContainerHigh': (scheme) => scheme.surfaceContainerHigh,
  'surfaceContainerHighest': (scheme) => scheme.surfaceContainerHighest,
  'onSurfaceVariant': (scheme) => scheme.onSurfaceVariant,
  'inverseSurface': (scheme) => scheme.inverseSurface,
  'onInverseSurface': (scheme) => scheme.onInverseSurface,
  'inversePrimary': (scheme) => scheme.inversePrimary,
  'shadow': (scheme) => scheme.shadow,
  'scrim': (scheme) => scheme.scrim,
  'surfaceTint': (scheme) => scheme.surfaceTint,
};

/// A config naming every role, each with a colour nothing else uses.
ColorSchemeConfig _allRolesDistinct() {
  return const ColorSchemeConfig(
    seedColor: '#F95A14',
    colorSchemeOverride: ColorSchemeOverride(
      primary: '#000001',
      onPrimary: '#000002',
      primaryContainer: '#000003',
      onPrimaryContainer: '#000004',
      primaryFixed: '#000005',
      primaryFixedDim: '#000006',
      onPrimaryFixed: '#000007',
      onPrimaryFixedVariant: '#000008',
      secondary: '#000009',
      onSecondary: '#00000A',
      secondaryContainer: '#00000B',
      onSecondaryContainer: '#00000C',
      secondaryFixed: '#00000D',
      secondaryFixedDim: '#00000E',
      onSecondaryFixed: '#00000F',
      onSecondaryFixedVariant: '#000010',
      tertiary: '#000011',
      onTertiary: '#000012',
      tertiaryContainer: '#000013',
      onTertiaryContainer: '#000014',
      tertiaryFixed: '#000015',
      tertiaryFixedDim: '#000016',
      onTertiaryFixed: '#000017',
      onTertiaryFixedVariant: '#000018',
      error: '#000019',
      onError: '#00001A',
      errorContainer: '#00001B',
      onErrorContainer: '#00001C',
      outline: '#00001D',
      outlineVariant: '#00001E',
      surface: '#00001F',
      onSurface: '#000020',
      surfaceDim: '#000021',
      surfaceBright: '#000022',
      surfaceContainerLowest: '#000023',
      surfaceContainerLow: '#000024',
      surfaceContainer: '#000025',
      surfaceContainerHigh: '#000026',
      surfaceContainerHighest: '#000027',
      onSurfaceVariant: '#000028',
      inverseSurface: '#000029',
      onInverseSurface: '#00002A',
      inversePrimary: '#00002B',
      shadow: '#00002C',
      scrim: '#00002D',
      surfaceTint: '#00002E',
    ),
  );
}

ColorScheme _schemeOf(ColorSchemeConfig config, {Brightness brightness = Brightness.light}) {
  return config.toColorScheme(seedColor: config.seedColor.toColor(), brightness: brightness);
}

void main() {
  group('a theme that names every role', () {
    test('has every one of them on the screen', () {
      final config = _allRolesDistinct();
      final scheme = _schemeOf(config);
      final json = config.colorSchemeOverride.toJson();

      final ignored = <String>[
        for (final entry in _roleReaders.entries)
          if (entry.value(scheme) != (json[entry.key]! as String).toColor()) entry.key,
      ];

      expect(ignored, isEmpty, reason: 'these roles never reach the color scheme');
    });

    test('covers the whole config, so a new role cannot be forgotten', () {
      expect(_roleReaders.keys.toSet(), _allRolesDistinct().colorSchemeOverride.toJson().keys.toSet());
    });
  });

  group('a theme that leaves a role out', () {
    test('takes it from the seed rather than from a fixed colour', () {
      const seed = '#0044FF';
      final scheme = _schemeOf(const ColorSchemeConfig(seedColor: seed));
      final fromSeed = ColorScheme.fromSeed(seedColor: seed.toColor(), brightness: Brightness.light);

      expect(scheme.tertiary, fromSeed.tertiary);
      expect(scheme.onSecondaryContainer, fromSeed.onSecondaryContainer);
    });

    test('so moving the seed moves what the theme did not name', () {
      final one = _schemeOf(const ColorSchemeConfig(seedColor: '#0044FF'));
      final other = _schemeOf(const ColorSchemeConfig(seedColor: '#FF4400'));

      expect(one.tertiary, isNot(other.tertiary));
    });

    test('and keeps what it did name', () {
      final scheme = _schemeOf(
        const ColorSchemeConfig(
          seedColor: '#0044FF',
          colorSchemeOverride: ColorSchemeOverride(onSecondaryContainer: '#123456'),
        ),
      );

      expect(scheme.onSecondaryContainer, '#123456'.toColor());
    });
  });
}
