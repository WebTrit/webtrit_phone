import 'package:flutter/material.dart';

import 'settings_screen_style.dart';

class SettingsScreenStyles extends ThemeExtension<SettingsScreenStyles> {
  const SettingsScreenStyles({required this.primary});

  final SettingScreenStyle? primary;

  @override
  SettingsScreenStyles copyWith({SettingScreenStyle? primary}) {
    return SettingsScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<SettingsScreenStyles> lerp(ThemeExtension<SettingsScreenStyles>? other, double t) {
    if (other is! SettingsScreenStyles) return this;
    return SettingsScreenStyles(primary: SettingScreenStyle.lerp(primary, other.primary, t));
  }
}
