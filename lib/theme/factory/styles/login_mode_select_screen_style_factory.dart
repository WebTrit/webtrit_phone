import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';

class LoginModeSelectScreenStyleFactory implements ThemeStyleFactory<LoginModeSelectScreenStyles> {
  LoginModeSelectScreenStyleFactory(this.config);

  final LoginModeSelectPageConfig? config;

  @override
  LoginModeSelectScreenStyles create() {
    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        signInTypeButton: config?.buttonSignupStyleType,
        signUpTypeButton: config?.buttonLoginStyleType,
      ),
    );
  }
}
