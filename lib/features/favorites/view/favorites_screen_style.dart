import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class FavoritesScreenStyle extends BaseScreenStyle with Diagnosticable {
  const FavoritesScreenStyle({
    super.background,
    super.appBarBackgroundColor,
    super.appBarBlurredSurface,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  FavoritesScreenStyle copyWith({
    BackgroundStyle? background,
    Color? appBarBackgroundColor,
    BlurredSurfaceStyle? appBarBlurredSurface,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return FavoritesScreenStyle(
      background: background ?? this.background,
      appBarBackgroundColor: appBarBackgroundColor ?? this.appBarBackgroundColor,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static FavoritesScreenStyle merge(FavoritesScreenStyle? a, FavoritesScreenStyle? b) {
    if (a == null) return b ?? const FavoritesScreenStyle();
    if (b == null) return a;

    return FavoritesScreenStyle(
      background: b.background ?? a.background,
      appBarBackgroundColor: b.appBarBackgroundColor ?? a.appBarBackgroundColor,
      appBarBlurredSurface: BlurredSurfaceStyle.merge(a.appBarBlurredSurface, b.appBarBlurredSurface),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static FavoritesScreenStyle lerp(FavoritesScreenStyle? a, FavoritesScreenStyle? b, double t) {
    return FavoritesScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      appBarBackgroundColor: Color.lerp(a?.appBarBackgroundColor, b?.appBarBackgroundColor, t),
      appBarBlurredSurface: BlurredSurfaceStyle.lerp(a?.appBarBlurredSurface, b?.appBarBlurredSurface, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride))
      ..add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
  }
}
