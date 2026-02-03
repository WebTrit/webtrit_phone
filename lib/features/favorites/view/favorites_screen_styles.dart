import 'package:flutter/material.dart';

import 'favorites_screen_style.dart';

class FavoritesScreenStyles extends ThemeExtension<FavoritesScreenStyles> {
  const FavoritesScreenStyles({required this.primary});

  final FavoritesScreenStyle? primary;

  @override
  FavoritesScreenStyles copyWith({FavoritesScreenStyle? primary}) {
    return FavoritesScreenStyles(primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<FavoritesScreenStyles> lerp(ThemeExtension<FavoritesScreenStyles>? other, double t) {
    if (other is! FavoritesScreenStyles) return this;
    return FavoritesScreenStyles(primary: FavoritesScreenStyle.lerp(primary, other.primary, t));
  }
}
