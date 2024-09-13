import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_compose_settings.freezed.dart';

part 'ui_compose_settings.g.dart';

@freezed
class UiComposeSettings with _$UiComposeSettings {
  const UiComposeSettings._();

  const factory UiComposeSettings({
    UiComposeSettingsLogin? login,
  }) = _UiComposeSettings;

  factory UiComposeSettings.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsFromJson(json);

  bool get isCustomSignInEnabled => login?.customSignIn?.enabled == true;
}

@freezed
class UiComposeSettingsLogin with _$UiComposeSettingsLogin {
  const UiComposeSettingsLogin._();

  const factory UiComposeSettingsLogin({
    UiComposeSettingsLoginCustomSignIn? customSignIn,
  }) = _UiComposeSettingsLogin;

  factory UiComposeSettingsLogin.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsLoginFromJson(json);
}

@freezed
class UiComposeSettingsLoginCustomSignIn with _$UiComposeSettingsLoginCustomSignIn {
  const UiComposeSettingsLoginCustomSignIn._();

  const factory UiComposeSettingsLoginCustomSignIn({
    bool? enabled,
    String? titleL10n,
    String? url,
  }) = _UiComposeSettingsLoginCustomSignIn;

  factory UiComposeSettingsLoginCustomSignIn.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsLoginCustomSignInFromJson(json);
}
