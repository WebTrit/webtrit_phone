import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/extended_text_style.dart';

class LoginModeSelectScreenStyle with Diagnosticable {
  const LoginModeSelectScreenStyle({
    this.signInTypeButton,
    this.signUpTypeButton,
    this.systemUiOverlayStyle,
    this.pictureLogoStyle,
    this.onboardingTextStyle,
    this.contentThemeOverride,
    this.applyToAppBar,
  });

  final ElevatedButtonStyleType? signInTypeButton;
  final ElevatedButtonStyleType? signUpTypeButton;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final ThemeImageStyle? pictureLogoStyle;
  final ExtendedTextStyle? onboardingTextStyle;
  final ThemeMode? contentThemeOverride;
  final bool? applyToAppBar;

  LoginModeSelectScreenStyle copyWith({
    ElevatedButtonStyleType? signInTypeButton,
    ElevatedButtonStyleType? signUpTypeButton,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    ThemeImageStyle? pictureLogoStyle,
    ExtendedTextStyle? onboardingTextStyle,
    ThemeMode? contentThemeOverride,
    bool? applyToAppBar,
  }) {
    return LoginModeSelectScreenStyle(
      signInTypeButton: signInTypeButton ?? this.signInTypeButton,
      signUpTypeButton: signUpTypeButton ?? this.signUpTypeButton,
      systemUiOverlayStyle: systemUiOverlayStyle ?? this.systemUiOverlayStyle,
      pictureLogoStyle: pictureLogoStyle ?? this.pictureLogoStyle,
      onboardingTextStyle: onboardingTextStyle ?? this.onboardingTextStyle,
      contentThemeOverride: contentThemeOverride ?? this.contentThemeOverride,
      applyToAppBar: applyToAppBar ?? this.applyToAppBar,
    );
  }

  static LoginModeSelectScreenStyle merge(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b) {
    if (a == null) return b ?? const LoginModeSelectScreenStyle();
    if (b == null) return a;

    return LoginModeSelectScreenStyle(
      signInTypeButton: b.signInTypeButton ?? a.signInTypeButton,
      signUpTypeButton: b.signUpTypeButton ?? a.signUpTypeButton,
      systemUiOverlayStyle: b.systemUiOverlayStyle ?? a.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.merge(a.pictureLogoStyle, b.pictureLogoStyle),
      onboardingTextStyle: ExtendedTextStyle.merge(a.onboardingTextStyle, b.onboardingTextStyle),
      contentThemeOverride: b.contentThemeOverride ?? a.contentThemeOverride,
      applyToAppBar: b.applyToAppBar ?? a.applyToAppBar,
    );
  }

  static LoginModeSelectScreenStyle lerp(LoginModeSelectScreenStyle? a, LoginModeSelectScreenStyle? b, double t) {
    return LoginModeSelectScreenStyle(
      signInTypeButton: LerpTools.lerpButtonStyleType(a?.signInTypeButton, b?.signInTypeButton, t),
      signUpTypeButton: LerpTools.lerpButtonStyleType(a?.signUpTypeButton, b?.signUpTypeButton, t),
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t),
      onboardingTextStyle: ExtendedTextStyle.lerp(a?.onboardingTextStyle, b?.onboardingTextStyle, t),
      contentThemeOverride: t < 0.5 ? a?.contentThemeOverride : b?.contentThemeOverride,
      applyToAppBar: t < 0.5 ? a?.applyToAppBar : b?.applyToAppBar,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signInTypeButton', signInTypeButton));
    properties.add(DiagnosticsProperty<ElevatedButtonStyleType?>('signUpTypeButton', signUpTypeButton));
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
    properties.add(DiagnosticsProperty<ExtendedTextStyle?>('onboardingTextStyle', onboardingTextStyle));
    properties.add(EnumProperty<ThemeMode?>('contentThemeOverride', contentThemeOverride));
    properties.add(DiagnosticsProperty<bool?>('applyToAppBar', applyToAppBar));
  }
}
