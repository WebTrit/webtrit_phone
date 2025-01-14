import 'package:freezed_annotation/freezed_annotation.dart';

import 'elevated_button_style_type.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@Freezed()
class ThemePageConfig with _$ThemePageConfig {
  @JsonSerializable(explicitToJson: true)
  // ignore: invalid_annotation_target
  const factory ThemePageConfig({
    @Default(LoginPageConfig()) LoginPageConfig login,
    @Default(AboutPageConfig()) AboutPageConfig about,
  }) = _ThemePageConfig;

  factory ThemePageConfig.fromJson(Map<String, dynamic> json) => _$ThemePageConfigFromJson(json);
}

@Freezed()
class LoginPageConfig with _$LoginPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginPageConfig({
    @Default(LoginModeSelectPageConfig()) LoginModeSelectPageConfig modeSelect,
  }) = _LoginPageConfig;

  factory LoginPageConfig.fromJson(Map<String, dynamic> json) => _$LoginPageConfigFromJson(json);
}

@Freezed()
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginModeSelectPageConfig({
    String? title,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonLoginStyleType,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonSignupStyleType,
  }) = _LoginModeSelectPageConfig;

  factory LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) => _$LoginModeSelectPageConfigFromJson(json);
}

@Freezed()
class AboutPageConfig with _$AboutPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AboutPageConfig({
    String? picture,
  }) = _AboutPageConfig;

  factory AboutPageConfig.fromJson(Map<String, dynamic> json) => _$AboutPageConfigFromJson(json);
}
