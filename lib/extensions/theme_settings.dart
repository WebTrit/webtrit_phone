import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

/// Theme-mode support derived purely from [ThemeSettings].
///
/// Lives on [ThemeSettings] (not [AppState]) so the theme can be provided down
/// the tree as an inherited value and consumed directly, without routing it
/// through the app bloc.
extension ThemeSettingsModeX on ThemeSettings {
  /// Whether the theme can switch between light and dark. False when the two
  /// color scheme configs are identical, in which case the single scheme is
  /// always rendered as light.
  bool get isThemeModeSupported => lightColorSchemeConfig != darkColorSchemeConfig;

  /// The mode actually applied for [mode]: the requested mode when the theme
  /// supports switching, otherwise [ThemeMode.light].
  ThemeMode effectiveThemeMode(ThemeMode mode) => isThemeModeSupported ? mode : ThemeMode.light;
}
