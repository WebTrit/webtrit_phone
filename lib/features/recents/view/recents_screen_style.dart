import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class RecentsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const RecentsScreenStyle({
    super.background,
    super.appBarBlurredSurface,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  RecentsScreenStyle copyWith({
    BackgroundStyle? background,
    BlurredSurfaceStyle? appBarBlurredSurface,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return RecentsScreenStyle(
      background: background ?? this.background,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static RecentsScreenStyle merge(RecentsScreenStyle? a, RecentsScreenStyle? b) {
    if (a == null) return b ?? const RecentsScreenStyle();
    if (b == null) return a;

    return RecentsScreenStyle(
      background: b.background ?? a.background,
      appBarBlurredSurface: BlurredSurfaceStyle.merge(a.appBarBlurredSurface, b.appBarBlurredSurface),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static RecentsScreenStyle lerp(RecentsScreenStyle? a, RecentsScreenStyle? b, double t) {
    return RecentsScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
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
