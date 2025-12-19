import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/theme.dart';

class LoginSwitchScreenStyle with Diagnosticable {
  LoginSwitchScreenStyle({this.systemUiOverlayStyle, this.pictureLogoStyle});

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final ThemeImageStyle? pictureLogoStyle;

  static LoginSwitchScreenStyle lerp(LoginSwitchScreenStyle? a, LoginSwitchScreenStyle? b, double t) {
    return LoginSwitchScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      pictureLogoStyle: ThemeImageStyle.lerp(a?.pictureLogoStyle, b?.pictureLogoStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle));
    properties.add(DiagnosticsProperty<ThemeImageStyle?>('pictureLogoStyle', pictureLogoStyle));
  }
}
