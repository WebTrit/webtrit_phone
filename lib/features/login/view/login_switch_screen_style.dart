import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

class LoginSwitchScreenStyle with Diagnosticable {
  const LoginSwitchScreenStyle({
    this.systemUiOverlayStyle,
    this.pictureLogoStyle,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final ThemeImageStyle? pictureLogoStyle;
  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  LoginSwitchScreenStyle copyWith({
    SystemUiOverlayStyle? systemUiOverlayStyle,
    ThemeImageStyle? pictureLogoStyle,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return LoginSwitchScreenStyle(
      systemUiOverlayStyle: systemUiOverlayStyle ?? this.systemUiOverlayStyle,
      pictureLogoStyle: pictureLogoStyle ?? this.pictureLogoStyle,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static LoginSwitchScreenStyle merge(LoginSwitchScreenStyle? a, LoginSwitchScreenStyle? b) {
    if (a == null) return b ?? const LoginSwitchScreenStyle();
    if (b == null) return a;

    return LoginSwitchScreenStyle(
      systemUiOverlayStyle: b.systemUiOverlayStyle ?? a.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.merge(a.pictureLogoStyle, b.pictureLogoStyle),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static LoginSwitchScreenStyle lerp(LoginSwitchScreenStyle? a, LoginSwitchScreenStyle? b, double t) {
    return LoginSwitchScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
    properties.add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride));
    properties.add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
  }
}
