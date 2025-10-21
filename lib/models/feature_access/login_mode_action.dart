import '../embedded/embedded.dart';
import '../login_flavor.dart';

sealed class LoginModeAction {
  const LoginModeAction();

  String get titleL10n;

  LoginFlavor get flavor;
}

final class LoginDefaultModeAction extends LoginModeAction {
  const LoginDefaultModeAction({
    required this.titleL10n,
    required this.flavor,
  });

  @override
  final String titleL10n;

  @override
  final LoginFlavor flavor;
}

final class LoginEmbeddedModeButton extends LoginModeAction {
  const LoginEmbeddedModeButton({
    required this.titleL10n,
    required this.flavor,
    required this.customLoginFeature,
  });

  @override
  final String titleL10n;

  @override
  final LoginFlavor flavor;

  final EmbeddedData customLoginFeature;
}
