import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class EmbeddedScreenStyle extends BaseScreenStyle with Diagnosticable {
  const EmbeddedScreenStyle({
    super.background,
    super.appBarBlurredSurface,
    super.appBarTheme,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  EmbeddedScreenStyle copyWith({
    BackgroundStyle? background,
    BlurredSurfaceStyle? appBarBlurredSurface,
    AppBarTheme? appBarTheme,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return EmbeddedScreenStyle(
      background: background ?? this.background,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      appBarTheme: appBarTheme ?? this.appBarTheme,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static EmbeddedScreenStyle merge(EmbeddedScreenStyle? a, EmbeddedScreenStyle? b) {
    if (a == null) return b ?? const EmbeddedScreenStyle();
    if (b == null) return a;

    return EmbeddedScreenStyle(
      background: b.background ?? a.background,
      appBarBlurredSurface: b.appBarBlurredSurface ?? a.appBarBlurredSurface,
      appBarTheme: b.appBarTheme ?? a.appBarTheme,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static EmbeddedScreenStyle lerp(EmbeddedScreenStyle? a, EmbeddedScreenStyle? b, double t) {
    return EmbeddedScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
      appBarBlurredSurface: t < 0.5 ? a?.appBarBlurredSurface : b?.appBarBlurredSurface,
      appBarTheme: AppBarTheme.lerp(a?.appBarTheme, b?.appBarTheme, t),
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
