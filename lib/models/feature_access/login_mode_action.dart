import 'login_embedded.dart';

import '../login_flavor.dart';

class LoginModeAction {
  final String titleL10n;
  final LoginFlavor flavor;

  LoginModeAction({
    required this.titleL10n,
    required this.flavor,
  });
}

class LoginEmbeddedModeButton extends LoginModeAction {
  final LoginEmbedded customLoginFeature;

  LoginEmbeddedModeButton({
    required this.customLoginFeature,
    required super.titleL10n,
    required super.flavor,
  });
}
