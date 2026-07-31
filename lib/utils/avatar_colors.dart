import 'package:flutter/material.dart';

/// Deterministic ("pseudorandom") avatar colors derived from a name.
///
/// The same seed always produces the same color, so a contact/chat/group keeps
/// its color across rebuilds, screens, sessions and devices - no persistence needed.
///
/// Two modes:
/// - no explicit palette: the seed hash picks a hue and the color is built in HSL with a
///   fixed saturation/lightness pair per [Brightness], which guarantees readable initials
///   for every possible hue;
/// - explicit palette (from the appearance theme): the seed hash picks an entry, and the
///   foreground falls back to a luminance-based black/white choice.
class AvatarColors {
  const AvatarColors._();

  /// Saturation/lightness of the generated background and of the initials on top of it.
  static const _backgroundSaturation = 0.7;
  static const _foregroundSaturation = 0.2;
  static const _lightBackgroundLightness = 0.25;
  static const _lightForegroundLightness = 0.95;
  static const _darkBackgroundLightness = 0.8;
  static const _darkForegroundLightness = 0.05;

  /// Background color for [seed]; returns null for an empty/blank seed so callers
  /// can keep their static fallback.
  static Color? background(String? seed, Brightness brightness, {List<Color>? palette}) {
    final hash = _hash(seed);
    if (hash == null) return null;

    if (palette != null && palette.isNotEmpty) return palette[hash % palette.length];

    final lightness = brightness == Brightness.dark ? _darkBackgroundLightness : _lightBackgroundLightness;
    return HSLColor.fromAHSL(1, (hash % 360).toDouble(), _backgroundSaturation, lightness).toColor();
  }

  /// Initials color to place on top of [background].
  static Color foreground(Color background, Brightness brightness) {
    final hsl = HSLColor.fromColor(background);

    // A grey/near-grey palette entry has no usable hue - fall back to plain contrast.
    if (hsl.saturation < 0.1) {
      return background.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
    }

    final lightness = brightness == Brightness.dark ? _darkForegroundLightness : _lightForegroundLightness;
    return HSLColor.fromAHSL(1, hsl.hue, _foregroundSaturation, lightness).toColor();
  }

  /// FNV-1a over the normalized seed; null when there is nothing to hash.
  static int? _hash(String? seed) {
    final normalized = seed?.trim().toLowerCase() ?? '';
    if (normalized.isEmpty) return null;

    var hash = 0x811c9dc5;
    for (final rune in normalized.runes) {
      hash = (hash ^ rune) & 0xFFFFFFFF;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }
}
