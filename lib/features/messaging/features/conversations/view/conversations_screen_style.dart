import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class ConversationsScreenStyle extends BaseScreenStyle with Diagnosticable {
  const ConversationsScreenStyle({
    super.background,
    super.appBarBackgroundColor,
    super.appBarBlurredSurface,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  ConversationsScreenStyle copyWith({
    BackgroundStyle? background,
    Color? appBarBackgroundColor,
    BlurredSurfaceStyle? appBarBlurredSurface,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return ConversationsScreenStyle(
      background: background ?? this.background,
      appBarBackgroundColor: appBarBackgroundColor ?? this.appBarBackgroundColor,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static ConversationsScreenStyle merge(ConversationsScreenStyle? a, ConversationsScreenStyle? b) {
    if (a == null) return b ?? const ConversationsScreenStyle();
    if (b == null) return a;

    return ConversationsScreenStyle(
      background: b.background ?? a.background,
      appBarBackgroundColor: b.appBarBackgroundColor ?? a.appBarBackgroundColor,
      appBarBlurredSurface: BlurredSurfaceStyle.merge(a.appBarBlurredSurface, b.appBarBlurredSurface),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static ConversationsScreenStyle lerp(ConversationsScreenStyle? a, ConversationsScreenStyle? b, double t) {
    return ConversationsScreenStyle(
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
