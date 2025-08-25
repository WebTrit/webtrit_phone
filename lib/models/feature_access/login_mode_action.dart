import '../embedded/embedded.dart';
import '../login_flavor.dart';

class LoginModeAction {
  LoginModeAction({
    required this.titleL10n,
    required this.flavor,
    required this.isLaunchButtonVisible,
  });

  final String titleL10n;
  final LoginFlavor flavor;
  final bool isLaunchButtonVisible;
}

class LoginEmbeddedModeButton extends LoginModeAction {
  LoginEmbeddedModeButton({
    required this.customLoginFeature,
    required super.titleL10n,
    required super.flavor,
    required super.isLaunchButtonVisible,
    required this.isLaunchScreen,
  });

  final EmbeddedData customLoginFeature;
  final bool isLaunchScreen;
}

extension LoginModeActionExtension on LoginModeAction {
  bool get isEmbeddedModeButton => this is LoginEmbeddedModeButton;

  LoginEmbeddedModeButton? get toEmbedded {
    if (this is LoginEmbeddedModeButton) {
      return this as LoginEmbeddedModeButton?;
    } else {
      return null;
    }
  }
}
