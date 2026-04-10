import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class EmbeddedScreenStyle extends BaseScreenStyle with Diagnosticable {
  const EmbeddedScreenStyle({super.background, this.contentThemeOverride, this.applyToAppBar});

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  EmbeddedScreenStyle copyWith({BackgroundStyle? background, ThemeMode? contentThemeOverride, bool? applyToAppBar}) {
    return EmbeddedScreenStyle(
      background: background ?? this.background,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static EmbeddedScreenStyle merge(EmbeddedScreenStyle? a, EmbeddedScreenStyle? b) {
    if (a == null) return b ?? const EmbeddedScreenStyle();
    if (b == null) return a;

    return EmbeddedScreenStyle(
      background: b.background ?? a.background,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static EmbeddedScreenStyle lerp(EmbeddedScreenStyle? a, EmbeddedScreenStyle? b, double t) {
    return EmbeddedScreenStyle(
      background: BaseScreenStyle.lerp(a?.background, b?.background, t),
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
