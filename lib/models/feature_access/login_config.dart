import 'package:equatable/equatable.dart';

import '../embedded/embedded_data.dart';
import 'login_mode_action.dart';

/// Configuration for the login feature, defining UI titles and available login actions.
class LoginConfig extends Equatable {
  LoginConfig({
    required List<LoginModeAction> actions,
    required this.titleL10n,
    required this.launchLoginPage,
    List<String> signinOrder = const [],
  }) : _actions = List.unmodifiable(actions),
       signinOrder = List.unmodifiable(signinOrder);

  /// The key to use to look up the localized title.
  final String? titleL10n;

  /// Order of the sign-in tabs (login switch screen) by login type name.
  /// Empty falls back to the built-in default at the consumption site.
  final List<String> signinOrder;

  final List<LoginModeAction> _actions;

  /// Returns all available login actions.
  List<LoginModeAction> get actions => _actions;

  /// The embedded page to launch for login.
  final EmbeddedData? launchLoginPage;

  /// Returns only the actions that represent embedded login configurations.
  List<LoginEmbeddedModeButton> get embeddedConfigurations => _actions.whereType<LoginEmbeddedModeButton>().toList();

  /// Whether there are any embedded login pages available.
  bool get hasEmbeddedPage => embeddedConfigurations.isNotEmpty;

  /// Returns all available login actions.
  List<LoginModeAction> get launchButtons => _actions.toList();

  @override
  List<Object?> get props => [titleL10n, _actions, launchLoginPage, signinOrder];
}
