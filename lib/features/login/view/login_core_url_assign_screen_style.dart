import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/blurred_surface.dart';

class LoginCoreUrlAssignScreenStyle with Diagnosticable {
  const LoginCoreUrlAssignScreenStyle({
    this.systemUiOverlayStyle,
    this.contentThemeOverride,
    this.applyToAppBar,
    this.background,
    this.appBarBlurredSurface,
    this.appBarTheme,
  });

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;
  final BackgroundStyle? background;
  final BlurredSurfaceStyle? appBarBlurredSurface;
  final AppBarTheme? appBarTheme;

  LoginCoreUrlAssignScreenStyle copyWith({
    SystemUiOverlayStyle? systemUiOverlayStyle,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
    BackgroundStyle? background,
    BlurredSurfaceStyle? appBarBlurredSurface,
    AppBarTheme? appBarTheme,
  }) {
    return LoginCoreUrlAssignScreenStyle(
      systemUiOverlayStyle: systemUiOverlayStyle ?? this.systemUiOverlayStyle,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
      background: background ?? this.background,
      appBarBlurredSurface: appBarBlurredSurface ?? this.appBarBlurredSurface,
      appBarTheme: appBarTheme ?? this.appBarTheme,
    );
  }

  static LoginCoreUrlAssignScreenStyle merge(LoginCoreUrlAssignScreenStyle? a, LoginCoreUrlAssignScreenStyle? b) {
    if (a == null) return b ?? const LoginCoreUrlAssignScreenStyle();
    if (b == null) return a;

    return LoginCoreUrlAssignScreenStyle(
      systemUiOverlayStyle: b.systemUiOverlayStyle ?? a.systemUiOverlayStyle,
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
      background: b.background ?? a.background,
      appBarBlurredSurface: b.appBarBlurredSurface ?? a.appBarBlurredSurface,
      appBarTheme: b.appBarTheme ?? a.appBarTheme,
    );
  }

  static LoginCoreUrlAssignScreenStyle lerp(
    LoginCoreUrlAssignScreenStyle? a,
    LoginCoreUrlAssignScreenStyle? b,
    double t,
  ) {
    return LoginCoreUrlAssignScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
      background: BackgroundStyle.lerp(a?.background, b?.background, t),
      appBarBlurredSurface: t < 0.5 ? a?.appBarBlurredSurface : b?.appBarBlurredSurface,
      appBarTheme: AppBarTheme.lerp(a?.appBarTheme, b?.appBarTheme, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride));
    properties.add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
    properties.add(DiagnosticsProperty<BackgroundStyle?>('background', background));
    properties.add(DiagnosticsProperty<BlurredSurfaceStyle?>('appBarBlurredSurface', appBarBlurredSurface));
    properties.add(DiagnosticsProperty<AppBarTheme?>('appBarTheme', appBarTheme));
  }
}
