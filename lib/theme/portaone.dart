import 'package:flutter/material.dart';

import 'theme.dart';

const _seedColor = Color(0xFFF5841F);
const _darkBlue = Color(0xFF3D5B68);
const _darkBlue30 = Color(0xFFC5CED2);
const _green = Color(0xFF75B943);
const _light = Color(0xFFF3F5F6);
const _white = Color(0xFFFFFFFF);

const _red = Color(0xFFE74C3C);

const _gradientTop = CustomColor(
  color: Color(0xFF58A1A4),
  blend: false,
);

const _gradientBottom = CustomColor(
  color: Color(0xFF343D77),
  blend: false,
);

const portaoneThemeSettings = ThemeSettings(
  seedColor: _seedColor,
  lightColorSchemeOverride: ColorSchemeOverride(
    primary: _seedColor,
    secondary: _darkBlue,
    secondaryContainer: _darkBlue30,
    onSecondaryContainer: _darkBlue,
    tertiary: _green,
    error: _red,
    outline: _light,
    outlineVariant: _light,
    background: _white,
    surface: _light,
    onSurface: _darkBlue,
  ),
  primaryGradientColors: [_gradientTop, _gradientBottom],
);
