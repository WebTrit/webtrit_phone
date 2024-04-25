import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/app_icon.dart';

class AppIconStyles extends ThemeExtension<AppIconStyles> {
  const AppIconStyles({
    required this.primary,
  });

  final AppIconStyle? primary;

  @override
  ThemeExtension<AppIconStyles> copyWith({
    AppIconStyle? primary,
  }) {
    return AppIconStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<AppIconStyles> lerp(ThemeExtension<AppIconStyles>? other, double t) {
    if (other == null || primary == null || other is! AppIconStyles) {
      return this;
    }

    return AppIconStyles(primary: AppIconStyle.lerp(primary, other.primary, t));
  }
}
