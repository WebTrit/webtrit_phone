import 'embedded_login.dart';

import '../login_flavor.dart';

class LoginModeAction {
  final String titleL10n;
  final LoginFlavor flavor;

  LoginModeAction({
    required this.titleL10n,
    required this.flavor,
  });
}

class EmbeddedLoginModeButton extends LoginModeAction {
  final EmbeddedLogin customLoginFeature;

  EmbeddedLoginModeButton({
    required this.customLoginFeature,
    required super.titleL10n,
    required super.flavor,
  });
}
