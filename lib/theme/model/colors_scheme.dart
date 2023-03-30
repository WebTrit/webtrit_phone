import 'dart:ui';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_settings.dart';

class ColorsScheme {
  ColorsScheme({
    this.primary,
    this.onPrimary,
    this.onSurface,
    this.surface,
    this.onSecondaryContainer,
    this.secondaryContainer,
    this.tertiary,
    this.error,
    this.secondary,
    this.outline,
    this.background,
    this.onBackground,
    this.gradientTabColor,
  });

  ColorsScheme.fromJson(dynamic json) {
    primary = json['primary'];
    onPrimary = json['onPrimary'];
    onSurface = json['onSurface'];
    surface = json['surface'];
    onSecondaryContainer = json['onSecondaryContainer'];
    secondaryContainer = json['secondaryContainer'];
    tertiary = json['tertiary'];
    error = json['error'];
    secondary = json['secondary'];
    outline = json['outline'];
    background = json['background'];
    onBackground = json['onBackground'];
    gradientTabColor = json['gradientTabColor'] != null ? json['gradientTabColor'].cast<String>() : [];
  }

  String? primary;
  String? onPrimary;
  String? onSurface;
  String? surface;
  String? onSecondaryContainer;
  String? secondaryContainer;
  String? tertiary;
  String? error;
  String? secondary;
  String? outline;
  String? background;
  String? onBackground;
  List<String>? gradientTabColor;

  ColorSchemeOverride get colorSchemeOverride => ColorSchemeOverride(
        primary: _toColor(primary),
        onPrimary: _toColor(onPrimary),
        onSurface: _toColor(onSurface),
        surface: _toColor(surface),
        onSecondaryContainer: _toColor(onSecondaryContainer),
        secondaryContainer: _toColor(secondaryContainer),
        tertiary: _toColor(tertiary),
        error: _toColor(error),
        secondary: _toColor(secondary),
        outline: _toColor(outline),
        background: _toColor(background),
        onBackground: _toColor(onBackground),
      );

  List<CustomColor> get gradientTabColorOverride => (gradientTabColor ?? [])
      .map((color) => CustomColor(
            color: _toColor(color)!,
            blend: false,
          ))
      .toList();

  Color? _toColor(String? hexString, {Color? defaultColor}) {
    if (hexString == null) {
      return defaultColor;
    }

    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }
}
