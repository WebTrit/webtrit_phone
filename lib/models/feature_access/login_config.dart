import 'package:equatable/equatable.dart';

import '../embedded/embedded_data.dart';
import 'login_mode_action.dart';

/// Configuration for the login feature, defining UI titles and available login actions.
class LoginConfig extends Equatable {
  const LoginConfig({required this.actions, required this.titleL10n, this.launchLoginPage});

  final String? titleL10n;
  final List<LoginModeAction> actions;
  final EmbeddedData? launchLoginPage;

  /// Returns only the actions that represent embedded login configurations.
  List<LoginEmbeddedModeButton> get embeddedConfigurations => actions.whereType<LoginEmbeddedModeButton>().toList();

  /// Whether there are any embedded login pages available.
  bool get hasEmbeddedPage => embeddedConfigurations.isNotEmpty;

  /// Returns all available login actions.
  List<LoginModeAction> get launchButtons => actions.toList();

  @override
  List<Object?> get props => [titleL10n, actions, launchLoginPage];
}
